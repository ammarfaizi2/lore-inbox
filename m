Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293395AbSBYNCO>; Mon, 25 Feb 2002 08:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293393AbSBYNCD>; Mon, 25 Feb 2002 08:02:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28430 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293402AbSBYNBr>; Mon, 25 Feb 2002 08:01:47 -0500
Subject: Re: [PATCH] Lightweight userspace semaphores...
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 25 Feb 2002 13:14:41 +0000 (GMT)
Cc: rusty@rustcorp.com.au (Rusty Russell), mingo@elte.hu,
        matthew@hairy.beasts.org (Matthew Kirkwood),
        bcrl@redhat.com (Benjamin LaHaise), david@mysql.com (David Axmark),
        wli@holomorphy.com (William Lee Irwin III),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0202241719330.1420-100000@home.transmeta.com> from "Linus Torvalds" at Feb 24, 2002 05:23:59 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fKxl-0004qL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	fd = sem_initialize();
> 	mmap(fd, ...)
> 	..
> 	munmap(..)
> 
> which gives you a handle for the semaphore.

	fd = open("/dev/shm/sem....");
	mmap(fd, ...)

	munmap(..)

That lets the kernel decide what it wants to do and provide as the back
end. It allows you to think about things like mremap and growing/shrinking
the object. And finally /dev/sem looks suspiciously like a quick tweak
to /dev/shm..

> And make the initial mmap() only do a limited number of pages, so that
> people don't start trying to allocate tons of memory this way.-

If it uses the /dev/shm world then anyone running a kernel with the new
patches for resource accounting is still safe, and anyone else is still
simply going to find their shm areas hitting swap under extreme load (which
is ideal)

