Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291637AbSBXW3J>; Sun, 24 Feb 2002 17:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291700AbSBXW3C>; Sun, 24 Feb 2002 17:29:02 -0500
Received: from a213-22-82-74.netcabo.pt ([213.22.82.74]:1797 "EHLO
	skyblade.homeip.net") by vger.kernel.org with ESMTP
	id <S291676AbSBXW2e>; Sun, 24 Feb 2002 17:28:34 -0500
Date: Sun, 24 Feb 2002 22:28:34 +0000 (WET)
From: =?iso-8859-15?Q?Jos=E9_Carlos_Monteiro?= <jcm@skyblade.homeip.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Emu10k1 SPDIF passthru doesn't work if CONFIG_NOHIGHMEM is not
 enabled
Message-ID: <Pine.LNX.4.33.0202242226510.2026-100000@skyblade.homeip.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
After some more careful testing, I was able to identify the exact moment
when the changes in the Linux kernel broke SPDIF passthru of Emu10k1
cards. I tested all the pre-patches between kernels 2.4.12 and 2.4.13
and I found that kernel 2.4.13-pre2 was the one that broke it. Up until
2.4.13-pre1, everything works fine. From 2.4.13-pre2 on, passthru sound
is broken (if kernel option CONFIG_HIGHMEM4G or CONFIG_HIGHMEM64G is
used).

According to the kernel Changelog, it appears that one of these changes
was the responsible for it:

2.4.13-pre2:
- Alan Cox: more merging
- Ben Fennema: UDF module license
- Jeff Mahoney: reiserfs endian safeness
- Chris Mason: reiserfs O_SYNC/fsync performance improvements
- Jean Tourrilhes: wireless extension update
- Joerg Reuter: AX.25 updates
- David Miller: 64-bit DMA interfaces


I hope this helps and I hope you can fix it soon.

Regards
Zé

PS- I'm not a subscriber of the lkml. Please send any messages to
jcm@netcabo.pt if you want to contact me.

On Thu, 21 Feb 2002, José Carlos Monteiro wrote:
> Emu10k1 SPDIF passthru with the creative/kernel OSS driver only works
> if the kernel option CONFIG_NOHIGHMEM is set. If one of the other two
> related options (CONFIG_HIGHMEM4G or CONFIG_HIGHMEM64G) is used
> instead, the sound card is unable to "pass" AC3 streams "through" the
> SPDIF output; only PCM and multi-channel sound gets to the
> amp/speakers. This bug is present since kernel 2.4.13 (with kernel
> 2.4.12 and earlier it worked fine),and it's still present in 2.4.18-rc4

