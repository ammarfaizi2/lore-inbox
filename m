Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268325AbUJTPl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268325AbUJTPl2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 11:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268436AbUJTPlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 11:41:20 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:63879 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268368AbUJTPhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 11:37:38 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
In-Reply-To: <20041020141822.GA16965@elte.hu>
References: <20041015102633.GA20132@elte.hu>
	 <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu>
	 <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu>
	 <20041020094508.GA29080@elte.hu> <20041020145019.176826cb@mango.fruits.de>
	 <20041020125500.GA8693@elte.hu> <20041020152507.3c167ca8@mango.fruits.de>
	 <20041020162428.7c4c5f53@mango.fruits.de>  <20041020141822.GA16965@elte.hu>
Content-Type: text/plain
Message-Id: <1098286655.1429.22.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 11:37:36 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 10:18, Ingo Molnar wrote:
> note that the keyboard and USB interrupts are SCHED_OTHER by default, so
> they could be delayed quite long depending on the workload.

Why is this the default behavior?  It seems like you would want all IRQ
threads to be SCHED_FIFO by default.   Otherwise it seems like the
scheduler could decide to run a normal userspace process (like, say, X)
while an IRQ thread is runnable.

Is it really a good idea for IRQ threads to be subject to the whims of
the scheduler?

Also, on modern machines, this would effectively make all IRQ threads
SCHED_OTHER because the USB port shares an interrupt with everything:

  0:   36676353          XT-PIC  timer  0/76353
  1:       8759          XT-PIC  i8042  5/8759
  2:          0          XT-PIC  cascade  0/0
  8:          4          XT-PIC  rtc  0/4
 10:          0          XT-PIC  uhci_hcd  0/0
 11:     210713          XT-PIC  uhci_hcd, eth0  0/10713
 12:          0          XT-PIC  uhci_hcd  0/0
 15:      79277          XT-PIC  ide1  0/79276
NMI:          0
ERR:          0

Lee


