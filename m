Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbUJ1OZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbUJ1OZr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 10:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUJ1OWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 10:22:51 -0400
Received: from mx1.elte.hu ([157.181.1.137]:49056 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261305AbUJ1OTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 10:19:05 -0400
Date: Thu, 28 Oct 2004 16:20:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
Message-ID: <20041028142016.GA27593@elte.hu>
References: <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041027130359.GA6203@elte.hu> <4180FEBB.5020802@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4180FEBB.5020802@cybsft.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> I have been having problems on my UP system at home with all of the
> more recent patches (since U10.X). Some would boot and then the
> networking was severely busted (slowdowns, hangs, etc.), some would
> not even boot.  V0.4.3 was of the no boot variety. Just for grins I
> disabled kudzu, and the thing boots fine with no networking or other
> problems. This very well may have been a fluke, but I have
> successfully booted this kernel twice now. It did hang on a reboot at
> the point when it should have been doing the actual reboot and I had
> to press the button. I didn't have time this morning to turn kudzu
> back on to see if was just a fluke that it didn't boot the first time.
> Not sure what, if anything, this means, but V0.4.3 is running very
> nicely on my UP system with no lag or noticeable problems.

just to make sure - could try to run kudzu manually after bootup and
observe what happens? Do you have a udev based system? I recently
corrupted my udev database via a crash and had to remove the
/dev/.udev.tdb file and had to regenerate it via 'udevstart'. (be
careful doing that though, it might mess up your system.) The symtoms
were a hung kudzu - while in reality it 'hung' because udev and udevinfo
processes looped in userspace forever. Weirdly, the stock Fedora kernel
didnt hang in this same phase, so there might still be a
PREEMPT_REALTIME bug here.

	Ingo
