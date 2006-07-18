Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWGRARQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWGRARQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 20:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWGRARP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 20:17:15 -0400
Received: from mail.suse.de ([195.135.220.2]:39583 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751237AbWGRARO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 20:17:14 -0400
From: Neil Brown <neilb@suse.de>
To: Petr Vyskocil <petr@anime.cz>
Date: Tue, 18 Jul 2006 10:16:27 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17596.10331.396365.132469@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.17 and RAID5 Grow Problem (critical section backup)
In-Reply-To: message from Petr Vyskocil on Tuesday July 11
References: <Pine.LNX.4.64.0607070830450.2648@p34.internal.lan>
	<Pine.LNX.4.64.0607070845280.2648@p34.internal.lan>
	<Pine.LNX.4.64.0607070849140.3010@p34.internal.lan>
	<Pine.LNX.4.64.0607071037190.5153@p34.internal.lan>
	<17582.55703.209583.446356@cse.unsw.edu.au>
	<Pine.LNX.4.64.0607101747160.2603@p34.internal.lan>
	<Pine.LNX.4.61.0607110026030.5420@yvahk01.tjqt.qr>
	<Pine.LNX.4.64.0607101830130.2603@p34.internal.lan>
	<Pine.LNX.4.61.0607110950450.30961@yvahk01.tjqt.qr>
	<e8vplt$fgv$1@sea.gmane.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday July 11, petr@anime.cz wrote:
> >>> Hm, what's superblock 0.91? It is not mentioned in mdadm.8.
> >>>
> >> Not sure, the block version perhaps?
> >>
> > Well yes of course, but what characteristics? The manual only lists
> >  0, 0.90, default
> >  1, 1.0, 1.1, 1.2
> > No 0.91 :(
> 
> 
> AFAICR superblock version gets raised by 0.01 for the duration of 
> reshape, so that non-reshape aware kernels do not try to assemble it 
> (and cause data corruption).

Exactly.  The following will be in the next mdadm - unless someone
wants to re-write it for me using shorter sentences :-)

NeilBrown



diff .prev/md.4 ./md.4
--- .prev/md.4	2006-06-20 10:01:17.000000000 +1000
+++ ./md.4	2006-07-18 10:14:47.000000000 +1000
@@ -74,6 +74,14 @@ UUID
 a 128 bit Universally Unique Identifier that identifies the array that
 this device is part of.
 
+When a version 0.90 array is being reshaped (e.g. adding extra devices
+to a RAID5), the version number is temporarily set to 0.91.  This
+ensures that if the reshape process is stopped in the middle (e.g. by
+a system crash) and the machine boots into an older kernel that does
+not support reshaping, then the array will not be assembled (which
+would cause data corruption) but will be left untouched until a kernel
+that can complete the reshape processes is used.
+
 .SS ARRAYS WITHOUT SUPERBLOCKS
 While it is usually best to create arrays with superblocks so that
 they can be assembled reliably, there are some circumstances where an
