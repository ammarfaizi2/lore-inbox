Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278452AbRJOWBm>; Mon, 15 Oct 2001 18:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278455AbRJOWBc>; Mon, 15 Oct 2001 18:01:32 -0400
Received: from msgbas1x.cos.agilent.com ([192.25.240.36]:31737 "HELO
	msgbas1.cos.agilent.com") by vger.kernel.org with SMTP
	id <S278452AbRJOWBX>; Mon, 15 Oct 2001 18:01:23 -0400
Message-ID: <01A7DAF31F93D511AEE300D0B706ED9208E495@axcs13.cos.agilent.com>
From: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: spin locks and timers in scsi hba driver
Date: Mon, 15 Oct 2001 16:01:55 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List,

I want to make sure that my hba-driver timers do run
when the uppar scsi-layer calls any of the error handler entry points
and while I am still doing the error handling. As I know, scsi-layer
calls spin_lock_irqsave(&io_request_lock, flags) before calling the
error handlers and they call spin_unlock_irqrestore(&io_request_lock, flags)
after returning from the error handlers. So, inside the error handlers,
I call spin_unlock_irq(&io_request_lock); wait for the timers to run,
and the again call spin_lock_irq(&io_request_lock). 

But this does not seem to be working. Even after I call
spin_unlock_irq(&io_request_lock), I don't see my timer routines getting
called.
Can somebody advise me on how to achive this ? I cannot use 
spin_unlock_irqrestore() as I do not have the saved 'flags' value.

TIA.
-hiren
