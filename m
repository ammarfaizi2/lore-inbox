Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132457AbRANTPk>; Sun, 14 Jan 2001 14:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132365AbRANTPa>; Sun, 14 Jan 2001 14:15:30 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:48397 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S130801AbRANTPR>;
	Sun, 14 Jan 2001 14:15:17 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200101141915.WAA25163@ms2.inr.ac.ru>
Subject: Re: ENOMEM on socket writes
To: paulus@linuxcare.COM.AU
Date: Sun, 14 Jan 2001 22:15:05 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <14942.23127.188103.787383@diego.linuxcare.com.au> from "Paul Mackerras" at Jan 12, 1 04:45:05 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> memory".  Rsync is writing on a socket which is set non-blocking and
> the write is apparently returning ENOMEM.

This must not happen with stock 2.4.0. TCP never returns ENOMEM.
Please, investigate.

But application should be ready to get this error yet.


> >From the point of view of the application, ENOMEM is a little hard to
> deal with constructively. 

The only constructive way to handle this is to fail instantly
and to release all the allocated resources as soon as possible,
avoiding operations requiring allocating new resources.


>				 Select will say that the socket is
> writable, so there doesn't seem to be a good way of waiting until the
> write has a chance of succeeding.

It never will if you do not abort something.

It is in theory. In practice, write() on TCP returns EAGAIN on
transient errors and application will spin, which is normal.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
