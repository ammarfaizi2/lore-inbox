Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281723AbRKZO4n>; Mon, 26 Nov 2001 09:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281717AbRKZO4c>; Mon, 26 Nov 2001 09:56:32 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:50955 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S281718AbRKZO4O>; Mon, 26 Nov 2001 09:56:14 -0500
Date: Mon, 26 Nov 2001 09:56:13 -0500
Message-Id: <200111261456.fAQEuDg01515@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.15-pre1:  "bogus" message with reiserfs root and other weirdness
X-Newsgroups: linux.kernel
In-Reply-To: <E166e8A-0000t2-00@mrvdom02.schlund.de>
In-Reply-To: <6893478.1006329318464.JavaMail.ground12@jippii.fi> <20011121111811.P1308@lynx.no>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Reply-to: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E166e8A-0000t2-00@mrvdom02.schlund.de> linux-kernel@borntraeger.net wrote:
| > > Machine booted ok and everything seemed to be ok, but i noticed a few
| > > weird messages in boot messages right before mounting the root-partition:
| > > FAT: bogus logical sector size 0
| > > FAT: bogus logical sector size 0
| > When the kernel is booting, it doesn't know the filesystem type of the
| > root fs, so it tries to mount the root device using all of the compiled-in
| > fs drivers, in the order they are listed in fs/Makefile.in.
| > It appears that the fat driver doesn't even check for a magic when it
| > starts trying to mount the filesystem, so it proceeds directly to
| 
| To be complete we should also apply this patch.

To be totally honest I think this is the wrong way to go. Like masking
the symptoms instead of treating the disease. The problem is that the
FAT driver seems to not check f/s type before claiming a f/s as its own.
The better solution is to put in a check before going forward with using
the f/s as FAT.

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
