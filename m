Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291875AbSBXXvX>; Sun, 24 Feb 2002 18:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291876AbSBXXvN>; Sun, 24 Feb 2002 18:51:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26119 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291875AbSBXXvC>; Sun, 24 Feb 2002 18:51:02 -0500
Date: Sun, 24 Feb 2002 15:48:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: <mingo@elte.hu>, Matthew Kirkwood <matthew@hairy.beasts.org>,
        Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Lightweight userspace semaphores... 
In-Reply-To: <E16f85L-0005QM-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.33.0202241543550.28708-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Feb 2002, Rusty Russell wrote:
> >
> >   sys_sem_create()
> >   sys_sem_destroy()
>
> There is no create and destroy (init is purely userspace).  There is
> "this is a semapore: up it".  This is a feature.

No, that's a bug.

You have to realize that there are architectures that need special
initialization and page allocation for semaphores: they need special flags
in the TLB for "careful access", for example (sometimes the careful access
ends up being non-cached).

You can't just put semaphores anywhere and tell the kernel to try to fix
up whatever happened.

			Linus

