Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263250AbRFEGOD>; Tue, 5 Jun 2001 02:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263245AbRFEGNw>; Tue, 5 Jun 2001 02:13:52 -0400
Received: from [164.164.82.20] ([164.164.82.20]:10487 "EHLO subexgroup.com")
	by vger.kernel.org with ESMTP id <S263240AbRFEGNq>;
	Tue, 5 Jun 2001 02:13:46 -0400
From: "Anil Kumar" <anilk@subexgroup.com>
To: "Mihai Moise" <mmoise@giref.ulaval.ca>, <linux-kernel@vger.kernel.org>
Subject: RE: semaphores and noatomic flag
Date: Tue, 5 Jun 2001 11:58:17 +0530
Message-ID: <NEBBIIKAMMOCGCPMPBJOCEGICEAA.anilk@subexgroup.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <3B1BC6BF.8098111A@giref.ulaval.ca>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
X-Return-Path: anilk@subexgroup.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will it not be a very specialized case rather than being general call type?

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Mihai Moise
Sent: Monday, June 04, 2001 11:05 PM
To: linux-kernel@vger.kernel.org
Subject: semaphores and noatomic flag


I write this to discuss the reasons why the semop system call should
have an IPC_NOATOMIC flag.

Suppose we have two processes, called client and server, which
communicate through a shared memory segment and two semaphores, and need
to synchonize their activities so that they don't operate simultaneously
except at startup.

The server would do,

down(smephore 0)

to wait for a message from the client. When the client needs the server
to execute, it would,

up(semaphore 0)		/* wake up server */
down(semaphore 1)	/* put itself to sleep */

after the server has completed its portion of the task, it would,

up(semaphore 1)		/* wake up client */
down(semaphore 0)	/* put iself to sleep */

The problem is that the two system calls make the whole process twice as
slow as it needs to be, and they are both needed because the semop
system call is implemented in an atomic manner. If the semop system call
had an IPC_NOATOMIC flag, then the each process would only have to do
one call,

semop(up semaphore 0 & down semaphore 1, IPC_NOATOMIC)

which would be interpreted in the kernel as the sequence of two system
calls I have written previously.

I want to know what other people think about this idea.

Mihai
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


