Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263600AbUJ3BRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbUJ3BRu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 21:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbUJ3BOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 21:14:45 -0400
Received: from out011pub.verizon.net ([206.46.170.135]:55781 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S263643AbUJ3BGv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 21:06:51 -0400
Message-Id: <200410300106.i9U16fXJ010366@localhost.localdomain>
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4] 
In-reply-to: Your message of "Fri, 29 Oct 2004 23:11:12 +0200."
             <20041029211112.GA9836@elte.hu> 
Date: Fri, 29 Oct 2004 21:06:41 -0400
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [141.152.250.245] at Fri, 29 Oct 2004 20:06:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>but i'd also suggest to put in a counter into that branch so that this
>condition doesnt get lost. In fact the Maximum Process Cycle stat from
>Rui:
>
>>>   Maximum Delay . . . . . . . . .    6904       921       721    usecs
>>>   Maximum Process Cycle . . . . .    1449      1469      1590    usecs
>
>seems to suggest that there can be significant processing delays? (if
>Maximum Process Cycle is indeed the time spent from poll_ret to the next
>poll_enter.)

IIRC, Rui was running with -p128, which at 48000kHz is 2600usecs (and
longer at 44100kHz). If the maximum process cycle was on the order of
1500usecs, that leaves nearly 1ms until the next interrupt is
due. Unless jackd was held up between computing the process cycle time
and entering poll, it doesn't seem that the process cycle ever gets
close to the interrupt interval duration.

So I don't think that delays caused *during* jackd's processing cycle
are involved here. However, I agree that your suggestion to check for
this before computing max_delay is probably wise in general.

--p
