Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286009AbRLHWYn>; Sat, 8 Dec 2001 17:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286010AbRLHWYe>; Sat, 8 Dec 2001 17:24:34 -0500
Received: from nc-ashvl-66-169-84-151.charternc.net ([66.169.84.151]:58240
	"EHLO orp.orf.cx") by vger.kernel.org with ESMTP id <S286009AbRLHWY1>;
	Sat, 8 Dec 2001 17:24:27 -0500
Message-Id: <200112082224.fB8MOQQ11026@orp.orf.cx>
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Leigh Orf <orf@mailbag.com>
To: linux-kernel@vger.kernel.org
Organization: Department of Tesselating Kumquats
X-URL: http://orf.cx
X-face: "(Qpt_9H~41JFy=C&/h^zmz6Dm6]1ZKLat1<W!0bNwz2!LxG-lZ=r@4Me&uUvG>-r\?<DcDb+Y'p'sCMJ
Subject: Re: 2.4.16 memory badness (reproducible) 
In-Reply-To: Your message of "Sat, 08 Dec 2001 16:42:10 EST."
             <200112082142.fB8LgAb02089@orp.orf.cx> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 08 Dec 2001 17:24:25 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


More clues...

The only way I can seem to bring the machine back to being totally
normal after buff/cache fullness is to force some swap to be written,
such as by doing

lmdd opat=1 count=1 bs=900m

If I do

lmdd opat=1 count=1 bs=500m

about 500MB of memory is freed but no swap is written, and modify_ldt
still returns ENOMEM if I run xmms, display, etc....

It looks like the problem is somewhere in vmalloc since that's what
returns a null pointer where ENOMEM gets set in arch/i386/kernel/ldt.c

BTW I have been running kernels with

CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y

I am compiling a kernel with

CONFIG_NOHIGHMEM=y

and will see if the bad memory behavior continues.

Leigh Orf

Leigh Orf wrote:

|   I've noticed a couple more things with the memory allocation
|   problem with large buffer and cache allocation. Some
|   applications will fail with ENOMEM *even if* there is a
|   considerable amount (say, 62 MB as below) of "truly" free
|   memory.
|
|   The second thing I've noticed is that all these apps that die
|   with ENOMEM pretty much have the same strace output towards
|   the end. What is strange is "display *.tif" dies while "ee
|   *.tif" and "gimp *.tif" does not. Piping the strace output of
|   commands that *don't* cause this behavior and grepping for
|   modify_ldt shows that modify_ldt is *not* being called for
|   apps that *don't* die.
|
|   So I don't know if it's a symptom or a cause, but modify_ldt
|   seems to be triggering the problem. Not being a kernel
|   hacker, I leave the analysis of this to those who are.
|
|   Leigh Orf


