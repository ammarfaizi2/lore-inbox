Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129439AbQKBUVq>; Thu, 2 Nov 2000 15:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129428AbQKBUVg>; Thu, 2 Nov 2000 15:21:36 -0500
Received: from Cantor.suse.de ([194.112.123.193]:17168 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129416AbQKBUVb>;
	Thu, 2 Nov 2000 15:21:31 -0500
Date: Thu, 2 Nov 2000 21:21:24 +0100
From: Andi Kleen <ak@suse.de>
To: Tim Riker <Tim@Rikers.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
Message-ID: <20001102212124.A15054@gruyere.muc.suse.de>
In-Reply-To: <20001101234058.B1598@werewolf.able.es> <200011012345.PAA20284@pizda.ninka.net> <20001101172100.A5081@fsmlabs.com> <200011020011.QAA20585@pizda.ninka.net> <8tqcng$d8p$1@cesium.transmeta.com> <3A01B8BB.A17FE178@Rikers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A01B8BB.A17FE178@Rikers.org>; from Tim@Rikers.org on Thu, Nov 02, 2000 at 11:55:55AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2000 at 11:55:55AM -0700, Tim Riker wrote:
> 1. C++ style comments
> 
> Occurs in over 4000 lines of source and header files. :-( Should be
> converted to ansi c comments? We will probably want to just skirt this
> issue for now as the next rev of ANSI C is likely to include ANSI C++
> style comments.

First C99 includes C++ comments and it is more or less the "ANSI-C" now.

I also have my doubts that it is a real portability problem in practice,
it is such a common extension that most compilers I know have some switch
to enable it and even if they didn't it would be trivial to write a small
wrapper to remove them.

> 
> 2. Inline assembly statements
> 
> mostly in arch/ tree. Frequently used in macros as well. Much of this
> will incur performance penalties if moved to external assembly files.
> Some would require moving supported C code over as well. Hence many of
> these will probably translate into conditional compilation based on the
> compiler to avoid and performance hit for the mainstream case.

That will not work out.  Linux without some form of inline assembly
sounds very unlikely. In theory you could maybe write wrappers for some
common inline assembly idioms, but in the end you'll likely need to duplicate
some files in asm/ and arch/

> 7. Macros with variable numbers of arguments
> 
> no recommendation yet.

ISO C99 has a replacement, unfortunately not gcc compatible. gcc3+ supports
it, but you would drop compatibility to older gcc releases [which would
not make you very popular..]

You also forgot named structure initializers, but C99 supports them 
again with a different syntax than gcc [I guess it would have been too easy
to just use the gcc syntax]


-Andi (who would much like to use C99 mixed statements/declarations in the kernel,
but not even gcc3 supports it yet)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
