Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265412AbRFVNtB>; Fri, 22 Jun 2001 09:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265414AbRFVNsv>; Fri, 22 Jun 2001 09:48:51 -0400
Received: from [64.7.140.42] ([64.7.140.42]:38344 "EHLO inet.connecttech.com")
	by vger.kernel.org with ESMTP id <S265413AbRFVNsk>;
	Fri, 22 Jun 2001 09:48:40 -0400
Message-ID: <070001c0fb22$69d68460$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "kees" <kees@schoen.nl>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0106220846150.11538-100000@schoen3.schoen.nl>
Subject: Re: Q serial.c
Date: Fri, 22 Jun 2001 09:51:18 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "kees" <kees@schoen.nl>
> What may happen on a SMP machine if a serial port has been closed and the
> closing stage is at shutdown() in serial.c in the call to free_IRQ  and
> BEFORE the IRQ is really shutdown, a new character arrives which causes an
> IRQ? Is it possible that the OTHER cpu  takes this interrupt and causes a
> crash?

I'm looking at serial-5.05/serial.c. You'll notice at the
beginning of shutdown the saveflags(); cli(); calls.
This disables interrupts. The uart will not be able to
generate IRQs even if new characters arrive.

..Stu


