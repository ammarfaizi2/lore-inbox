Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265337AbTFRQBP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 12:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265338AbTFRQBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 12:01:15 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:46345 "EHLO k2.dsa-ac.de")
	by vger.kernel.org with ESMTP id S265337AbTFRQBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 12:01:09 -0400
Date: Wed, 18 Jun 2003 18:15:02 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: <P@draigBrady.com>
Cc: <linux-kernel@vger.kernel.org>, <debian-glibc@lists.debian.org>
Subject: Re: VIA Ezra CentaurHauls
In-Reply-To: <3EF07A43.8000505@draigBrady.com>
Message-ID: <Pine.LNX.4.33.0306181732530.2967-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jun 2003 P@draigBrady.com wrote:
> Guennadi Liakhovetski wrote:
> > We have a platform with the above processor, and we happened to have 2
> > revisions thereof: stepping 8 and 10. With stepping 8 we are getting
> > "random" application crashes (segfaults), sometimes with kernel-Oopses.
> > The distribution is Debian-Woody.
>
> Interesting, so stepping 10 is OK?

Looks so.

> > I saw some messages on the Debian
> > mailing list about problems with exactly this CPU, however, it was not
> > related to different revisions (stepping), perhaps, the author only had
> >  / tried stepping 8. The fix was to upgrade libc.
>
> so is it a glibc bug or CPU bug?

Good question...

> > I've done this (to version libc6_2.3.1-16, but it didn't help. Any ideas?
>
> You could search for CMOV instructions on your system,
> which could cause wierdness, like:
>
> find / -perm +111 -type f |
> while read bin; do
>      objdump --disassemble $bin 2>/dev/null |
>      grep -q cmov && echo "$bin has cmov"
> done

Yeah, will try. Plus libraries...

> Note C3 Nehemiah do have CMOV (but no 3dnow).

Meanwhile, I've written a micro-program with an assembly-inline with cmov.
I have no idea about the ix86 assembly, so, I've just done

int main(void)
{
	int x=0,y=1;

	__asm__(
	"testl	%0, %0\n"
"	cmovnz	%0, %1":"=r" (x) :"r" (y));
	exit(x);
}

On "10" the exit code is 1, which is correct (?), on "8" the exit code is
76. Funny enough, strace on "8" produces also
semget(2, 1074927648, 0)                = -1 ENOSYS (Function not implemented)
but this, most probably, comes from the new libc6, that I installed there.

Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

