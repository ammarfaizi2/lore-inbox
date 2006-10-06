Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422794AbWJFSEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422794AbWJFSEA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422795AbWJFSEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:04:00 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:29359 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422794AbWJFSD6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:03:58 -0400
Subject: Re: 2.6.18-mm2 boot failure on x86-64
From: Steve Fox <drfickle@us.ibm.com>
To: Mel Gorman <mel@skynet.ie>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, Andi Kleen <ak@suse.de>,
       Badari Pulavarty <pbadari@us.ibm.com>, Martin Bligh <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, kmannth@us.ibm.com,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <20061006171105.GC9881@skynet.ie>
References: <20060928014623.ccc9b885.akpm@osdl.org>
	 <200610052105.00359.ak@suse.de> <1160080954.29690.44.camel@flooterbu>
	 <200610052250.55146.ak@suse.de> <1160101394.29690.48.camel@flooterbu>
	 <20061006143312.GB9881@skynet.ie> <20061006153629.GA19756@in.ibm.com>
	 <20061006171105.GC9881@skynet.ie>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 06 Oct 2006 13:03:50 -0500
Message-Id: <1160157830.29690.66.camel@flooterbu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-06 at 18:11 +0100, Mel Gorman wrote:
> On (06/10/06 11:36), Vivek Goyal didst pronounce:
> > Where is bss placed in physical memory? I guess bss_start and bss_stop
> > from System.map will tell us. That will confirm that above memset step is
> > stomping over bss. Then we have to just find that somewhere probably
> > we allocated wrong physical memory area for bootmem allocator map.
> > 
> 
> BSS is at 0x643000 -> 0x777BC4
> init_bootmem wipes from 0x777000 -> 0x8F7000
> 
> So the BSS bytes from 0x777000 ->0x777BC4 (which looks very suspiciously
> pile a page alignment of addr & PAGE_MASK) gets set to 0xFF. One possible
> fix is below. It adds a check in bad_addr() to see if the BSS section is
> about to be used for bootmap. It Seems To Work For Me (tm) and illustrates
> the source of the problem even if it's not the 100% correct fix.

I was able to boot the machine with Mel's patch applied on top of
-git22.

-- 

Steve Fox
IBM Linux Technology Center
