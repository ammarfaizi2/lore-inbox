Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286321AbRLJRSR>; Mon, 10 Dec 2001 12:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286316AbRLJRSB>; Mon, 10 Dec 2001 12:18:01 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:31663 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S286221AbRLJRRo>; Mon, 10 Dec 2001 12:17:44 -0500
Date: Mon, 10 Dec 2001 09:16:53 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: volodya@mindspring.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: mm question
Message-ID: <2953465770.1007975813@mbligh.des.sequent.com>
In-Reply-To: <2953042101.1007975389@mbligh.des.sequent.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> > I was hoping for something more elegant, but I am not adverse to writing
>>> > my own get_free_page_from_range().
>>> 
>>> Thats not a trivial task.
>> 
>> Better than giving up.. Unfortunately looking around in
>> linux/Documentation and drivers did not yield much in terms of
>> explanation. I know I can use mem_map_reserve to reserve a page but I
>> don't know how to get page struct from a physical address nor which lock
>> to use when messing with this.
> 
> If you don't have any ISA DMA going on in the system, you might consider
> bastardising the ZONE_DMA page range by moving the boundary up to
> 64Mb, then fixing the allocator not to fail back ZONE_NORMAL et al 
> allocations to ZONE_DMA. Thus what was originally ZONE_DMA becomes 
> a sort of ZONE_NO_DMA. Not in the slightest bit pretty, but it might be easier 
> to implement. Depends if you ever want it to get back into the main tree,
> I guess ;-)

Of course, if you just did that, you'd never use the ZONE_DMA memory, so
that's pretty pointless ;-) You need to create an alloc call with an *option* 
to force alloc out of ZONE_NORMAL, not make no fallback the default. 

M.

