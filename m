Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292389AbSBUOLr>; Thu, 21 Feb 2002 09:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292388AbSBUOLi>; Thu, 21 Feb 2002 09:11:38 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:64270 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S292387AbSBUOLV>; Thu, 21 Feb 2002 09:11:21 -0500
Date: Thu, 21 Feb 2002 15:11:14 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: Giacomo Catenazzi <cate@debian.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux kernel config converter
In-Reply-To: <3C74F5F8.3000201@debian.org>
Message-ID: <Pine.LNX.4.21.0202211456380.2650-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 21 Feb 2002, Giacomo Catenazzi wrote:

> 1) default: Eric proposed to include defaults in configuration,
>     but it seems that is a bad things, and defaults should be arch
>     specific. (I don't remember the discussion, but you can
>     parse the kbuild list, torque.net time)

The defaults are just 1:1 representation of the current define_xxx
statements. These can be of course later moved or depreciated or whatever.

> 2) One of the problem in actual configure are the dependencies.
>     FOO depend on BAR and BEER.
>     Wat are the possible value of FOO if BAR=m, BEER=y.
>     In kernel we have some drivers thet need foo to be n or y,
>     in other cases: n or m.
>     The logical operators hide the true dependency table.
>     (don't expect developers read the docs: the logical operators
>     seems like C operators, so they use like C, but they forget
>     the third case (=m) ).

For most cases I've seen it can be very simply defined with:
	(a && b && ...) = min(a, b, ...)
	(a || b || ...) = max(a, b, ...)
	for 'n'=0, 'm'=1, 'y'=2

I have to check the other cases and I haven't look too closely, yet, but
e.g. in this case it goes wrong:

config: FB_MATROX_G450
  dep_tristate
    prompt:       G450/G550 second head support
    dep: (VT? && EXPERIMENTAL? && FB? && EXPERIMENTAL? && PCI? && FB_MATROX??!=n && FB_MATROX_G100?)

CONFIG_FB_MATROX_G450 can be defined to 'y' and CONFIG_FB_MATROX to 'm',
the result is that the build goes wrong. By removing '!=n' above rule
would produce the correct result.
Do you have some real examples?

> Do you use the python identation mode?

No python. Just c, flex and bison. :-)

bye, Roman

