Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262998AbUKRVdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262998AbUKRVdd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 16:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbUKRVba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 16:31:30 -0500
Received: from tron.kn.vutbr.cz ([147.229.191.152]:12046 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S262976AbUKRV3C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 16:29:02 -0500
Message-ID: <419D13D3.8020409@stud.feec.vutbr.cz>
Date: Thu, 18 Nov 2004 22:27:47 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041005)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.29-0
References: <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu>
In-Reply-To: <20041118164612.GA17040@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  identified this incoming email as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i have released the -V0.7.29-0 Real-Time Preemption patch, 

Hi,
is it supposed to work on x86_64? It doesn't compile.
I tried to fix the compilation errors with these 2 one-liners:


diff -Nurp linux-2.6.10-rc2-mm2-RT0.7.29-0/arch/x86_64/kernel/time.c linux-2.6.10-rc2-mm2-RT/arch/x86_64/kernel/time.c
--- linux-2.6.10-rc2-mm2-RT0.7.29-0/arch/x86_64/kernel/time.c 2004-11-18 22:16:10.728832816 +0100
+++ linux-2.6.10-rc2-mm2-RT/arch/x86_64/kernel/time.c 2004-11-18 22:00:57.000000000 +0100
@@ -49,7 +49,7 @@ static void cpufreq_delayed_get(void);

  extern int using_apic_timer;

-DEFINE_RAW_SPINLOCK(rtc_lock);
+DEFINE_SPINLOCK(rtc_lock);
  DEFINE_RAW_SPINLOCK(i8253_lock);

  static int nohpet __initdata = 0;
diff -Nurp linux-2.6.10-rc2-mm2-RT0.7.29-0/include/asm-x86_64/vsyscall.h linux-2.6.10-rc2-mm2-RT/include/asm-x86_64/vsyscall.h
--- linux-2.6.10-rc2-mm2-RT0.7.29-0/include/asm-x86_64/vsyscall.h 2004-11-18 22:16:11.739679144 +0100
+++ linux-2.6.10-rc2-mm2-RT/include/asm-x86_64/vsyscall.h 2004-11-18 21:56:30.000000000 +0100
@@ -52,7 +52,7 @@ extern struct vxtime_data vxtime;
  extern unsigned long wall_jiffies;
  extern struct timezone sys_tz;
  extern int sysctl_vsyscall;
-extern raw_seqlock_t xtime_lock;
+//extern raw_seqlock_t xtime_lock;

  #define ARCH_HAVE_XTIME_LOCK 1


It now compiles. When I try to run it, I get instant reboot
after "BIOS data check successful".

This is not necessarily a new issue. I haven't tried running
realtime-preempt on x86_64 before.

Michal
