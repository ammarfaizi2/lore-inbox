Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318308AbSHNNvH>; Wed, 14 Aug 2002 09:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318561AbSHNNvH>; Wed, 14 Aug 2002 09:51:07 -0400
Received: from avscan1.sentex.ca ([199.212.134.11]:53764 "EHLO
	avscan1.sentex.ca") by vger.kernel.org with ESMTP
	id <S318308AbSHNNvG>; Wed, 14 Aug 2002 09:51:06 -0400
Message-ID: <004901c2439a$7730b2e0$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: <JosMHinkle@netscape.net>, <linux-kernel@vger.kernel.org>
References: <380543EF.54D883E4.0BD32098@netscape.net>
Subject: Re: Linux kernel 2.4.19 failure to access a serial port
Date: Wed, 14 Aug 2002 09:57:01 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please wrap your lines at less than or equal to 80 columns.

From: <JosMHinkle@netscape.net>
> Expansion: The system is a 233MHz Pentium Mmx in a board called
> "P5SV-B" manufacurer unknown.  There are two serial ports available

http://www.ecs.com.tw/products/socket7.htm

> with the mouse using one (ttyS0).  The Rockwell K56Flex modem is
> installed to use ttyS2 and IRQ 10, set by PnP.  The reason for this
> is Windows is run on the machine at times, and is the only
> arrangement it will accept, so the same configuration was intended
> to be used when Linux was run.  Indeed, when kernel 2.2.21 was used,
> there was no problem.
> The kernel was originally configured without support for sharing
> interrupts  since none were shared.

Sounds like you have an ISA modem, which cannot share interrupts.

>   However, the symptoms are strings sent to the modem might or might
> not reach it, and when they do, they come in 16 byte segments about
> once every 30 seconds.  I understand that is typical behaviour when
> interrupts are shared, and indeed when the serial driver becomes

It's typical behaviour when a device that can't share interrupts is
sharing its interrupt with someone else.

> active on bootup, the annunciation is "Serial driver version 5.05c
> with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled" whether or not
> those were selected in the configuration before kernel compilation.

The first three serial options are turned on if you have PCI support
(in the general setup menu, not the serial menu) turned on. The pci
side of the serial driver needs those options to support pci based
serial boards.

>   Initially /dev/ttyS2 is reported as using IRQ4 on bootup even
> though the isapnp.conf directs it to be IRQ10.  setserial is used
> later thus: "setserial /dev/ttyS2 irq 10 baud_base 115200 spd_normal
> skip_test".
>    Curiously, with or without that, the modem responds the same way
> whether IRQ4 or IRQ10 is used after the isapnp software has
> allegedly set it to use IRQ10.

I don't have any knowledge of isapnp. But it sounds like you have an
irq conflict. Here's a couple things to try, apologies if they are
irrelevant:
- double check what irq your modem is set to
- double check in your bios that you have that irq reserved for isa
  use only
- if possible try disbling the isapnp.conf, and just trying the port
  with whatever irq it autodetects at

Hm. This isn't a Winmodem is it?

..Stu


