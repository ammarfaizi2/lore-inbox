Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278468AbRJOWog>; Mon, 15 Oct 2001 18:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278467AbRJOWoZ>; Mon, 15 Oct 2001 18:44:25 -0400
Received: from msgbas1x.cos.agilent.com ([192.25.240.36]:35025 "HELO
	msgbas1.cos.agilent.com") by vger.kernel.org with SMTP
	id <S278468AbRJOWoP>; Mon, 15 Oct 2001 18:44:15 -0400
Message-ID: <01A7DAF31F93D511AEE300D0B706ED9208E496@axcs13.cos.agilent.com>
From: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
To: "'arjan@fenrus.demon.nl'" <arjan@fenrus.demon.nl>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: spin locks and timers in scsi hba driver
Date: Mon, 15 Oct 2001 16:44:44 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I thought spin_unlock_irq() is supposed to enable all maskable
interrupts
by setting IF flag in the EFLAGS register which gets cleared by
local_irq_save().
I understand that spin_unlock_irq does not restore all the flags. But it
atleast sets the IF flag which enables the interrupt. I believe that this
is atleast true in case of intel x86 arch. We have not made our sources
open-source yet. So I cannot give out the sources. Sorry.

Thanks and regards,
-hiren

-----Original Message-----
From: arjan@fenrus.demon.nl [mailto:arjan@fenrus.demon.nl]
Sent: Monday, October 15, 2001 3:11 PM
To: hiren_mehta@agilent.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: spin locks and timers in scsi hba driver


In article <01A7DAF31F93D511AEE300D0B706ED9208E495@axcs13.cos.agilent.com>
you wrote:
> Hi List,

> I want to make sure that my hba-driver timers do run
> when the uppar scsi-layer calls any of the error handler entry points
> and while I am still doing the error handling. As I know, scsi-layer
> calls spin_lock_irqsave(&io_request_lock, flags) before calling the
> error handlers and they call spin_unlock_irqrestore(&io_request_lock,
flags)
> after returning from the error handlers. So, inside the error handlers,
> I call spin_unlock_irq(&io_request_lock); wait for the timers to run,
> and the again call spin_lock_irq(&io_request_lock). 

well interrupts are still disabled...
Could you give an URL to the source of your driver so that I and others can
see what you really are trying to do ?

Greetings,
   Arjan van de Ven
