Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273265AbRIRJiB>; Tue, 18 Sep 2001 05:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273270AbRIRJhm>; Tue, 18 Sep 2001 05:37:42 -0400
Received: from colorfullife.com ([216.156.138.34]:55047 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S273265AbRIRJhg>;
	Tue, 18 Sep 2001 05:37:36 -0400
Message-ID: <002201c14025$a5b8bdc0$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Andrea Arcangeli" <andrea@suse.de>
Cc: "Linus Torvalds" <torvalds@transmeta.com>, <dhowells@redhat.com>,
        <Ulrich.Weigand@de.ibm.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <001701c13fc2$cda19a90$010411ac@local> <200109172339.f8HNd5W13244@penguin.transmeta.com> <20010918020139.B698@athlon.random> <000901c14014$494f9380$010411ac@local> <20010918095549.T698@athlon.random>
Subject: Re: Deadlock on the mm->mmap_sem
Date: Tue, 18 Sep 2001 11:37:55 +0200
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

> > IMHO modifying proc_pid_read_maps() is far simpler - I'm not aware
of
> > another recursive mmap_sem user.
>
> if that's the very only place that could be a viable option but OTOH I
> like to be allowed to use recursion on the read locks as with the
> spinlocks.

But shouldn't that change wait until 2.5? Especially since another huge
mm change was just merged?
proc_pid_read_maps contains further bugs - afaics it it could skip lines
if PAGE_SIZE > 4096 and a file path is nearly 4096 bytes long.
I'll post a patch to proc_pid_read_maps - modifying the rw semaphore
behaviour just asks for trouble.

--
    Manfred

