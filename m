Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311898AbSECNcG>; Fri, 3 May 2002 09:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312379AbSECNcF>; Fri, 3 May 2002 09:32:05 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:9996 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S311898AbSECNcA>;
	Fri, 3 May 2002 09:32:00 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: Your message of "03 May 2002 12:05:01 GMT."
             <slrnad4v7c.i01.kraxel@bytesex.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 May 2002 23:31:48 +1000
Message-ID: <12882.1020432708@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 May 2002 12:05:01 GMT, 
Gerd Knorr <kraxel@bytesex.org> wrote:
>Keith Owens wrote:
>>  Coding a special case to work out if the existing global makefile can
>>  be reused is horribly error prone.
>
>Special case?  I'd say it is the common case when doing kernel
>development.  At least I don't use another compiler for every second
>make.  I usually hack some piece of code and recompile the module then.

We learnt the hard way in kbuild 2.4 that trying to optimize the build
by checking for special cases wasted far more time in solving wierd
problems than it ever saved, every time the optimization was wrong we
generated invalid kernels and modules.  Experience showed that
over-optimization was a BIG mistake.

The pre-processing programs do more than just build the global
makefile, they do a ton of integrity checking as well.  If you bypass
the makefile generation then I cannot guarantee the results.  Most of
the time is taken in finding all the files and doing the integrity
checks, the actual generation step is pretty fast.

You are complaining about a system that is already far more accurate
than the old build system, has more features and it still manages to be
faster than kbuild 2.4.  I am not going to sacrifice build accuracy for
the sake of shaving a few more seconds off the build time, it is
already faster than the old system.  Especially when I have to add and
maintain extra code in order to make the build less reliable!


I suspect that some users are put off by the small amount of output
from kbuild 2.5, they are used to all the noise from kbuild 2.4 and
they equate noise with "something is being done".  Perhaps I should add
CONFIG_PROVIDE_RANDOM_NOISE_TO_KEEP_THE_USER_AMUSED to kbuild 2.5, with
sub-options for dots, hashes, twirling bars and

              \|/ ____ \|/
              "@'/ ,. \`@"
              /_| \__/ |_\
                 \__U_/			(R) davem


Users who "know" that nothing has changed except a source file can tell
kbuild 2.5 of their opinion with NO_MAKEFILE_GEN=1.  Just don't blame
me if you get it wrong.  I provide the gun, but you have to aim it at
your own foot and pull the trigger.  Like everything else on kbuild
2.5, NO_MAKEFILE_GEN=1 is more accurate than the 2.4 equivalent
(SUBDIRS= is broken) and faster as well.  If you cannot type 18 extra
characters on the command line, you have other problems.

For the really foolish people who "know" that the build is complete and
who want to bypass all the integrity checks that are performed during
makefile generation -

  make NO_MAKEFILE_GEN=1 \
  	I_KNOW_THAT_THIS_BUILD_MAY_BE_INCOMPLETE_BUT_I_WANT_TO_INSTALL_IT_ANYWAY=1 \
	install

When it blows up on you, you get to keep the pieces.

