Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262727AbVDHKbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262727AbVDHKbQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 06:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262798AbVDHKa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 06:30:59 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22987 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262791AbVDHKaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 06:30:20 -0400
Date: Fri, 8 Apr 2005 12:28:54 +0200
From: Pavel Machek <pavel@suse.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: Frank Sorenson <frank@tuxrocks.com>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Updated: Dynamic Tick version 050408-1
Message-ID: <20050408102854.GB1392@elf.ucw.cz>
References: <20050406083000.GA8658@atomide.com> <425451A0.7020000@tuxrocks.com> <20050407082136.GF13475@atomide.com> <4255A7AF.8050802@tuxrocks.com> <4255B247.4080906@tuxrocks.com> <20050408062537.GB4477@atomide.com> <20050408075001.GC4477@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050408075001.GC4477@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I think I have an idea on what's going on; Your system does not wake to
> > APIC interrupt, and the system timer updates time only on other interrupts.
> > I'm experiencing the same on a loaner ThinkPad T30.
> > 
> > I'll try to do another patch today. Meanwhile it now should work
> > without lapic in cmdline.
> 
> Following is an updated patch. Anybody having trouble, please try
> disabling CONFIG_DYN_TICK_USE_APIC Kconfig option.
> 
> I'm hoping this might work on Pavel's machine too?

The "volume hang" was explained: I was using CPU frequency scaling, it
probably did not like that. After disabling CPU frequency scaling, it
seems to work ok:

								Pavel

pavel@Elf:~$ cat /proc/interrupts ; sleep  1 ; cat /proc/interrupts
           CPU0
  0:      33288          XT-PIC  timer
  1:       1021          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  9:          2          XT-PIC  acpi
 10:      94036          XT-PIC  yenta, yenta, ehci_hcd:usb1,
uhci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb4
 11:       3941          XT-PIC  Intel 82801DB-ICH4, eth0
 12:         17          XT-PIC  i8042
 14:       5119          XT-PIC  ide0
NMI:          0
LOC:          0
ERR:          0
MIS:          0
           CPU0
  0:      33568          XT-PIC  timer
  1:       1022          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  9:          2          XT-PIC  acpi
 10:      94323          XT-PIC  yenta, yenta, ehci_hcd:usb1,
uhci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb4
 11:       3951          XT-PIC  Intel 82801DB-ICH4, eth0
 12:         17          XT-PIC  i8042
 14:       5192          XT-PIC  ide0
NMI:          0
LOC:          0
ERR:          0
MIS:          0
pavel@Elf:~$


-- 
Boycott Kodak -- for their patent abuse against Java.
