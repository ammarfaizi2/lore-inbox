Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288057AbSAHOJS>; Tue, 8 Jan 2002 09:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288052AbSAHOI6>; Tue, 8 Jan 2002 09:08:58 -0500
Received: from [212.169.100.200] ([212.169.100.200]:46581 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S288060AbSAHOIx>; Tue, 8 Jan 2002 09:08:53 -0500
Date: Tue, 8 Jan 2002 15:07:38 +0100
From: Morten Helgesen <admin@nextframe.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] drivers/scsi/psi240i.c - io_request_lock fix
Message-ID: <20020108150738.B6168@sexything>
Reply-To: admin@nextframe.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus and the rest of you.

A simple fix for the io_request_lock issue leftovers in drivers/scsi/psi240i.c. 
Not tested, but compiles. Diffed against 2.5.2-pre10. Please apply.


== Morten

-- 

"Det er ikke lett å være menneske" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net


--- vanilla-linux-2.5.2-pre10/drivers/scsi/psi240i.c    Tue Jan  8 10:57:31 2002
+++ patched-linux-2.5.2-pre10/drivers/scsi/psi240i.c    Tue Jan  8 14:48:56 2002
@@ -370,10 +370,11 @@
 static void do_Irq_Handler (int irq, void *dev_id, struct pt_regs *regs)
        {
        unsigned long flags;
+       struct Scsi_Host *host = PsiHost[irq - 10]; 
 
-       spin_lock_irqsave(&io_request_lock, flags);
+       spin_lock_irqsave(&host->host_lock, flags);
        Irq_Handler(irq, dev_id, regs);
-       spin_unlock_irqrestore(&io_request_lock, flags);
+       spin_unlock_irqrestore(&host->host_lock, flags);
        }
 /****************************************************************
  *     Name:   Psi240i_QueueCommand

