Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289164AbSAGKPQ>; Mon, 7 Jan 2002 05:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289167AbSAGKPI>; Mon, 7 Jan 2002 05:15:08 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:57863 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289164AbSAGKO4>; Mon, 7 Jan 2002 05:14:56 -0500
Message-ID: <3C3973D9.CF689345@zip.com.au>
Date: Mon, 07 Jan 2002 02:09:29 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Guenther <rguenth@tat.physik.uni-tuebingen.de>
CC: Oliver Paukstadt <pstadt@stud.fh-heilbronn.de>,
        Matti Aarnio <matti.aarnio@zmailer.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org
Subject: Re: 2.4.17 RAID-1 EXT3  reliable to hang....
In-Reply-To: <Pine.LNX.4.33.0201070933590.4076-100000@lola.stud.fh-heilbronn.de> <Pine.LNX.4.33.0201071047410.17279-100000@bellatrix.tat.physik.uni-tuebingen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Guenther wrote:
> 
> On Mon, 7 Jan 2002, Oliver Paukstadt wrote:
> 
> > Heavy traffic on ext3 seems to cause short system freezes.
> 
> I see dropped frames while watching TV (bttv chip, xawtv in overlay mode,
> XFree 4.1.0)
> since I use ext3 (2.4.16&17). Always during disk activity (IDE, umask irq
> and dma enabled). From what I know the bttv driver does it seems to loose
> interrupts!? This doesnt happen with ext2.

ext3 never blocks interrupts.  It _may_ cause increased interrupt
latency than ext2 by the very large linear writes which it does.  These
may cause other parts of the kernel to block interrupts for longer.

However, more likely that it's a scheduling latency problem.  Sigh.
I spent *ages* on the ext3 buffer writeout code and it's still not
ideal.  Can you test with this patch applied?

http://www.zipworld.com.au/~akpm/linux/2.4/2.4.18-pre1/mini-ll.patch

It should go into 2.4.17 OK.

> ...
> By any chance, is some global lock held during any IO intensive part of
> ext3?

Yes, a couple.  But on uniprocessor it's more a matter of the kernel
failing to context switch promptly.

-
