Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267384AbRGQVgL>; Tue, 17 Jul 2001 17:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267386AbRGQVgC>; Tue, 17 Jul 2001 17:36:02 -0400
Received: from msgbas1tx.cos.agilent.com ([192.6.9.34]:19393 "HELO
	msgbas1t.cos.agilent.com") by vger.kernel.org with SMTP
	id <S267384AbRGQVfs>; Tue, 17 Jul 2001 17:35:48 -0400
Message-ID: <FEEBE78C8360D411ACFD00D0B7477971880AED@xsj02.sjs.agilent.com>
From: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
To: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: who decrements can_queue in Scsi_Host structure ?
Date: Tue, 17 Jul 2001 15:35:50 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi LIsts,

In the hosts.h file, the following was the definition of
can_queue variable in the Scsi_Host_Template (SHT) structure. 



    /* 
     * THis determines if we will use a non-interrupt driven
     * or an interrupt driver scheme, It is set to the maximum number
     * of simultaneous commands a given host adapter will accept.
     */
    int can_queue;

Scsi_Host structure also has the same variable which gets initialized
with the can_queue of SHT structure in the scsi_register().
Let's say the can_queue in initialized to 16. Now, I could not find
anybody decrementing this variable. So, when the time comes to
send a new command to the hba, the can_queue of the host sturcture is
checked and if that is non-zero, then the queuecommand() entry point
is immediately called. So, the queuecommand will always be called 
even if the host is already given 'can_queue' commands.

Any inputs on this ?

-hiren
