Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbVLaDuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbVLaDuO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 22:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbVLaDuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 22:50:14 -0500
Received: from sccrmhc11.comcast.net ([63.240.77.81]:49137 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932097AbVLaDuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 22:50:13 -0500
Date: Fri, 30 Dec 2005 22:51:36 -0500
From: Kurt Wall <kwall@kurtwerks.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051231035136.GF24842@kurtwerks.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <Pine.LNX.4.64.0512291322560.3298@g5.osdl.org> <20051229224839.GA12247@elte.hu> <1135897092.2935.81.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.15-rc5krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 03:03:22AM +0100, Tim Schmielau took 0 lines to write:

>    http://www.physik3.uni-rostock.de/tim/kernel/2.6/deinline.patch.gz
> The resulting kernel actually booted (am running it right now). However, 
> catching just these low-hanging fruits doesn't get me anywhere near 
> Arjan's numbers. For my non-representative personal config I get (on 
> i386 with -unit-at-a-time):
> 
>    > size vmlinux*
>       text    data     bss     dec     hex filename
>    2197105  386568  316840 2900513  2c4221 vmlinux
>    2144453  392100  316840 2853393  2b8a11 vmlinux.deinline

For two more datapoints, also from an x86_64 2.6.15-rc7 kernel, here
are the values for my main desktop .config and an allyesconfig .config.
The .deinline kernels have the above patch applied and are also built
with CONFIG_CC_OPTIMIZE_FOR_SIZE=y.

$ size vmlinux.krw*
   text    data     bss     dec     hex filename
2338371  462208  479920 3280499  320e73 vmlinux.krw
2309384  468168  479920 3257472  31b480 vmlinux.krw.deinline

.text is only 1.24% smaller

For an allyesconfig, the results are slightly worse:

$ size vmlinux*
   text    data     bss     dec     hex filename
24076648        7465782 1996904 33539334        1ffc506 vmlinux
23791161        7513590 1996904 33301655        1fc2497 vmlinux.deinline

.text is only 1.19% smaller

Kurt
-- 
Nothing cures insomnia like the realization that it's time to get up.
