Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274071AbRISOVj>; Wed, 19 Sep 2001 10:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274070AbRISOV3>; Wed, 19 Sep 2001 10:21:29 -0400
Received: from prfdec.natur.cuni.cz ([195.113.56.1]:31751 "EHLO
	prfdec.natur.cuni.cz") by vger.kernel.org with ESMTP
	id <S274069AbRISOVV>; Wed, 19 Sep 2001 10:21:21 -0400
X-Envelope-From: mmokrejs
Posted-Date: Wed, 19 Sep 2001 16:21:43 +0200 (MET DST)
Date: Wed, 19 Sep 2001 16:21:43 +0200 (MET DST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: __alloc_pages: 0-order allocation failed still in -pre12
In-Reply-To: <Pine.OSF.4.21.0109121502420.18976-100000@prfdec.natur.cuni.cz>
Message-ID: <Pine.OSF.4.21.0109191615070.3826-100000@prfdec.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I tried 2.4.10-pre12 and run some mysql big tests (actually
mysql/tests/fork_big.pl ). And, the load is coming up and down from 17 to
6 .... and now, it's 1.7 only and I see in dmesg:

__alloc_pages: 0-order allocation failed (gfp=0x20/0) from c012e3e2
__alloc_pages: 0-order allocation failed (gfp=0x20/0) from c012e3e2

Filename                        Type            Size    Used    Priority
/dev/sda2                       partition       2097136 41392   -1

The swap usage grew up from 11MB 40MB.

free gives:
             total       used       free     shared    buffers     cached
Mem:       1029776    1007360      22416          0       4548     463936
-/+ buffers/cache:     538876     490900
Swap:      2097136      41392    2055744

The system started to page-out when there were almost no buffers available
and many cached pages. The system started after bootup with cached=18k or
something like that.

/proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  1054490624 880287744 174202880        0  4653056 460627968
Swap: 2147467264 42909696 2104557568
MemTotal:      1029776 kB
MemFree:        170120 kB
MemShared:           0 kB
Buffers:          4544 kB
Cached:         448416 kB
SwapCached:       1416 kB
Active:         377868 kB
Inactive:        76508 kB
HighTotal:      131072 kB
HighFree:         2044 kB
LowTotal:       898704 kB
LowFree:        168076 kB
SwapTotal:     2097136 kB
SwapFree:      2055232 kB


I have to say I've been using for a week without any "0-order allocation
failed" patch from Marcelo. Now I see am back to the old stage. ;(

> > You can get the patch from Marcelo's post on lkml on Aug 22 under the
> > subject "Re: With Daniel Phillips Patch (was: aic7xxx with 2.4.9 on
> > 7899P)".  Note the correction posted in his next message in the thread.
> > It applies to 2.4.9.  Please try it and see if these failures go away.

Please Cc: me in reply, if possible.
-- 
Martin Mokrejs - PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany


