Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbTEZEr7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 00:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264259AbTEZEr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 00:47:58 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:24338 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S264257AbTEZEr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 00:47:57 -0400
Message-ID: <3ED1A0FE.3000101@kolumbus.fi>
Date: Mon, 26 May 2003 08:07:10 +0300
From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@digeo.com>,
       Hugh Dickins <hugh@veritas.com>, LW@KARO-electronics.de,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >=	2.5.30(at
 least))
References: <20030523175413.A4584@flint.arm.linux.org.uk>	 <Pine.LNX.4.44.0305231821460.1690-100000@localhost.localdomain>	 <20030523112926.7c864263.akpm@digeo.com>	 <20030523193458.B4584@flint.arm.linux.org.uk> <1053919171.14018.2.camel@rth.ninka.net>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 26.05.2003 08:02:17,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 26.05.2003 08:01:48,
	Serialize complete at 26.05.2003 08:01:48
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think the flush_dcache_page thing is done almost anywhere in the 
block/driver level right now. And we shouldn't be doing io reads to 
pagecache pages with user mappings anyway normally. direct-io is a 
different thing.

--Mika


David S. Miller wrote:

>On Fri, 2003-05-23 at 11:34, Russell King wrote:
>  
>
>>So no, I don't think it is a device driver issue at all.
>>
>>DaveM?
>>    
>>
>
>Oh yes, this part is.  If you don't ensure this, everything
>breaks.
>
>At the end of an I/O operation, say to a page cache page, that
>data ought to be visible equally to a userspace vs. a kernel
>space mapping to that page.
>
>For example, this is why we use language about "cpu visibility" in the
>DMA api documentation and not "kernel cpu visibility" :-)  And because
>PIO transfers are basically pseudo-DMA they need to make the same exact
>guarentees.
>
>If you've been living in a world where you didn't think this is
>necessary, I certainly feel bad for you :-)
>
>  
>


