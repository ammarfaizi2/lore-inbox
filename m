Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132124AbRBDRqN>; Sun, 4 Feb 2001 12:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132151AbRBDRqD>; Sun, 4 Feb 2001 12:46:03 -0500
Received: from [63.89.188.10] ([63.89.188.10]:26385 "EHLO xchange.zambeel.com")
	by vger.kernel.org with ESMTP id <S132124AbRBDRp4>;
	Sun, 4 Feb 2001 12:45:56 -0500
Message-ID: <2B8089144916D411896D00D0B73C8353DB2C1D@exchange.zambeel.com>
From: Mohit Aron <aron@Zambeel.com>
To: "'David Schwartz'" <davids@webmaster.com>, linux-kernel@vger.kernel.org
Subject: RE: system call sched_yield() doesn't work on Linux 2.2
Date: Sun, 4 Feb 2001 09:45:46 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What version of Linux are you using ? What I see is the following:
	Thread1
	Thread1
	Thread1
	Thread1
	Thread1
	Thread2
	Thread2
	Thread2
	Thread2
	Thread2

Also, it is NOT unrealistic to expect perfect alternation. The definition
of sched_yield in the manpage says that sched_yield() puts the thread under
question last in the run queue. So perfect alternation should have occurred.
I've also tested the code on Solaris - there is perfect alternation there.


- Mohit


-----Original Message-----
From: David Schwartz [mailto:davids@webmaster.com]
Sent: Sunday, February 04, 2001 3:09 AM
To: Mohit Aron; linux-kernel@vger.kernel.org
Subject: RE: system call sched_yield() doesn't work on Linux 2.2



	The program you attached worked perfectly for me. You need to
'fflush(stdout);' after each 'printf'. You didn't expect perfect alternation
did you? That's totally unrealistic. You cannot use the scheduler as a
synchronization mechanism.

--

Thread1
Thread1
Thread2
Thread1
Thread1
Thread2
Thread1
Thread2
Thread2
Thread2

--

	DS

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Mohit Aron
> Sent: Saturday, February 03, 2001 2:53 PM
> To: linux-kernel@vger.kernel.org
> Subject: system call sched_yield() doesn't work on Linux 2.2
>
>
> Hi,
> 	the system call sched_yield() doesn't seem to work on Linux
> 2.2. Does
> anyone know of a kernel patch that fixes this ?
>
> Attached below is a small program that uses pthreads and demonstrates that
> sched_yield() doesn't work. Basically, the program creates two
> threads that
> alternatively try to yield CPU to each other.
>
>
> - Mohit
>
>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
