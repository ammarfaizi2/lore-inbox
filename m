Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264481AbRFITed>; Sat, 9 Jun 2001 15:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264483AbRFITeN>; Sat, 9 Jun 2001 15:34:13 -0400
Received: from t2.redhat.com ([199.183.24.243]:56822 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S264481AbRFITeC>; Sat, 9 Jun 2001 15:34:02 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.21.0106091148380.26187-100000@penguin.transmeta.com> 
In-Reply-To: <Pine.LNX.4.21.0106091148380.26187-100000@penguin.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        Dawson Engler <engler@csl.Stanford.EDU>
Subject: Re: [CHECKER] a couple potential deadlocks in 2.4.5-ac8 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 09 Jun 2001 20:33:01 +0100
Message-ID: <19317.992115181@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


torvalds@transmeta.com said:
>  Good point. Spinlocks (with the exception of read-read locks, of
> course) and semaphores will deadlock on recursive use, while the BKL
> has this "process usage counter" recursion protection.

Obtaining a read lock twice can deadlock too, can't it?

	A		B
	read_lock()
			write_lock()
			...sleeps...
	read_lock()
	...sleeps...

Or do we not make new readers sleep if there's a writer waiting?

--
dwmw2


