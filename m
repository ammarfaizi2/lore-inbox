Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264954AbUHJOOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbUHJOOh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 10:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265124AbUHJOOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 10:14:36 -0400
Received: from pop.gmx.de ([213.165.64.20]:42722 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264954AbUHJOMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 10:12:18 -0400
X-Authenticated: #4399952
Date: Tue, 10 Aug 2004 16:21:48 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
Message-Id: <20040810162148.06d139b3@mango.fruits.de>
In-Reply-To: <20040809104649.GA13299@elte.hu>
References: <1090732537.738.2.camel@mindpipe>
	<1090795742.719.4.camel@mindpipe>
	<20040726082330.GA22764@elte.hu>
	<1090830574.6936.96.camel@mindpipe>
	<20040726083537.GA24948@elte.hu>
	<1090832436.6936.105.camel@mindpipe>
	<20040726124059.GA14005@elte.hu>
	<20040726204720.GA26561@elte.hu>
	<20040729222657.GA10449@elte.hu>
	<20040801193043.GA20277@elte.hu>
	<20040809104649.GA13299@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Aug 2004 12:46:49 +0200
Ingo Molnar <mingo@elte.hu> wrote:

>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc3-O4
> 
> (it should apply to -rc2 cleanly too.)
> 
> -O4 fixes a two more latency sources:

Hi, i also wanted to report that i also still see these mysterious (at
least to me) "(swapper/0)" critical section reports (i use O4 with the
preempt-timing-on-2.6.8-rc3-O4.patch): These are basically the only
xruns/critical section reports i see when using jackd at 2*64 and with
some clients connected. I'm not sure if i see them when jackd is not
running.. Will test later this evening.

Flo

Aug 10 16:05:50 mango kernel: (swapper/0): 2463us non-preemptible
critical section violated 1000 us preempt threshold starting at
do_IRQ+0x19/0x170 and ending at do_IRQ+0x126/0x170
Aug 10 16:05:50 mango kernel:  [<c01064ae>] dump_stack+0x1e/0x20
Aug 10 16:05:50 mango kernel:  [<c0114735>] sub_preempt_count+0x45/0x60
Aug 10 16:05:50 mango kernel:  [<c0107936>] do_IRQ+0x126/0x170
Aug 10 16:05:50 mango kernel:  [<c0106098>] common_interrupt+0x18/0x20
Aug 10 16:05:50 mango kernel:  [<c0103eb9>] cpu_idle+0x39/0x50
Aug 10 16:05:50 mango kernel:  [<c03148c1>] start_kernel+0x1a1/0x1f0
Aug 10 16:05:50 mango kernel:  [<c010019f>] 0xc010019f
Aug 10 16:05:50 mango kernel: ALSA sound/core/pcm_lib.c:169: XRUN:
pcmC0D0p
Aug 10 16:05:50 mango kernel:  [<c01064ae>] dump_stack+0x1e/0x20
Aug 10 16:05:50 mango kernel:  [<f08c2431>]
snd_pcm_period_elapsed+0x311/0x480 [snd_pcm]
Aug 10 16:05:50 mango kernel:  [<f089ebce>]
snd_cs46xx_interrupt+0x1be/0x1f0 [snd_cs46xx]
Aug 10 16:05:50 mango kernel:  [<c011b55b>]
generic_handle_IRQ_event+0x3b/0x70
Aug 10 16:05:50 mango kernel:  [<c01078c6>] do_IRQ+0xb6/0x170
Aug 10 16:05:50 mango kernel:  [<c0106098>] common_interrupt+0x18/0x20
Aug 10 16:07:11 mango kernel: ALSA sound/core/pcm_lib.c:169: XRUN:
pcmC0D0c
Aug 10 16:07:11 mango kernel:  [<c01064ae>] dump_stack+0x1e/0x20
Aug 10 16:07:11 mango kernel:  [<f08c2431>]
snd_pcm_period_elapsed+0x311/0x480 [snd_pcm]
Aug 10 16:07:11 mango kernel:  [<f089ebce>]
snd_cs46xx_interrupt+0x1be/0x1f0 [snd_cs46xx]
Aug 10 16:07:11 mango kernel:  [<c011b55b>]
generic_handle_IRQ_event+0x3b/0x70
Aug 10 16:07:11 mango kernel:  [<c01078c6>] do_IRQ+0xb6/0x170
Aug 10 16:07:11 mango kernel:  [<c0106098>] common_interrupt+0x18/0x20
Aug 10 16:07:11 mango kernel:  [<c0103eb9>] cpu_idle+0x39/0x50
Aug 10 16:07:11 mango kernel:  [<c03148c1>] start_kernel+0x1a1/0x1f0
Aug 10 16:07:11 mango kernel:  [<c010019f>] 0xc010019f
Aug 10 16:07:11 mango kernel: (swapper/0): 2462us non-preemptible
critical section violated 1000 us preempt threshold starting at
do_IRQ+0x19/0x170 and ending at do_IRQ+0x126/0x170
Aug 10 16:07:11 mango kernel:  [<c01064ae>] dump_stack+0x1e/0x20
Aug 10 16:07:11 mango kernel:  [<c0114735>] sub_preempt_count+0x45/0x60
Aug 10 16:07:11 mango kernel:  [<c0107936>] do_IRQ+0x126/0x170
Aug 10 16:07:11 mango kernel:  [<c0106098>] common_interrupt+0x18/0x20
Aug 10 16:07:11 mango kernel:  [<c0103eb9>] cpu_idle+0x39/0x50
Aug 10 16:07:11 mango kernel:  [<c03148c1>] start_kernel+0x1a1/0x1f0
Aug 10 16:07:11 mango kernel:  [<c010019f>] 0xc010019f
Aug 10 16:07:11 mango kernel: ALSA sound/core/pcm_lib.c:169: XRUN:
pcmC0D0p
Aug 10 16:07:11 mango kernel:  [<c01064ae>] dump_stack+0x1e/0x20
Aug 10 16:07:11 mango kernel:  [<f08c2431>]
snd_pcm_period_elapsed+0x311/0x480 [snd_pcm]
Aug 10 16:07:11 mango kernel:  [<f089ebce>]
snd_cs46xx_interrupt+0x1be/0x1f0 [snd_cs46xx]
Aug 10 16:07:11 mango kernel:  [<c011b55b>]
generic_handle_IRQ_event+0x3b/0x70
Aug 10 16:07:11 mango kernel:  [<c01078c6>] do_IRQ+0xb6/0x170
Aug 10 16:07:11 mango kernel:  [<c0106098>] common_interrupt+0x18/0x20
Aug 10 16:09:52 mango kernel: ALSA sound/core/pcm_lib.c:169: XRUN:
pcmC0D0p
Aug 10 16:09:52 mango kernel:  [<c01064ae>] dump_stack+0x1e/0x20
Aug 10 16:09:52 mango kernel:  [<f08c2431>]
snd_pcm_period_elapsed+0x311/0x480 [snd_pcm]
Aug 10 16:09:52 mango kernel:  [<f089ebce>]
snd_cs46xx_interrupt+0x1be/0x1f0 [snd_cs46xx]
Aug 10 16:09:52 mango kernel:  [<c011b55b>]
generic_handle_IRQ_event+0x3b/0x70
Aug 10 16:09:52 mango kernel:  [<c01078c6>] do_IRQ+0xb6/0x170
Aug 10 16:09:52 mango kernel:  [<c0106098>] common_interrupt+0x18/0x20
Aug 10 16:09:52 mango kernel:  [<c0103eb9>] cpu_idle+0x39/0x50
Aug 10 16:09:52 mango kernel:  [<c03148c1>] start_kernel+0x1a1/0x1f0
Aug 10 16:09:52 mango kernel:  [<c010019f>] 0xc010019f
Aug 10 16:09:52 mango kernel: (swapper/0): 2459us non-preemptible
critical section violated 1000 us preempt threshold starting at
do_IRQ+0x19/0x170 and ending at do_IRQ+0x126/0x170
Aug 10 16:09:52 mango kernel:  [<c01064ae>] dump_stack+0x1e/0x20
Aug 10 16:09:52 mango kernel:  [<c0114735>] sub_preempt_count+0x45/0x60
Aug 10 16:09:52 mango kernel:  [<c0107936>] do_IRQ+0x126/0x170
Aug 10 16:09:52 mango kernel:  [<c0106098>] common_interrupt+0x18/0x20
Aug 10 16:09:52 mango kernel:  [<c0103eb9>] cpu_idle+0x39/0x50
Aug 10 16:09:52 mango kernel:  [<c03148c1>] start_kernel+0x1a1/0x1f0
Aug 10 16:09:52 mango kernel:  [<c010019f>] 0xc010019f


System info:

Linux mango.fruits.de 2.6.8-rc3 #2 Tue Aug 10 12:46:08 CEST 2004 i686
GNU/Linux
-----------
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 7
model name	: AMD Duron(tm) Processor
stepping	: 1
cpu MHz		: 1194.993
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat
pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips	: 2359.29

-----------
/proc/interrupts:
           CPU0       
  0:    8341883          XT-PIC  timer
  1:      11031          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:   10546999          XT-PIC  CS46XX
  8:          4          XT-PIC  rtc
 10:      17097          XT-PIC  eth0
 12:     292978          XT-PIC  i8042
 14:       2675          XT-PIC  ide0
 15:      43327          XT-PIC  ide1
NMI:          0 
ERR:          0
-----------
/proc/irq/10/eth0/threaded:1
/proc/irq/12/i8042/threaded:1
/proc/irq/14/ide0/threaded:1
/proc/irq/15/ide1/threaded:1
/proc/irq/1/i8042/threaded:1
/proc/irq/5/CS46XX/threaded:0
/proc/irq/8/rtc/threaded:0
-----------
/sys/block/hda/queue/max_sectors_kb:16
/sys/block/hdd/queue/max_sectors_kb:16
-----------
voluntary_preemption
3
kernel_preemption
1
-----------
preempt_thresh
1000


-- 
Palimm Palimm!
http://affenbande.org/~tapas/

