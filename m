Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265340AbUBPEIT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 23:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265366AbUBPEIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 23:08:19 -0500
Received: from topaz.cx ([66.220.6.227]:61888 "EHLO mail.topaz.cx")
	by vger.kernel.org with ESMTP id S265340AbUBPEIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 23:08:17 -0500
Date: Sun, 15 Feb 2004 23:08:11 -0500
From: Chip Salzenberg <chip@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.3-rc3 - IDE DMA errors on Thinkpad A30
Message-ID: <20040216040811.GF3789@perlsupport.com>
References: <E1AsO6X-0003hW-1u@tytlal> <200402151658.57710.bzolnier@elka.pw.edu.pl> <20040215163438.GC3789@perlsupport.com> <200402151808.42611.bzolnier@elka.pw.edu.pl> <20040216005523.GD3789@perlsupport.com> <40302783.6020505@pobox.com> <20040216033740.GE3789@perlsupport.com> <40303D59.4030605@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40303D59.4030605@pobox.com>
X-Message-Flag: OUTLOOK ERROR: Message text violates P.A.T.R.I.O.T. act
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Jeff Garzik:
> Other equally smart people argue that modern IDE disks reserve space for 
> remapping bad sectors.  If you run out of sectors that the drive is 
> willing to silently remap for you, you should toss the disk and buy a 
> new one.

OK, I get the theory.  But AFAICT this drive hasn't remapped *any*
sectors.  Yet.  (Which would not be impossible; it's a relatively
new drive, a few months old at most.)  Quoting smartctl:

ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  5 Reallocated_Sector_Ct   0x0033   100   100   050    Pre-fail  Always       -       0
196 Reallocated_Event_Count 0x0032   100   100   000    Old_age   Always       -       0
197 Current_Pending_Sector  0x0032   100   100   000    Old_age   Always       -       3
198 Offline_Uncorrectable   0x0030   100   100   000    Old_age   Offline      -       0

This seems to suggest that there are three *candidate* sectors with
reallocation pending, none of which have actually been remapped (yet).
If so, drive replacement would perhaps be premature.

I suppose it's time to read up on the details of the SMART spec.
-- 
Chip Salzenberg               - a.k.a. -               <chip@pobox.com>
"I wanted to play hopscotch with the impenetrable mystery of existence,
    but he stepped in a wormhole and had to go in early."  // MST3K
