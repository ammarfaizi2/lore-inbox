Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129305AbRCFOjn>; Tue, 6 Mar 2001 09:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130824AbRCFOje>; Tue, 6 Mar 2001 09:39:34 -0500
Received: from tungsten.btinternet.com ([194.73.73.81]:62594 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S129305AbRCFOjV>; Tue, 6 Mar 2001 09:39:21 -0500
From: "Laramie Leavitt" <laramie.leavitt@btinternet.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: binfmt_script and ^M
Date: Tue, 6 Mar 2001 14:45:51 -0000
Message-ID: <JKEGJJAJPOLNIFPAEDHLEEDGCJAA.laramie.leavitt@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <3AA4D92D.CDDB764D@ftel.co.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andreas Schwab wrote:
> > Paul Flinders <paul@dawa.demon.co.uk> writes:
> > |> Andreas Schwab wrote:
> > |>
> > |> > This [isspace('\r') == 1] has no significance here.  The
> right thing to
> > |>
> > |> > look at is $IFS, which does not contain \r by default.
> The shell only splits
> > |>
> > |> > words by "IFS whitespace", and the kernel should be
> consistent with it:
> > |> >
> > |> > $ echo -e 'ls foo\r' | sh
> > |> > ls: foo: No such file or directory
> > |>
> > |> The problem with that argument is that #!<interpreter> can be applied
> > |> to more than just shells which understand $IFS, so which environment
> > |> variable does the kernel pick?
> >
> > The kernel should use the same default value of IFS as the Bourne shell,
> > ie. the same value you'll get with /bin/sh -c 'echo "$IFS"'.  This is
> > independent of any settings in the environment.
> >
> > |> It's a difficult one - logically white space should
> terminate the interpreter
> >
> > No, IFS-whitespace delimits arguments in the Bourne shell.
>
> Way back whenever processing #! was moved from the
> shell to the kernel** this argument would have made sense -
> today I'm not so sure.
>
> But I'm quite happy for the kernel to use just space and
> tab if it wishes, or anything else for that matter but it _is_
> confusing that the error code doesn't distinguish problems
> with the script from problems with the interpreter.
>
> **Did linux ever rely on the shell for this?

Maybe the correct answer would be to create a proc entry for this.
That allow the user to decide what is whitespace on his machine,
since nobody here appears to agree.

User:  hmm... Wonder what happes if i do the following
       %cat '$#! \n\t\r' > /proc/whitespace
later, % config.sh : Error file not found.
Oops, bug report... ;-)

Laramie

