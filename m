Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbRCTKOE>; Tue, 20 Mar 2001 05:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129529AbRCTKNz>; Tue, 20 Mar 2001 05:13:55 -0500
Received: from fs1.dekanat.physik.uni-tuebingen.de ([134.2.216.20]:55558 "EHLO
	fs1.dekanat.physik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S129464AbRCTKNp>; Tue, 20 Mar 2001 05:13:45 -0500
Date: Tue, 20 Mar 2001 11:12:22 +0100 (CET)
From: Richard Guenther <richard.guenther@student.uni-tuebingen.de>
To: Colin Watson <cjw44@flatline.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: How to mount /proc/sys/fs/binfmt_misc ?
In-Reply-To: <E14f5LN-0005Go-00@riva.ucam.org>
Message-ID: <Pine.LNX.4.30.0103201108440.595-100000@fs1.dekanat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Mar 2001, Colin Watson wrote:

> Alexander Viro <viro@math.psu.edu> wrote:
> >Seriously, binfmt_misc.c was written in rather, erm, interesting C.
> >Read it and you'll see. Just one (but rather impressive) example:
> >
> >        if ((count == 1) && !(buffer[0] & ~('0' | '1'))) {
> >
> >It was meant to be
> >
> >        if (count == 1 && (buffer[0] == '0' || buffer[0] == '1')) {
> >
> >and anyone who can't find the difference really should learn C. And
> >that's not the only bogosity of such level. Besides, the thing is
> >trivially oopsable - write() to any file in binfmt_misc with buffer
> >pointing to unmapped kernel address and you are screwed,
>
> Or you can register binfmt names that are registered already and
> silently shadow old ones, or register names like 'register', 'status',
> '.', and '..'. It's hideous to manage reliably from userspace.

I know you have sent me patches to prevent multiple entries of the
same name some time ago and I can see we argued about it. The main
point I have with such checks is, that we dont prevent root from
doing rm -Rf / either. There is no reason to clobber the kernel with
endless checks of such cornercases (which even dont make the system
unusable, but only one (unimportant) part of it). There is even one
truely nasty "exploit" of binfmt_misc, if you register an entry
that catches standard elf programs and do module insertion of the
elf and misc handler in the right order... how would you catch this!?

Richard.

--
Richard Guenther <richard.guenther@student.uni-tuebingen.de>
WWW: http://www.anatom.uni-tuebingen.de/~richi/
The GLAME Project: http://www.glame.de/

