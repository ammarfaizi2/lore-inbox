Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLWOfG>; Sat, 23 Dec 2000 09:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129507AbQLWOeq>; Sat, 23 Dec 2000 09:34:46 -0500
Received: from 213-120-138-46.btconnect.com ([213.120.138.46]:3332 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129267AbQLWOeh>;
	Sat, 23 Dec 2000 09:34:37 -0500
Date: Sat, 23 Dec 2000 14:05:37 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Sourav Sen <sourav@csa.iisc.ernet.in>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: why both kernel lock as well as semaphore
In-Reply-To: <Pine.SOL.3.96.1001223181204.13045B-100000@kohinoor.csa.iisc.ernet.in>
Message-ID: <Pine.LNX.4.21.0012231402520.829-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Dec 2000, Sourav Sen wrote:

> 
> In many parts of the kernel, I have seen both semaphore is taken
> (eg. down(&current->mm->mmap_sem)) as well as kernel lock (lock_kernel())
> is also taken, why both are required? Whats the purpose of each?
> 

because the semaphore is really needed (by design of the subsystem) but
the big kernel lock (BKL) is taken "just in case", i.e. just in case the
design is broken. Occasionally, the lock is removed to "see what
happens" -- if nobody complains then the design is probably correct
i.e. things are declared to "just work" and the attention is shifted to
some other subsystem.... :)

Does it make things clearer?

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
