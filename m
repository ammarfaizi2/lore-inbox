Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280620AbRLALs2>; Sat, 1 Dec 2001 06:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284080AbRLALsT>; Sat, 1 Dec 2001 06:48:19 -0500
Received: from postfix1-2.free.fr ([213.228.0.130]:41353 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S284076AbRLALsK> convert rfc822-to-8bit; Sat, 1 Dec 2001 06:48:10 -0500
Date: Sat, 1 Dec 2001 09:54:48 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Keith Owens <kaos@ocs.com.au>
Cc: Henning Schmiedehausen <hps@intermeta.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, Larry McVoy <lm@bitmover.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Coding style - a non-issue 
In-Reply-To: <10605.1007169423@ocs3.intra.ocs.com.au>
Message-ID: <20011201093910.C1139-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Keith,

When I have had to prepare a Makefile for sym-2 as a sub-directory of
drivers/scsi (sym53c8xx_2), it didn't seem to me that a non-ugly way to do
so was possible. I mean that using sub-directory for scsi drivers wasn't
expected by the normal kernel build procedure. Looking into some network
parts that wanted to do so, I only discovered hacky stuff. This left me in
the situation I had to do this in an ugly way.

As you cannot ignore the scsi driver directory is a mess since years due
to too many sources files in an single directory. Will such ugly-ness be
cleaned up in linux-2.5?

By the way, in my opinion, a software that is as ugly as you describe but
not more looks excellentware to me. :-)

  Gérard.


On Sat, 1 Dec 2001, Keith Owens wrote:

> On 30 Nov 2001 18:15:28 +0100,
> Henning Schmiedehausen <hps@intermeta.de> wrote:
> >Are you willing to judge "ugliness" of kernel drivers? What is ugly?
> >... Is the aic7xxx driver ugly because it needs libdb ? ...
>
> Yes, and no, mainly yes.  Requiring libdb, lex and yacc to to generate
> the firmware is not ugly, user space programs can use any tools that
> the developer needs.  I have no opinion either way about the driver
> code, from what I can tell aic7xxx is a decent SCSI driver, once it is
> built.
>
> What is ugly in aic7xxx is :-
>
> * Kludging BSD makefile style into aix7ccc/aicasm/Makefile.  It is not
>   compatible with the linux kernel makefile style.
>
> * Using a manual flag (CONFIG_AIC7XXX_BUILD_FIRMWARE) instead of
>   automatically detecting when the firmware needs to be rebuilt.  Users
>   who set that flag by mistake but do not have libdb, lex and yacc
>   cannot compile a kernel.
>
> * Not checking that the db.h file it picked will actually compile and
>   link.
>
> * Butchering the modules_install rule to add a special case for aic7xxx
>   instead of using the same method that every other module uses.
>
> * Including endian.h in the aic7xxx driver, but endian.h is a user
>   space include.  Code that is linked into the kernel or a module
>   MUST NOT include user space headers.
>
> * Not correctly defining the dependencies between generated headers and
>   the code that includes those headers.  Generated headers require
>   explicit dependencies, the only reason it works is because aic7xxx ...
>
> * Ships generated files and overwrites them under the same name.
>   Shipping generated files is bad enough but is sometime necessary when
>   the end user might not have the tools to build the files (libdb, lex,
>   yacc).  Overwriting the shipped files under the same name is asking
>   for problem with source repositories and generating spurious diffs.
>
> All of the above problems are caused by a developer who insists on
> doing his own makefile style instead of following the kernel standards
> for makefiles.  Developers with their own standards are BAD!
>
> BTW, I have made repeated offers to rewrite the aic7xx makefiles for
> 2.4 but the aic7xxx maintainer refuses to do so.  I _will_ rewrite them
> in 2.5, as part of the kernel build 2.5 redesign.
>
> Keith Owens, kernel build maintainer.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

