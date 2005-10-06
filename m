Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbVJFOnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbVJFOnc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 10:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbVJFOnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 10:43:32 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:36887 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751051AbVJFOnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 10:43:31 -0400
Date: Thu, 06 Oct 2005 23:39:09 +0900 (JST)
Message-Id: <20051006.233909.730565127.hyoshiok@miraclelinux.com>
To: noboru.obata.ar@hitachi.com
Cc: linux-kernel@vger.kernel.org, hyoshiok@miraclelinux.com
Subject: Re: Linux Kernel Dump Summit 2005
From: Hiro Yoshioka <hyoshiok@miraclelinux.com>
In-Reply-To: <20051006.211718.74749573.noboru.obata.ar@hitachi.com>
References: <20050921.205550.927509530.hyoshiok@miraclelinux.com>
	<20051006.211718.74749573.noboru.obata.ar@hitachi.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Obata san,

Thanks for your comments. I really appreciate your effort.

Regards,
  Hiro

From: OBATA Noboru <noboru.obata.ar@hitachi.com>
Subject: Re: Linux Kernel Dump Summit 2005
Date: Thu, 06 Oct 2005 21:17:18 +0900 (JST)
Message-ID: <20051006.211718.74749573.noboru.obata.ar@hitachi.com>

> Hi, Hiro,
> 
> On Wed, 21 Sep 2005, Hiro Yoshioka wrote:
> > 
> > We had a Linux Kernel Dump Summit 2005.
> 
> > - We need a partial dump
> > - We have to minimize the down time
> > 
> > - We have to dump all memory
> >     how can we distinguish from the kernel and user if
> >     kernel data is corrupted
> 
> As memory size grows, the time and space for capturing kernel
> crash dump really matter.
> 
> We discussed two strategies in the dump summit.
> 
> 	1. Partial dump
> 	2. Full dump with compression
> 
> 
> PARTIAL DUMP
> ============
> 
> Partial dump captures only pages that are essential for later
> analysis, possibly by using some mark in mem_map[].
> 
> This certainly reduces both time and space of crash dump, but
> there is a risk because no one can guarantee that a dropped page
> is really unnecessary in analysis (it can be a tragedy if
> analysis went unsolved because of the dropped page).
> 
> Another risk is a corruption of mem_map[] (or other kernel
> structure), which makes the identification of necessary pages
> unreliable.
> 
> So there would be best if a user can select the level of partial
> dump.  A careful user may always choose a full dump, while a
> user who is tracking the well-reproducible kernel bug may choose
> fast and small dump.
> 
> 
> FULL DUMP WITH COMPRESSION
> ==========================
> 
> Those who still want a full dump, including me, are interested
> in dump compression.  For example, the LKCD format (at least v7
> format) supports pagewise compression with the deflate
> algorithm.  A dump analyze tool "crash" can transparently
> analyze the compressed dump file in this format.
> 
> The compression will reduce the storage space at certain degree,
> and may also reduce the time if a dump process were I/O bounded.
> 
> 
> WHICH IS BETTER?
> ================
> 
> I wrote a small compression tool for LKCD v7 format to see how
> effective the compression is, and it turned out that the time
> and size of compression were very much similar to that of gzip,
> not surprisingly.
> 
> Compressing a 32GB dump file took about 40 minutes on Pentium 4
> Xeon 3.0GHz, which is not good enough because the dump without
> compression took only 5 minutes; eight times slower.
> 
> Besides, the compress ratios were somewhat picky.  Some dump
> files could not be compressed well (the worst case I found was
> only 10% reduction in size).
> 
> 
> After examining the LKCD compress format, I must conclude that
> the partial dump is the only way to go when time and size really
> matter.
> 
> Now I'd like to see how effective the existing partial dump
> functionalities are.
> 
> 
> Regards,
> 
> -- 
> OBATA Noboru (noboru.obata.ar@hitachi.com)
