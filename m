Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270849AbRIFOLI>; Thu, 6 Sep 2001 10:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270857AbRIFOK7>; Thu, 6 Sep 2001 10:10:59 -0400
Received: from [64.7.140.42] ([64.7.140.42]:10445 "EHLO inet.connecttech.com")
	by vger.kernel.org with ESMTP id <S270849AbRIFOKr>;
	Thu, 6 Sep 2001 10:10:47 -0400
Message-ID: <014201c136dd$e8a6c380$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Stephen Torri" <storri@ameritech.net>,
        "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0109051603160.2980-100000@base.torri.linux>
Subject: Re: Serial Ports
Date: Thu, 6 Sep 2001 10:12:05 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Stephen Torri" <storri@ameritech.net>
> Should serial ports be assigned interrupts on start up or are they
> assigned when they are used? I have been tracking the serial ports on my
> Supermicro Dual P3 Board for a few days now. At times I cannot get them to
> work so I can syncronize a Palm Pilot via the serial port.

On-board serial ports are given either the standard irqs, or the
irqs that you specify in the bios. ISA and other non-self-identifying-
bus-based ports will be given the irqs you specify in the configuration
of the device. PCI and other self-identifying-bus-based ports will
be assigned free or sharable irqs by the bios/os. All serial hardware
is assigned an irq. This is the hardware level.

I think what you're asking is "When I cat /proc/irq, should I see the
serial ports listed at boot, or only after I've used them?" The answer
to that is that the standard serial driver only registers to use the
irq that has been assigned, when it needs to use it. So if you check
before usage, you won't see your ports.

..Stu


