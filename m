Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280788AbRKGNHp>; Wed, 7 Nov 2001 08:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280787AbRKGNHf>; Wed, 7 Nov 2001 08:07:35 -0500
Received: from [195.63.194.11] ([195.63.194.11]:33296 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S280786AbRKGNH2>; Wed, 7 Nov 2001 08:07:28 -0500
Message-ID: <3BE93E77.6E4E3C95@evision-ventures.com>
Date: Wed, 07 Nov 2001 15:00:23 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Using %cr2 to reference "current"
In-Reply-To: <E161FVT-00029X-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> Im not sure how much the code change for function call patterns would be
> but I doubt its so big for such little effort

Let numbers talk to us, or allow me to quote the georieously politically
incorrect Dave: "Numbers talk - billshit walks!":

Without register passing, we have the following size situation:

   text    data     bss     dec     hex filename
1332132  260804  288080 1881016  1cb3b8 vmlinux

With the following options enabled we get:
-freg-struct-return -mrtd -mregparm=3

   text    data     bss     dec     hex filename
1302372  260804  288080 1851256  1c3f78 vmlinux

Quite significant difference if you ask me!!!

With the following options enabled we get:
-mrtd -mregparm=3

   text    data     bss     dec     hex filename
1302404  260804  288080 1851288  1c3f98 vmlinux

Here it's just a few bytes here and there not really
significant, becouse the kernel apparently doesn't
use structs as return values frequently.

With the following options enabled we get:
-mregparm=3

   text    data     bss     dec     hex filename
1303476  260804  288080 1852360  1c43c8 vmlinux

So apparently the -mrtd options is quite significant as well.

With the following options enabled we get:
-mregparm=2

text    data     bss     dec     hex filename
1307876  260804  288080 1856760  1c54f8 vmlinux

As expected the influence here isn't too significant.

So the conclusion is that apparetly the change in calling convention can
result
in a saving of about 2.3% in code size. This may not sound grat in
relative
numbers, but for a compiler designer this would already sound hilarious
and in
absolute numbers it's: 29760 bytes. Not withstanding the speed
improvement...

Oh for compleatness sake, the compiler used was:
gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-99)
