Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264037AbSJNKRJ>; Mon, 14 Oct 2002 06:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264210AbSJNKRJ>; Mon, 14 Oct 2002 06:17:09 -0400
Received: from [66.70.28.20] ([66.70.28.20]:56071 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S264037AbSJNKRI>; Mon, 14 Oct 2002 06:17:08 -0400
Date: Mon, 14 Oct 2002 12:20:42 +0200
From: DervishD <raul@pleyades.net>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [PATCH] mmap.c (do_mmap_pgoff), against 2.4.19 and 2.4.20-pre10
Message-ID: <20021014102042.GC96@DervishD>
References: <20021014093622.GA96@DervishD> <20021014.025250.105171520.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021014.025250.105171520.davem@redhat.com>
User-Agent: Mutt/1.4i
Organization: Pleyades Net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Davem :)))

>        This is the fourth and last time I submit this patch to Marcelo.
>    This little tiny bug is fixed in all trees except the official one. I
>    think this patch is trivial enough to be accepted, but...
> Patches tend to get accepted when you attach an analysis
> of the bug you are fixing.

    I sent that description the three times before. In fact, you have
this patch in your tree (or is -dj tree? If I'm wrong please my
excuses...). In fact, this patch is in the -aa tree (I think), in
2.2, 2.5 and in the -ac series. I don't know if more people has
included it, because I sent to LKML and some people adopted the
patch.

> I cannot even figure out what the failure case is that you are
> fixing which actually occurs.

    The bug is that when you specify a size to mmap() whose last
address is in the last page of the addressable space for the process,
the 'PAGE_ALIGN()' macro converts a *size* to an *address* of '0' because
there is no way of telling the macro 'hey, this is not an address, but a
size, align up to a multiple of the page size, but don't set it to '0' if
it's too big for you'. The problem is that the alignment takes place
before the checking for limits. If the size is greater than the
addressable size the function should return -EINVAL, not '0'...

    Now, if the size requested is '0', the hint address is returned,
and if the size is larger than TASK_SIZE, it fails with '-EINVAL'.
Now if you are checking (prior to compiling something, for example)
what is the larger chunk of 'mmapable' memory you can get, you can do
it safely. Or just you need to map a big file and you're trying to do
it: you need to know if mmaping such a large size is failing or not,
but without the patch mmap() just returns the hint address...

> I bet if you explain this, Marcelo will take your fix.

    Marcelo told me to resend this patch at 2.4.20-pre time, and I
did. I'm not telling that Marcelo has dropped this patch arbitrarily.
Maybe he doesn't rely on it, and it's good, patches shouldn't get
into the kernel without reason, but I resent two times at 2.4.20-pre
time and I don't know why it is not included. And it's a bug that
affects me ;))) Maybe messages didn't arrive, maybe I did the patch
wrong, who knows... I'm not attacking Marcelo nor am I angry ;)) but
I'm not guilty, neither ;)))

    Raúl
