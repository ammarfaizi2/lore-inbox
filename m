Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbUKLUVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUKLUVP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 15:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbUKLUVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 15:21:14 -0500
Received: from mail.aei.ca ([206.123.6.14]:54212 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S262370AbUKLUVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 15:21:11 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.25-1
From: Shane Shrybman <shrybman@aei.ca>
To: Mark_H_Johnson@RAYTHEON.COM
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
In-Reply-To: <OF6E8C462B.2451EF23-ON86256F4A.0064AC96@raytheon.com>
References: <OF6E8C462B.2451EF23-ON86256F4A.0064AC96@raytheon.com>
Content-Type: text/plain
Message-Id: <1100290790.4817.12.camel@mars>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 12 Nov 2004 15:19:54 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-12 at 13:23, Mark_H_Johnson@RAYTHEON.COM wrote:
> >Typical example of the error message:
> >
> >kernel: hde: dma_timer_expiry: dma status == 0x24
> >kernel: ALSA sound/core/pcm_native.c:1424: playback drain error (DMA or
> IRQ trouble?)
> >kernel: PDC202XX: Primary channel reset.
> >kernel: hde: DMA interrupt recovery
> >kernel: hde: lost interrupt
> >
> >This was on a Promise TX2 133 ide card with one IDE disk. The problem
> >would show itself if using the RT patches and APIC. But the problem seems
> >to have been resolved now.
> 
> I had errors like that one when the IDE IRQ was at a priority less than
> the real time task. Since then, I run with all the IRQ's at max RT priority
> and will continue to do so until I get a better assessment of what my real
> application (not these audio tests...) needs for IRQ priorities.
> 

Ok, I wasn't comparing apples to apples. I forgot I had to remove the sb live
card from this machine a few days ago. So the hardware config wasn't exactly
the same. I have reinstalled the sb live card now and I am retesting on 0.7.25.
The sb live shares an irq with ide2(promise card)

           CPU0       
  0:     835791    IO-APIC-edge  timer  0/35791
  1:       2207    IO-APIC-edge  i8042  1/2207
  8:          4    IO-APIC-edge  rtc  0/4
  9:          0   IO-APIC-level  acpi  0/0
 15:         11    IO-APIC-edge  ide1  1/9
 16:      70527   IO-APIC-level  ide2, EMU10K1  0/70527
 17:       1093   IO-APIC-level  eth0  0/1092
 18:      37440   IO-APIC-level  bttv0, Bt87x audio  173/37439
 19:      39147   IO-APIC-level  aic7xxx, ivtv0  340/39143
 21:      25091   IO-APIC-level  uhci_hcd, uhci_hcd, uhci_hcd, uhci_hcd  52/25091
 22:      85425   IO-APIC-level  VIA8237  494/71991
NMI:     836519 
LOC:     836340 
ERR:          0
MIS:          1

With the sb live card back in use the system has hung once with the sound looping.
It hung after I started playing a video in a second instance of the mythfrontend
application. I had the nmi_watchdog on and netconsole logging to another machine
but there was nothing in the logs.

I have rebooted and I am trying to verify the dma_timer_expiry issue is still gone
with the sb live in use.

> This may have been fixed as a side effect of Ingo setting the IRQ threads
> at
> RT priorities in the 40's.
> 

I had originally thought this might be the cause as well so I jacked
ide2 priority but it didn't help. However it does share the irq so maybe
that is a factor here.

> --Mark H Johnson
>   <mailto:Mark_H_Johnson@raytheon.com>
> 

shane

