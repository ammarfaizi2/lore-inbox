Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbWC3FOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWC3FOA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 00:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWC3FOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 00:14:00 -0500
Received: from theorix.CeNTIE.NET.au ([202.9.6.84]:41688 "HELO
	theorix.CeNTIE.NET.au") by vger.kernel.org with SMTP
	id S1751058AbWC3FN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 00:13:59 -0500
Subject: 2.6.16-rt11 and low-latency audio xruns (interrupt latency
	problem?)
From: "Valin, Jean-Marc (ICT Centre, Marsfield)" <jean-marc.valin@csiro.au>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 30 Mar 2006 16:13:58 +1100
Message-Id: <1143695638.7328.5.camel@theorix.CeNTIE.NET.au>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm getting xruns while trying to do low-latency capture/playback of
audio. After enabling the alsa debug options, I'm seeing errors like
these in my logs:

[66205.003000] Unexpected hw_pointer value [1] (stream = 0, delta: -3,
max jitter = 16): wrong interrupt acknowledge?
[66205.003000]  [<f0ae2ec1>] snd_pcm_period_elapsed+0x136/0x27a
[snd_pcm] (8)
[66205.003000]  [<f0af7780>] snd_intel8x0_interrupt+0x18d/0x1e5
[snd_intel8x0] (20)
[66205.003000]  [<b013495b>] handle_IRQ_event+0x4e/0xb6 (44)
[66205.003000]  [<b0135443>] thread_edge_irq+0x6f/0xc4 (48)
[66205.003000]  [<b0135519>] do_irqd+0x0/0x8a (16)
[66205.003000]  [<b01354d8>] do_hardirq+0x40/0x81 (4)
[66205.003000]  [<b0135575>] do_irqd+0x5c/0x8a (16)
[66205.003000]  [<b01261f6>] kthread+0x79/0xa3 (16)
[66205.003000]  [<b012617d>] kthread+0x0/0xa3 (24)
[66205.003000]  [<b0101319>] kernel_thread_helper+0x5/0xb (16)
[66205.004000] XRUN: pcmC0D0p
[66205.004000]  [<f0ae2f72>] snd_pcm_period_elapsed+0x1e7/0x27a
[snd_pcm] (8)
[66205.004000]  [<f0af7780>] snd_intel8x0_interrupt+0x18d/0x1e5
[snd_intel8x0] (24)
[66205.004000]  [<b013495b>] handle_IRQ_event+0x4e/0xb6 (44)
[66205.004000]  [<b0135443>] thread_edge_irq+0x6f/0xc4 (48)
[66205.004000]  [<b0135519>] do_irqd+0x0/0x8a (16)
[66205.004000]  [<b01354d8>] do_hardirq+0x40/0x81 (4)
[66205.004000]  [<b0135575>] do_irqd+0x5c/0x8a (16)
[66205.004000]  [<b01261f6>] kthread+0x79/0xa3 (16)
[66205.004000]  [<b012617d>] kthread+0x0/0xa3 (24)
[66205.004000]  [<b0101319>] kernel_thread_helper+0x5/0xb (16)

The only info I could get after searching for a while is that the
"Unexpected hw_pointer value" *could* be related to the audio interrupt
being serviced too late
(http://www.ussg.iu.edu/hypermail/linux/kernel/0407.1/1613.html).
However, I'm running the audio IRQ (IRQ 16) at priority 99 and my app at
98 (I also tried the opposite and get the same result). In this case,
I'm running with two periods of 16 samples each (48 kHz), but I've seen
that error occur with periods up to 64 samples. 

Any idea how to fix/further investigate that? My machine is a Dell D600
laptop with a Pentium-M 2.13 GHz, which I'm running at full-speed
(performance governor). Kernel is stock 2.6.16 + rt11 patch. Distro is
Ubuntu 5.10, kernel is not tainted.

Thanks,

        Jean-Marc

P.S. Please include me in CC since I'm not subscribed to lkml.

