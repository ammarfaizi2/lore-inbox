Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287019AbRL2B2D>; Fri, 28 Dec 2001 20:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287038AbRL2B1y>; Fri, 28 Dec 2001 20:27:54 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:12560 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S287019AbRL2B1i>;
	Fri, 28 Dec 2001 20:27:38 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Legacy Fishtank <garzik@havoc.gtf.org>, linux-kernel@vger.kernel.org,
        Larry McVoy <lm@bitmover.com>, "Eric S. Raymond" <esr@thyrsus.com>,
        Dave Jones <davej@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system 
In-Reply-To: Your message of "Fri, 28 Dec 2001 14:17:24 -0800."
             <Pine.LNX.4.33.0112281416290.23445-100000@penguin.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 29 Dec 2001 12:27:24 +1100
Message-ID: <7861.1009589244@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001 14:17:24 -0800 (PST), 
Linus Torvalds <torvalds@transmeta.com> wrote:
>
>On Fri, 28 Dec 2001, Legacy Fishtank wrote:
>>
>> I think one thing to note is that dependencies is that if you are smart
>> about it, dependencies -really- do not even change when your .config
>> changes.
>
>Absolutely. I detest "gcc -MD", exactly because it doesn't get this part
>right. "mkdep.c" gets this _right_.

Sorry, it does not.  Everybody is attacking little bits of the
dependency problem, any solution that does not fix _all_ 9 problems in
http://prdownloads.sourceforge.net/kbuild/kbuild-2.5-history.tar.bz2,
makefile-2.5_make_dep.html is not a complete fix.

Yes, some of the problems with mkdep can be fixed in the current design
but there is one problem that is inherently unfixable.  make dep is a
manual process so it relies on users knowing when they have to rerun
make dep AND THEY DON'T DO IT!  Please do not say "I always run make
dep" after a change, I guarantee that you are the exception.  Users
apply patches and do not run make dep, then wonder why their kernel is
broken.

Dependencies _do_ change when your .config changes, the list of files
that are included varies.  gcc -MD gets this exactly right, gcc knows
which files it read.  mkdep does an incorrect approximation, see tyhe
bug list in makefile-2.5_make_dep.html.

The errors in mkdep were acceptable as long as only kernel hackers
built their own kernels, they could be relied upon to manually run
commands when necessary.  The target population has changed, more and
more beginners are building kernels and too many are getting it wrong.
I am aiming at the entire population, not that small subset who have
been building kernels since the year dot.

Any build system that silently fails when users forget to run a command
is a broken system.  kbuild 2.5 fixes _all_ 9 problems with mkdep, it
also positions us for correct modversion handling.  kbuild 2.4 is
faster, inaccurate and manual, kbuild 2.5 is slower, accurate and
totally automatic.

I know how to speed up 2.5.  What I don't have is time to rewrite the
code for speed, I am too busy tracking kernel changes because kbuild
2.5 is not in the kernel yet.

Linus, you have a choice between a known broken build system and a
clean and reliable system, which is slightly slower in mark 1.  Please
add kbuild 2.5 to the kernel, then I will have time to rewrite the core
programs for speed.  Mark 2 of the core code will be significantly
faster.

ps. I don't want mail discussing individual bug fixes to mkdep.  Code
    that does not fix _all_ 9 bugs listed in makefile-2.5_make_dep.html
    is pointless.

