Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277503AbRJJWpu>; Wed, 10 Oct 2001 18:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277509AbRJJWpk>; Wed, 10 Oct 2001 18:45:40 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17938 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277503AbRJJWpc>; Wed, 10 Oct 2001 18:45:32 -0400
Date: Wed, 10 Oct 2001 15:44:46 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Bob Matthews <bmatthews@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.11 oops
In-Reply-To: <3BC4B34C.BB45D829@redhat.com>
Message-ID: <Pine.LNX.4.33.0110101540080.2918-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 Oct 2001, Bob Matthews wrote:
>
> I've received an oops while booting 2.4.11 on two different SMP
> machines.  The kernel was SMP, HIGHMEM=64G with sym53c8xx, 3c59x,
> eepro100, aic7xx and megaraid drivers statically linked.

With CONFIG_SLAB_DEBUG on?

Slab debugging is not compatible with HIGHMEM=64G as-is, I think (and we
didn't use to expose that CONFIG option to normal users until recently).
Th ebug is in get_pgd_slow() in include/asm-i386/pgalloc.h, where it just
does a "kmalloc()" and expects the thing to be magically aligned.

Does anybody have (tested) patches for this?

		Linus

