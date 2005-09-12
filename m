Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbVILJwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbVILJwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 05:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbVILJwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 05:52:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11420 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751271AbVILJwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 05:52:15 -0400
Date: Mon, 12 Sep 2005 02:51:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jim McCloskey <mcclosk@ucsc.edu>
Cc: linux-kernel@vger.kernel.org, Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PROBLEM] mtrr's not set, 2.6.13
Message-Id: <20050912025120.4016c36b.akpm@osdl.org>
In-Reply-To: <20050912091021.GA2859@branci40>
References: <20050912091021.GA2859@branci40>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim McCloskey <mcclosk@ucsc.edu> wrote:
>
>  I'm not sure who to report this to ....

This works.

>  Somewhere between 2.6.11.3 and 2.6.12 (also under 2.6.13), the
>  following change occurred on this box.
> 
>  Under 2.6.11.3, mtrr ranges are automatically set when X is started:
> 
>  ----------------------------------------------------------------------
>  running 2.6.11.3:
> 
>  cat /proc/mtrr
>  reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
>  reg01: base=0xe8000000 (3712MB), size= 128MB: write-combining, count=2
>  reg02: base=0xe0000000 (3584MB), size= 128MB: write-combining, count=1
>  ----------------------------------------------------------------------
> 
>  After installation of 2.6.12/13, mtrr ranges are not set:
> 
>  ----------------------------------------------------------------------
>  running 2.6.13:
> 
>  Xorg.0.log:
> 
>  (WW) RADEON(0): Failed to set up write-combining range (0xe8000000,0x8000000)
> 
>  /var/log/messages:
> 
>  Aug 30 17:37:13 localhost kernel: mtrr: type mismatch for e8000000,8000000 old: write-back new: write-combining
>  Aug 30 17:37:14 localhost kernel: mtrr: type mismatch for e0000000,8000000 old: write-back new: write-combining
>  Aug 30 17:37:14 localhost kernel: [drm] Initialized radeon 1.16.0 20050311 on minor 0: ATI Technologies Inc RV280 [Radeon 9200]
>  Aug 30 17:37:14 localhost kernel: mtrr: type mismatch for e8000000,8000000 old: write-back new: write-combining
> 
>  cat /proc/mtrr
>  reg00: base=0x00000000 (   0MB), size=983552MB: write-back, count=1
>  ----------------------------------------------------------------------
> 
>  Under 2.6.13 it's fairly easy to force a crash of the X server (e.g. by
>  playing Tuxracer badly).
> 
>  The only change here is in the kernel-version. I haven't tried all the
>  point releases between 2.6.11.3 and 2.6.12, but the relevant Changelogs
>  don't suggest that anything relevant changed.

In a 2.6.13 tree could you please do

wget ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc2/2.6.13-rc2-mm1/broken-out/mtrr-suspend-resume-cleanup.patch
patch -p1 -R < mtrr-suspend-resume-cleanup.patch

and retest?

Thanks.
