Return-Path: <linux-kernel-owner+w=401wt.eu-S1755356AbXABQTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755356AbXABQTV (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 11:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755360AbXABQTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 11:19:21 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:47955 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755356AbXABQTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 11:19:06 -0500
Date: Tue, 2 Jan 2007 17:16:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux@bohmer.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG-RT] RTC has been stopped-> long delay during boot, soft reboot->GRUB fails to call getrtsecs()
Message-ID: <20070102161608.GA19214@elte.hu>
References: <3efb10970701020601i13dd3809y56c2c6aafeb228b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3efb10970701020601i13dd3809y56c2c6aafeb228b@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Remy Bohmer <l.pinguin@gmail.com> wrote:

> Hello Ingo,
> 
> I have discovered 3 problems that are likely all related to the same
> root-cause, likely to be caused by the RT-kernel.
> I use the 2.6.19-rt15 kernel, with the configuration attached to this mail.
> It is running on a standard x86, i945, Celeron 2.93 GHZ (=UP), Fedora Core 6
> 
> So, I have set the following options:
> CONFIG_HIGH_RES_TIMERS=y
> CONFIG_NO_HZ=y
> 
> The problems:
> 1. During (cold and warm) boot the synchronisation of the hardware
> clock takes often very long time, up to approx. 30 seconds. (This is
> the call: /sbin/hwclock --hctosys --localtime)

i tried this on a recent -rt kernel and there's no delay:

  [root@europe ~]# time /sbin/hwclock --hctosys --localtime

  real    0m0.756s
  user    0m0.754s
  sys     0m0.002s

could you try a more recent kernel like 2.6.20-rc2-rt3? We fixed a good 
number of high-res timers related bugs that could result in similar 
hangs. But maybe it's still unfixed, it's just a guess.

	Ingo
