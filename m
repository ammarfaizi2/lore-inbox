Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135243AbRDRSN3>; Wed, 18 Apr 2001 14:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135245AbRDRSNT>; Wed, 18 Apr 2001 14:13:19 -0400
Received: from quechua.inka.de ([212.227.14.2]:7707 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S135243AbRDRSNI>;
	Wed, 18 Apr 2001 14:13:08 -0400
From: Bernd Eckenfels <W1012@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: light weight user level semaphores
In-Reply-To: <Pine.LNX.4.31.0104171200220.933-100000@penguin.transmeta.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.36 (i686))
Message-Id: <E14pwRv-0002bz-00@sites.inka.de>
Date: Wed, 18 Apr 2001 20:13:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.31.0104171200220.933-100000@penguin.transmeta.com> you wrote:
>   So FS_create() starts out by allocating the backing store for the
>   semaphore. This can basically be done in user space, although the
>   kernel does need to get involved for the second part of it, which
>   is to (a) allocate a kernel "backing store" thing that contains the
>   waiters and the wait-queues for other processes and (b) fill in the
>   opaque 128-bit area with the initial count AND the magic to make it
>   fly. More on the magic later.

>   So the second part of FS_create needs a new system call.

How will the clean up of the kernelstore work?

> - The user must _not_ be able to fool the kernel into using a completely
>   non-existing semaphore.

In that case the access to kernel level is protected by a very secure
combination of secure hash and magic number checking. But anyway there is a
small chance to get to some kernel memory unauthorized. Do you know if this is
the first (known) interface which has a more practical approach to kernel data
structure security?

If we want to be a bit more strict, we can have a pre-allocated pool of
semaphores and the kernel pointer check can add the kernelk address of the
semaphore region into account. It's faster than the checksum probably and more
secure in protecting the rest of the kernel memory. Spoofing access to other
semaphores would be still possible (but can be protected by a smaller hash).

Greetings
Bernd
