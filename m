Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVADKzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVADKzg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 05:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVADKzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 05:55:35 -0500
Received: from smtpout.mac.com ([17.250.248.83]:37625 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261967AbVADKzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 05:55:05 -0500
In-Reply-To: <20050104094518.GA13868@elte.hu>
References: <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu> <20041214132834.GA32390@elte.hu> <20050104064013.GA19528@nietzsche.lynx.com> <20050104094518.GA13868@elte.hu>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: multipart/mixed; boundary=Apple-Mail-1--172627175
Message-Id: <1906D4E2-5E3F-11D9-A816-000D9352858E@mac.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Adam Heath <doogie@debian.org>, Steven Rostedt <rostedt@goodmis.org>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Bill Huey <bhuey@lnxw.com>, Lee Revell <rlrevell@joe-job.com>
From: Felipe Alfaro Solana <lkml@mac.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-mm1-V0.7.34-00
Date: Tue, 4 Jan 2005 11:55:07 +0100
To: Ingo Molnar <mingo@elte.hu>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-1--172627175
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

On 4 Jan 2005, at 10:45, Ingo Molnar wrote:

>
> * Bill Huey <bhuey@lnxw.com> wrote:
>
>> You'll have to apply Ingo's patch so that it gets rejects and then
>> apply this patch on top of it so that it resolves those issues. It's a
>> bit sloppy, but this'll at least be somewhat workable until Ingo comes
>> back and pounds us with patches. :)
>
> i've uploaded my port:
>
>     http://redhat.com/~mingo/realtime-preempt/
>
> this is mainly a straight port from 2.6.10-rc3-mm1 to 2.6.10-mm1, plus  
> i
> picked up a post-2.6.10-mm1 audio-driver buildsystem fix-patch. Please
> (re-)report any new or old regressions.
>
> to create a -V0.7.34-00 tree from scratch, the patching order is:
>
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.10.tar.bz2
>    
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10/ 
> 2.6.10-mm1/2.6.10-mm1.bz2
>    
> http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-mm1- 
> V0.7.34-00
>

   AS [M]  arch/i386/crypto/aes-i586-asm.o
   CC [M]  arch/i386/crypto/aes.o
   LD [M]  arch/i386/crypto/aes-i586.o
   CC      kernel/sched.o
   CC      kernel/fork.o
   CC      kernel/exec_domain.o
   CC      kernel/panic.o
   CC      kernel/printk.o
   CC      kernel/profile.o
   CC      kernel/exit.o
   CC      kernel/itimer.o
   CC      kernel/time.o
kernel/time.c: In function `sys_gettimeofday':
kernel/time.c:164: error: syntax error before ')' token
make[3]: *** [kernel/time.o] Error 1
make[2]: *** [kernel] Error 2
error: Bad exit status from /var/tmp/rpm-tmp.70899 (%build)


--Apple-Mail-1--172627175
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="fix.patch"
Content-Disposition: attachment;
	filename=fix.patch

--- linux-2.6.10-mm1-V0.7.34-00/kernel/time.c.old	2005-01-04 11:46:32.000000000 +0100
+++ linux-2.6.10-mm1-V0.7.34-00/kernel/time.c	2005-01-04 11:50:21.000000000 +0100
@@ -161,7 +161,7 @@
 " sti; cli; mov %ax,%ss; mov %ss,%ax; mov %ax,%ss; "
 " cli; mov %ax,%ss; "
 " cli; mov %ax,%ss; cli; "
-" mov %ax,%ss; mov %ax,%ss; sti; sti; sti; sti");
+" mov %ax,%ss; mov %ax,%ss; sti; sti; sti; sti";
 #ifdef CONFIG_LATENCY_TRACE
 	if (!tv && ((long)tz == 1))
 		return user_trace_start();

--Apple-Mail-1--172627175
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed



--Apple-Mail-1--172627175--

