Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbUKETyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUKETyx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 14:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbUKETyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 14:54:53 -0500
Received: from sartre.ispvip.biz ([209.118.182.154]:2229 "HELO
	sartre.ispvip.biz") by vger.kernel.org with SMTP id S261179AbUKETyH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 14:54:07 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.7
From: "Michael J. Cohen" <mjc@unre.st>
To: Ingo Molnar <mingo@elte.hu>
Cc: sboyce@blueyonder.co.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20041104193819.GB10107@elte.hu>
References: <20041104100634.GA29785@elte.hu>
	 <1099563805.30372.2.camel@localhost> <1099567061.7911.4.camel@localhost>
	 <20041104114545.GA3722@elte.hu>
	 <1099573171.7876.0.camel@optie.uni.325i.org>
	 <1099575262.8110.1.camel@optie.uni.325i.org>
	 <20041104140528.GA16604@elte.hu>
	 <1099577631.8090.4.camel@optie.uni.325i.org>
	 <20041104142317.GA19476@elte.hu>
	 <1099593117.7982.14.camel@optie.uni.325i.org>
	 <20041104193819.GB10107@elte.hu>
Content-Type: text/plain
Date: Fri, 05 Nov 2004 14:53:51 -0500
Message-Id: <1099684431.7964.6.camel@optie.uni.325i.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 2004-11-04 at 20:38 +0100, Ingo Molnar wrote:
> * Michael J. Cohen <mjc@unre.st> wrote:
> 
> > threw in your tcp_window oneliner mentioned in another thread and that
> > seemed to curb the lockups I was getting.  xmms+jackd in realtime mode
> > is getting some xruns during any kind of IDE activity. network isn't
> > quite as fussy.
> 
> hm, have you chrt-ed the soundcard IRQ to a fifo priority higher than
> 50?
> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

on my x86-64, there doesn't seem to be an irq for snd-intel8x0.

optie ~ # cat /proc/interrupts 
           CPU0       
  0:    1406459    IO-APIC-edge  timer
  8:          0    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:      33574    IO-APIC-edge  ide0
 15:         21    IO-APIC-edge  ide1
177:     624454   IO-APIC-level  eth0
185:     286001   IO-APIC-level  libata, ehci_hcd, ohci_hcd, ohci_hcd
193:      37964   IO-APIC-level  AMD AMD8111
NMI:          0 
LOC:    1406207 
ERR:          0
MIS:          0

ps ax doesn't seem to show anything sound-related except jackd so I
tried chrt -f  75 jackd -R -d alsa -P -HMm -z s -o 6

result during an emerge metadata on V0.7.13:

**** alsa_pcm: xrun of at least 133.973 msecs
**** alsa_pcm: xrun of at least 78.544 msecs
**** alsa_pcm: xrun of at least 245.494 msecs

*much* better but we're shooting for 0 xruns, no?

------
Michael Cohen

