Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129408AbQKXHR5>; Fri, 24 Nov 2000 02:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129434AbQKXHRr>; Fri, 24 Nov 2000 02:17:47 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:5023 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S129408AbQKXHRk>;
        Fri, 24 Nov 2000 02:17:40 -0500
Date: Fri, 24 Nov 2000 01:47:37 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: Andries.Brouwer@cwi.nl, greg@linuxpower.cx, alan@lxorguk.ukuu.org.uk,
        bernds@redhat.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: gcc-2.95.2-51 is buggy
In-Reply-To: <14878.58.908955.701821@notabene.cse.unsw.edu.au>
Message-ID: <Pine.GSO.4.21.0011240114000.12702-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Nov 2000, Neil Brown wrote:

> Ditto for gcc-2.95.2-13 from Debian (potato). It exhibits the same
> bug.
> Debian applies a total of 49 patches to gcc and the libraries.
> 
> I am tempted to write a little script which discards the patches one
> by one and re-builds and re-tests each time, and leave it going all
> night.... but I'm not sure if I actually will.

Not all of them are applied on x86:
%  cat stamps/02-patch-stamp-*|less
bootstrap patches applied.
cpp-dos-newlines patches applied.
cpp-macro-doc patches applied.
gcc-cvs-updates-20000220 patches applied.
gcc-default-arch patches applied.
gcc-empty-struct-init patches applied.
gcc-manpage patches applied.
gcc-pointer-arith patches applied.
gcj-debian-policy patches applied.
gcj-vs-iconv patches applied.
gpc-2.95 patches applied.
gpc-updates patches applied.
libg++-update patches applied.
libobjc patches applied.
libstdc++-bastring patches applied.
libstdc++-out-of-mem patches applied.
libstdc++-wall3 patches applied.
libstdc++-wstring patches applied.
reporting patches applied.

And only 4 have any chance to be relevant: gcc-cvs-updates-20000220,
gcc-default-arch, gcc-empty-struct-init. Unfortunately, the first one
is ~100Kb worth of changes. Hmmm... After some cleaning the whole thing
boils down to 11Kb. And I seriously suspect that relevant bits are
in cse.c, loop.c or toplev.c, with the first two being the most likely
candidates (all coming from the -cvs-updates-20000220)...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
