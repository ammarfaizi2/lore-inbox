Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbUA0Pin (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 10:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUA0Pin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 10:38:43 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:2446 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S264479AbUA0Pil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 10:38:41 -0500
Message-ID: <401685F9.6000904@samwel.tk>
Date: Tue, 27 Jan 2004 16:38:33 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Huw Rogers <count0@localnet.com>, linux-kernel@vger.kernel.org,
       linux-laptop@mobilix.org
Subject: Re: 2.6.2-rc1 / ACPI sleep / irqbalance / kirqd / pentium 4 HT problems
 on Uniwill N258SA0
References: <20040124233749.5637.COUNT0@localnet.com> <20040127083936.GA18246@elf.ucw.cz>
In-Reply-To: <20040127083936.GA18246@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
 >>Anyway, sleep/suspend/standby functionality (important to most laptop
 >>users, need to close the lid and go): This checkin to
 >>kernel/power/main.c seems to disable suspend with SMP (!?):
 >>
 >>--- 1.3/kernel/power/main.c	Sat Jan 24 20:44:47 2004
 >>+++ 1.4/kernel/power/main.c	Sat Jan 24 20:44:47 2004
 >>@@ -172,6 +172,12 @@
 >> 	if (down_trylock(&pm_sem))
 >> 		return -EBUSY;
 >>
 >>+	/* Suspend is hard to get right on SMP. */
 >>+	if (num_online_cpus() != 1) {
 >>+		error = -EPERM;
 >>+		goto Unlock;
 >>+	}
 >>+
 >> 	if ((error = suspend_prepare(state)))
 >> 		goto Unlock;
 >>
 >>... which, given the prevalence of hyperthreaded CPUs on laptops, is
 >>fighting a trend. I backed out the above with a #if 0 then tried echo -n
 >>1>/proc/acpi/sleep again. This time I got:
 >
 >
 > Well, no sleep developers have SMP or HT machines, AFAICT.
 >
 > If you back that out... well you are on your own.

Just a random thought: if I understand it correctly, CPU hotplugging is 
intended to be able to take CPUs online and offline one by one, am I 
right? Well, when that infrastructure's ready, this can probably be made 
to work for SMP by taking all the other CPUs offline first. They're all 
going to go offline because of the suspend anyway, so it shouldn't make 
much difference. :)

-- Bart
