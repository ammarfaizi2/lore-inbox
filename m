Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262937AbSLJRMM>; Tue, 10 Dec 2002 12:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262871AbSLJRML>; Tue, 10 Dec 2002 12:12:11 -0500
Received: from fmr05.intel.com ([134.134.136.6]:12737 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S262937AbSLJRMH>; Tue, 10 Dec 2002 12:12:07 -0500
Message-ID: <002601c2a070$5694aa40$62d40a0a@amr.corp.intel.com>
From: "Rusty Lynch" <rusty@linux.co.intel.com>
To: "ALESSANDRO.SUARDI" <ALESSANDRO.SUARDI@oracle.com>,
       <rusty@rustcorp.com.au>
Cc: <linux-kernel@vger.kernel.org>
References: <2105495.1039535073217.JavaMail.nobody@web55.us.oracle.com>
Subject: Re: module-init-tools 0.9.3 -- "missing" issue
Date: Tue, 10 Dec 2002 09:19:46 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see the same thing on my RH 8.0 box (autoconf 2.53).   I can still build, I just get the warning.  Although it looks like autoconf
does this by design because after running aclocal my aclocal.m4 has some extra code added to the end that causes this ==>

# AM_MISSING_HAS_RUN
# ------------------
# Define MISSING if not defined so far and test if it supports --run.
# If it does, set am_missing_run to use it, otherwise, to nothing.
AC_DEFUN([AM_MISSING_HAS_RUN],
[AC_REQUIRE([AM_AUX_DIR_EXPAND])dnl
test x"${MISSING+set}" = xset || MISSING="\${SHELL} $am_aux_dir/missing"
# Use eval to expand $SHELL
if eval "$MISSING --run true"; then
  am_missing_run="$MISSING --run "
else
  am_missing_run=
  AC_MSG_WARN([`missing' script is too old or missing])
fi
])

----- Original Message -----
From: "ALESSANDRO.SUARDI" <ALESSANDRO.SUARDI@oracle.com>
To: <rusty@rustcorp.com.au>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, December 10, 2002 7:44 AM
Subject: module-init-tools 0.9.3 -- "missing" issue


> As per the README...
>
> [asuardi@dolphin module-init-tools-0.9.3]$ aclocal
> [asuardi@dolphin module-init-tools-0.9.3]$ automake --add-missing --copy
> Makefile.am: installing `./depcomp'
> [asuardi@dolphin module-init-tools-0.9.3]$ autoconf
> [asuardi@dolphin module-init-tools-0.9.3]$ ./configure --prefix=/
> checking build system type... i686-pc-linux-gnu
> checking host system type... i686-pc-linux-gnu
> checking target system type... i686-pc-linux-gnu
> checking for a BSD-compatible install... /usr/bin/install -c
> checking whether build environment is sane... yes
> /download/kernel/v2.5/module-init-tools-0.9.3/missing: Unknown `--run' option
> Try `/download/kernel/v2.5/module-init-tools-0.9.3/missing --help' for more information
> configure: WARNING: `missing' script is too old or missing
> checking for gawk... gawk
> checking whether make sets ${MAKE}... yes
> checking for gcc... gcc
> checking for C compiler default output... a.out
> checking whether the C compiler works... yes
> checking whether we are cross compiling... no
> checking for suffix of executables...
> checking for suffix of object files... o
> checking whether we are using the GNU C compiler... yes
> checking whether gcc accepts -g... yes
> checking for style of include used by make... GNU
> checking dependency style of gcc... gcc3
> configure: creating ./config.status
> config.status: creating Makefile
> config.status: executing depfiles commands
>
> So - it complains about 'missing' not knowing the --run option. Indeed:
>
> [asuardi@dolphin module-init-tools-0.9.3]$ ./missing --help
> ./missing [OPTION]... PROGRAM [ARGUMENT]...
>
> Handle `PROGRAM [ARGUMENT]...' for when PROGRAM is missing, or return an
> error status if there is no known handling for PROGRAM.
>
> Options:
>   -h, --help      display this help and exit
>   -v, --version   output version information and exit
>
> Supported PROGRAM values:
>   aclocal      touch file `aclocal.m4'
>   autoconf     touch file `configure'
>   autoheader   touch file `config.h.in'
>   automake     touch all `Makefile.in' files
>   bison        create `y.tab.[ch]', if possible, from existing .[ch]
>   flex         create `lex.yy.c', if possible, from existing .c
>   lex          create `lex.yy.c', if possible, from existing .c
>   makeinfo     touch the output file
>   yacc         create `y.tab.[ch]', if possible, from existing .[ch]
> [asuardi@dolphin module-init-tools-0.9.3]$
>
>
> Unfortunately I'm a newbie in the new module-init-tools && little time to
>  dig deeper, so take this as a very simple report. Thanks,
>
> --alessandro
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

