Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbTBAAVA>; Fri, 31 Jan 2003 19:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbTBAAVA>; Fri, 31 Jan 2003 19:21:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2825 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261857AbTBAAU7>; Fri, 31 Jan 2003 19:20:59 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Perl in the toolchain
Date: 31 Jan 2003 16:29:47 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b1f4dr$5ut$1@cesium.transmeta.com>
References: <20030131133929.A8992@devserv.devel.redhat.com> <20030131213827.GA1541@werewolf.able.es> <20030131222257.GA11011@mars.ravnborg.org> <3E3B0557.3070400@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3E3B0557.3070400@pobox.com>
By author:    Jeff Garzik <jgarzik@pobox.com>
In newsgroup: linux.dev.kernel
> 
> This is a logically correct argument, but also one that ignores basic 
> numbers.
> 
> The fact of the matter is, the area of build tools matters most to 
> people who cross-compile their kernels, because every tool is generally 
> hand-built rather than automatically installed on their Linux system. 
> For this audience, as well as the typical non-cross-compiling kernel 
> developer, Perl is on their system.
> 
> However, that fact is less significant than the more basic and core 
> argument:
> 
> klibc uses perl for text munging.  i.e. one of Perl's acknowledged 
> strengths.  This is not a case of choosing a favorite script language, 
> but instead a case of choosing "the right tool for the job."  Regardless 
> of whether you think Perl is line noise :) or not, from a technical 
> basis Perl is clearly superior to sed+awk in this case.
> 

Thanks Jeff :)

To emphasize things a bit further, Perl is:

a) good at munging text;
b) available on basically all development systems;
c) not host- or target-specific.

Thus, I cannot see it as being an issue, and I challenge anyone to
find a machine on which they regularly build kernels which doesn't
have Perl.  Like it or not, today it's as much a part of a
general-purpose Unix platform as sed or awk.

Yes, you can write complete shit code in Perl.  You can write shit
code in any language (Perl does, however, make it easier, so if you're
programming in Perl you need to watch out for this.)  Yes, you can
require 47 different obscure interdependent modules which were just
released last week on CPAN, but you can require an equivalent number
of obscure libraries in C.  Doing that, or require features only
available in very recent versions of Perl, would be wholly
inappropriate for the kernel build.  My personal rule of thumb is that
it should work at least as far back as Perl 5.004.

There is one klibc script which possibly ought to be rewritten, and
that is the one that uses Digest::MD5 which may not be available on
some very old platforms.  If so, I'd probably just include the MD5
digest code in the script itself, rather than having to deal with C
code that is compiled for the host in the klibc tree.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: cris ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
