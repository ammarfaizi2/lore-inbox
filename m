Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263389AbUJ2Ovo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbUJ2Ovo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 10:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263391AbUJ2Ot4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:49:56 -0400
Received: from out005pub.verizon.net ([206.46.170.143]:58823 "EHLO
	out005.verizon.net") by vger.kernel.org with ESMTP id S263342AbUJ2Oi3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:38:29 -0400
Message-Id: <200410291438.i9TEcIT8006608@localhost.localdomain>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4] 
In-reply-to: Your message of "Fri, 29 Oct 2004 16:31:34 +0200."
             <20041029143134.GA27343@elte.hu> 
Date: Fri, 29 Oct 2004 10:38:18 -0400
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out005.verizon.net from [141.151.88.122] at Fri, 29 Oct 2004 09:38:20 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>here's Rui's setup:
> 
>| Note: all tests were carried out running jackd -v -dalsa -dhw:0 
>| -r44100 -p128 -n2 -S -P, loaded with 9 (nine) fluidsynth instances,
>| on a P4@2.533Ghz laptop, against the onboard sound device 
>| (snd-ali5451).
>
>i suspect this means there was playback only, no capture, and thus the 
>capture/playback interrupt interaction cannot be the case, right?

ok, he used the -P flag which means playback only. so yes, the ALSA
backend would only have opened the playback stream.

oh, and i must correct what i said before. the ALSA backend will
typically be polling on *two* fd's. ALSA represents playback and
capture as different devices, so a default jackd will open both and
poll both of them. the backend will wait until they are both ready
(ie. the capture device has the correct amount of data, the playback
device has the correct amount of space).

--p
