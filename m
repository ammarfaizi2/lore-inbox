Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265258AbTIJRQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 13:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265297AbTIJRQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 13:16:56 -0400
Received: from hal-5.inet.it ([213.92.5.24]:64673 "EHLO hal-5.inet.it")
	by vger.kernel.org with ESMTP id S265258AbTIJRQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 13:16:51 -0400
Message-ID: <06cc01c377bf$edf4ad00$5aaf7450@wssupremo>
Reply-To: "Luca Veraldi" <luca.veraldi@katamail.com>
From: "Luca Veraldi" <luca.veraldi@katamail.com>
To: "Andrea Arcangeli" <andrea@suse.de>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030910165944.GL21086@dualathlon.random> <20030910170534.GM21086@dualathlon.random>
Subject: Re: Efficient IPC mechanism on Linux
Date: Wed, 10 Sep 2003 19:21:09 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> sorry for the self followup, but I just read another message where you
> mention 2.2, if that was for 2.2 the locking was the ok.

Oh, good. I was already going to put my head under sand. :-)

I'm not so expert about the kernel. I've just read [ORLL]
and some bits of the kernel sources.
So, error in the codes are not so strange.

But, it's better now that you know we are talking about version 2.2...

I'm glad to hear that locking are ok.

You say:

> in terms of design as far as I can tell the most efficient way to do
> message passing is not pass the data through the kernel at all (no
> matter if you intend to copy it or not), and to simply use futex on top
> of shm to synchronize/wakeup the access.  If we want to make an API
> widespread, that should be simply an userspace library only.
>
> It's very inefficient to mangle pagetables and flush the tlb in a flood
> like you're doing (or better like you should do), when you can keep the

I guess futex are some kind of semaphore flavour under linux 2.4/2.6.
However, you need to use SYS V shared memory in any case.
Tests for SYS V shared memory are included in the web page
(even though using SYS V semaphores).

I don't think, reading the numbers, that managing pagetables "is very
inefficient".
I think very inefficient are SYS V semaphore orethe double-copying channel
you call a pipe.

> there's also an obvious DoS that is trivial to generate by locking in
> ram some 64G of ram with ecbm_create_capability() see the for(count=0;
> count<pages; ++count) atomic_inc (btw, you should use get_page, and all
> the operations like LockPage to play with pages).

As I say in the web page,

 having all the pages locked in memory is not a necessary condition
for the applicability of communication mechanisms based on capabilities.
Simply, it make it easier to write the code and does not make me crazy
with the Linux swapping system.

Bye bye,
Luca


