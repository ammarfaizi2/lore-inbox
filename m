Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266603AbUJUNm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUJUNm6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 09:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbUJUNjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 09:39:22 -0400
Received: from pop.gmx.net ([213.165.64.20]:6080 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261239AbUJTOvz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:51:55 -0400
X-Authenticated: #4399952
Date: Wed, 20 Oct 2004 17:08:04 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
Message-ID: <20041020170804.36753e23@mango.fruits.de>
In-Reply-To: <20041020165326.5016fc5e@mango.fruits.de>
References: <20041015102633.GA20132@elte.hu>
	<20041016153344.GA16766@elte.hu>
	<20041018145008.GA25707@elte.hu>
	<20041019124605.GA28896@elte.hu>
	<20041019180059.GA23113@elte.hu>
	<20041020094508.GA29080@elte.hu>
	<20041020145019.176826cb@mango.fruits.de>
	<20041020125500.GA8693@elte.hu>
	<20041020152507.3c167ca8@mango.fruits.de>
	<20041020162428.7c4c5f53@mango.fruits.de>
	<20041020141822.GA16965@elte.hu>
	<20041020165326.5016fc5e@mango.fruits.de>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004 16:53:26 +0200
Florian Schmidt <mista.tapas@gmx.net> wrote:

> setting them to SCHED_FIFO even with a prio of 99 won't help. will try
> rebooting to see if it's reproducable 
> 
> flo

ok, it seems it was coincidence that the mouse skipping started at the time
of my echo 1 > trace_enabled.. This time it just started sometime after
boot. The scheduler class of the different irq's seems to have no influence
[i experimented with SCHED_FIFO and SCHED_OTHER for irq 1, 8, 12 and 3 and 10
[the latter two are my soundcards irq's].

~$ cat /proc/interrupts 
           CPU0       
  0:     480317          XT-PIC  timer  0/80317
  1:       1731          XT-PIC  i8042  0/1731
  2:          0          XT-PIC  cascade  0/0
  3:      10828          XT-PIC  CS46XX  0/10828
  5:        390          XT-PIC  eth0  0/390
  8:          4          XT-PIC  rtc  0/4
 10:     251556          XT-PIC  SiS SI7012  0/51556
 12:      16605          XT-PIC  i8042  0/16604
 14:       1151          XT-PIC  ide0  0/1151
 15:      26537          XT-PIC  ide1  0/26537
NMI:          0 
ERR:          0

Btw: i just experienced two pauses again, so the patch didn't really fix it
:( hrmm..

I get the feeling that something indeterministic is going on. Still no BUG's
in either dmesg output nor in the syslog.

 flo
