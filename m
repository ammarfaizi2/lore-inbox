Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267641AbRGUNgd>; Sat, 21 Jul 2001 09:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267640AbRGUNgX>; Sat, 21 Jul 2001 09:36:23 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:13323 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S267637AbRGUNgO>;
	Sat, 21 Jul 2001 09:36:14 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200107211335.RAA13657@ms2.inr.ac.ru>
Subject: Re: yenta_socket hangs sager laptop in kernel 2.4.6
To: mmurray@deepthought.ORG (Martin Murray)
Date: Sat, 21 Jul 2001 17:35:51 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0107171610120.31029-100000@cobalt.deepthought.org> from "Martin Murray" at Jul 18, 1 00:45:20 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> You know. 2.2.19 uses my cardbus controller on IRQ 11 without a
> problem. Could it be something in the way the yenta_socket driver sets up
> the controller? I was thinking of dumping the read/write's from the i82365
> from 2.2.19, and comparing it to the yenta_socket driver. Do you think
> this is worthwhile?

Did you make any progress on this?


I have similar problem. Probably, we could cooperate to find a way to solve
this.

Seems, you are right, yenta.c corrupts something in hardware
and the problem is not related to irqs. Observations are:


* No irqs are generated at all after lockup. Printk added at do_IRQ, no activity.
  (Moreover, here yenta irq is not shared with vga, but shared with firewire
   port though.) Nothing. I did not find any software activity at all.
* No activity at pcmcia is required to lockup. Loading yenta_socket is enough.
* Unloading yenta before lockup happened does not help, i.e. something
  is corrupted at time of yenta_init().
* Lockup _inevitably_ happens when yenta_init was executed once
  and I make any operation from set:
  1. any call to APM bios, except for cpu idle.
  2. Pressing any hotkey, including change of LCD brightness
     (Sic! The last event is _absolutely_ invisible to software,
      so that yenta_init does something terrible with hardware).

linux-2.2 with pcmcia does work, so that puzzle really can be solved
comparing operations made by both implementations. Did you make this?

Alexey Kuznetsov
