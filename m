Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270779AbRHWXnL>; Thu, 23 Aug 2001 19:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270774AbRHWXnA>; Thu, 23 Aug 2001 19:43:00 -0400
Received: from adsl-64-175-255-50.dsl.sntc01.pacbell.net ([64.175.255.50]:54207
	"HELO kobayashi.soze.net") by vger.kernel.org with SMTP
	id <S270772AbRHWXmq>; Thu, 23 Aug 2001 19:42:46 -0400
Date: Thu, 23 Aug 2001 16:43:03 -0700 (PDT)
From: Justin Guyett <justin@soze.net>
X-X-Sender: <tyme@kobayashi.soze.net>
To: jacob berkman <jacob@ximian.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: mmap() return value when length == 0
In-Reply-To: <998604774.796.10.camel@wet-pants>
Message-ID: <Pine.LNX.4.33.0108231557430.7753-100000@kobayashi.soze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Aug 2001, jacob berkman wrote:

> on linux (2.4.9 and 2.2.18), the mmap() syscall will return NULL if the
> length argument is 0 rather than returning MAP_FAILED (-1).  this is
> different than both solaris and hp-ux, and the linux man page doesn't
> indicate that it should do this.
>
> so, is this indeed the desired behaviour or a longstanding bug?

Surely the posix standard would say.

The sol8 manpage says specifically that EINVAL is returned if len <= 0;

And an openbsd and freebsd box i tried it on happily do the mmaps as
well.

All three (linux, sol8, fbsd) segfault with the following code for various
values of x and y.

fd = open();
marea = mmap(0, x, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
munmap(marea, y);
fclose(fd);

mmap:
 linux
  succeeds
 sol8
  succeeds if x>0, fails otherwise
 fbsd4.3
  succeeds

munmap:
 linux
  succeeds unless x>0 and y>x, in which case it segfaults
 sol8
  succeeds
 fbsd
  succeeds

close:
 linux
  succeeds
 sol8
  segfaults if y>x
 fbsd
  segfaults if y>x


justin

