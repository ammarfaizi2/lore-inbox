Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280902AbRKLS1b>; Mon, 12 Nov 2001 13:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280911AbRKLS1V>; Mon, 12 Nov 2001 13:27:21 -0500
Received: from colorfullife.com ([216.156.138.34]:47876 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S280902AbRKLS1P>;
	Mon, 12 Nov 2001 13:27:15 -0500
Message-ID: <001a01c16ba7$ab5242d0$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Sebastian Heidl" <heidl@zib.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: doing a callback from the kernel to userspace
Date: Mon, 12 Nov 2001 19:27:14 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> PS: Yes, I really do need this as signals form the kernel to userspace
>        add to much latency (10 to 20 usecs) and I want to avoid waiting
>        in a system call.

The latency you talk about is the time required to schedule - there is nothing
you driver can do to reduce that - syscall, signal or your own code must wait
until schedule() decides to run your process.

I'd try to
a) switch your process to realtime priority, mlockall your app.
b) use the low-latency patches. They were regularly discussed on
linux-kernel, search through the archives.
c) give up and implement everything in kernel.
d) switch to rtlinux.

Are you sure you need 10 to 20 usec? Then a hard realtime with everything
in kernel is your only option, i.e. rtlinux.

--
    Manfred

