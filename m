Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265033AbSLQMqG>; Tue, 17 Dec 2002 07:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265019AbSLQMqG>; Tue, 17 Dec 2002 07:46:06 -0500
Received: from [80.247.74.2] ([80.247.74.2]:41620 "EHLO foradada.isolaweb.it")
	by vger.kernel.org with ESMTP id <S264990AbSLQMqF>;
	Tue, 17 Dec 2002 07:46:05 -0500
Message-Id: <5.2.0.9.0.20021217132123.0349bab0@mail.isolaweb.it>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Tue, 17 Dec 2002 13:51:49 +0100
To: Arjan van de Ven <arjanv@redhat.com>
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: Multithreaded coredump patch where?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1040126717.10064.2.camel@laptop.fenrus.com>
References: <5.2.0.9.0.20021217105617.00aa31e0@mail.isolaweb.it>
 <5.2.0.9.0.20021216182325.042a2b60@mail.isolaweb.it>
 <5.2.0.9.0.20021216182325.042a2b60@mail.isolaweb.it>
 <5.2.0.9.0.20021217105617.00aa31e0@mail.isolaweb.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-scanner: scanned by Antivirus Service IsolaWeb Agency - (http://www.isolaweb.it)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 13.05 17/12/02 +0100, Arjan van de Ven wrote:
>On Tue, 2002-12-17 at 12:05, Roberto Fichera wrote:
> > At 13.21 16/12/02 -0800, mgross wrote:
> >
> > >I haven't rebased the patches I posted back in June for a while now.
> > >
> > >Attached is the patch I posted for the 2.4.18 vanilla kernel.  Its a bit
> > >controversial, but it seems to work for a number of folks.  Let me know if
> > >you have any troubles re-basing it.
> >
> > Only one hunk failed on include/asm-ia64/elf.h but fixed by hand.
> > Why do you say a bit controversial ?
>
>The design has theoretical (but probably in practice not trivial to
>trigger) deadlocks; by design it prevents processes that are sleeping
>from running, regardless whether those processes are in kernel space or
>not. If they are in kernel space, they can accidentally be holding a
>semaphore that something in the core dumping path will need to get (but
>can't because it never will be released). There are not that many of
>such semaphores (kmap semaphore is one, and filesystems can have several
>internally)

Ok! Now I see why! This problem should be avoided if the coredump algo
will permit to complete the kernel execution for all the threads that
need it, and just before to reenter in userspace, all the threads will 
freeze in
a know point so the coredump can continue with the snapshot. Not easy ;-)!



Roberto Fichera. 


______________________________________
E-mail protetta dal servizio antivirus di IsolaWeb Agency & ISP
http://wwww.isolaweb.it
