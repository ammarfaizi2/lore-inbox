Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132870AbQKZXMh>; Sun, 26 Nov 2000 18:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132871AbQKZXM1>; Sun, 26 Nov 2000 18:12:27 -0500
Received: from [194.213.32.137] ([194.213.32.137]:17924 "EHLO bug.ucw.cz")
        by vger.kernel.org with ESMTP id <S132870AbQKZXMQ>;
        Sun, 26 Nov 2000 18:12:16 -0500
Date: Fri, 24 Nov 2000 07:47:53 +0000
From: Pavel Machek <pavel@suse.cz>
To: Tigran Aivazian <tigran@veritas.com>
Cc: John Alvord <jalvo@mbay.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001124074753.A214@toy>
In-Reply-To: <3a219890.57346310@mail.mbay.net> <Pine.LNX.4.21.0011261048130.1039-100000@penguin.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0011261048130.1039-100000@penguin.homenet>; from tigran@veritas.com on Sun, Nov 26, 2000 at 10:52:05AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Sorry, John, I _have_ to [give good example to others]. The above says
> that _you_ my dear friend, do not know where the BSS clearing code is. It
> is not in setup.S. It is not even in the same directory, where setup.S is.
> It is in arch/i386/kernel/head.S, starting from line 120:
> 
> /*
>  * Clear BSS first so that there are no surprises...
>  */
>         xorl %eax,%eax
>         movl $ SYMBOL_NAME(__bss_start),%edi
>         movl $ SYMBOL_NAME(_end),%ecx
>         subl %edi,%ecx
>         cld
>         rep
>         stosb
> 
> ... speaking of which (putting asbesto on and hiding from Andries ;) can't
> we optimize this code to move words at a time and not bytes.... ;)

There's better way: put bss clearing code at beggining of .C code and
do it with memset. [x86-64 does it this way.] It is both more obvious
[no assembly] and faster [memset is optimized].
								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
