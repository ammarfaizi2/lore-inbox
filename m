Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318404AbSGaQuy>; Wed, 31 Jul 2002 12:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318405AbSGaQuy>; Wed, 31 Jul 2002 12:50:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35333 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318404AbSGaQux>;
	Wed, 31 Jul 2002 12:50:53 -0400
Message-ID: <3D481855.35A64873@zip.com.au>
Date: Wed, 31 Jul 2002 10:03:17 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: BUG at rmap.c:212
References: <AE2FE25828@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> 
> ...
> > > Probably because of your code did not do anything special when
> > > 'Not found. This should NEVER happen!' code path triggers.
> > Of course, ntpd is probably running into a different problem,
> > but the printk's enabled with DEBUG_RMAP should give us some
> > hints.
> 
> No nvidia here. Boot, start X, quit X, run updatedb, reboot...
> cat /proc/`pidof ntpd`/maps says that it has mmaped only ntpd and
> few libraries from /lib. I hope that printed values will have
> some value for you. And btw, ntpd uses some mlock*() call, it has status
> 'SL' in process list. Do you know how to find what memory it has locked?

It's good that this it nice and reproducible, thanks.

Linus, can we please not have that BUG() in 2.5.30?


--- 2.5.29/mm/rmap.c~no-bug	Wed Jul 31 09:58:47 2002
+++ 2.5.29-akpm/mm/rmap.c	Wed Jul 31 09:58:53 2002
@@ -205,8 +205,6 @@ void page_remove_rmap(struct page * page
 	}
 	printk("\n");
 	printk(KERN_ERR "page_remove_rmap: driver cleared PG_reserved ?\n");
-#else
-	BUG();
 #endif
 
 out:

.
