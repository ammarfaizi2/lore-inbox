Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbUB0Lh2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 06:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbUB0Lh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 06:37:28 -0500
Received: from web11808.mail.yahoo.com ([216.136.172.162]:1941 "HELO
	web11808.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261686AbUB0Lh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 06:37:26 -0500
Message-ID: <20040227113725.12307.qmail@web11808.mail.yahoo.com>
Date: Fri, 27 Feb 2004 12:37:25 +0100 (CET)
From: =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
Subject: Re: Why no interrupt priorities?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> Michael Frank wrote:
> > Is this to imply that edge triggered shared interrupts
> > are used anywhere?
>
> It is (or used to be) rather common with serial ports.  Remember that
> COM1 and COM3 were both defined to use IRQ4 and COM2 and COM4 to use
> IRQ3.

  If you are talking of old ISA serial cards, the IRQ were "shared" in
 the sense that the IRQ pin was not connected to the microprocessor
 when the device was not open (under Linux).
 So you could reliably have COM1 and COM3 on IRQ4 if you did not use
 the two devices at the same time - or use one of them in the polling
 mode (IRQ 0: handle by the timer at low speed).

  Some unusual hardware could handle two ports on the same IRQ (the
 same card mixing itself the IRQ of the two COM port present on the
 same ISA card) but the mixing could not be reliably handled at the
 ISA level. Using a resistor and/or a diode instead of a jumper to
 select the IRQ could also do the trick. So the software was ready
 to handle two interrupts from two UART on the same IRQ - but you
 had to have special hardware.

  Some people had success having a modem on COM1 and a serial _mouse_
 on COM3 (or the other way around) because the COM1/modem was winning
 the control of the ISA IRQ  and the COM3/modem was loosing but because
 of 1200 bauds transmission speed the timer interrupt was recovering the
 char received. So they could not tell the difference and did not know
 why inverting the two serial plug did not work.

  Now if you are talking of newer motherboard with COM port integrated,
 you may have been able to share (but unusual) - if you are talking
 of PCI card serial ports then that is another story.

  Etienne.


	

	
		
Yahoo! Mail : votre e-mail personnel et gratuit qui vous suit partout ! 
Créez votre Yahoo! Mail sur http://fr.benefits.yahoo.com/

Dialoguez en direct avec vos amis grâce à Yahoo! Messenger !Téléchargez Yahoo! Messenger sur http://fr.messenger.yahoo.com
