Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131049AbRCFSSD>; Tue, 6 Mar 2001 13:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131050AbRCFSRx>; Tue, 6 Mar 2001 13:17:53 -0500
Received: from mail.valinux.com ([198.186.202.175]:24588 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S131049AbRCFSRk>;
	Tue, 6 Mar 2001 13:17:40 -0500
Date: Tue, 6 Mar 2001 10:17:33 -0800
To: Paul Flinders <P.Flinders@ftel.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: binfmt_script and ^M (historical note)
Message-ID: <20010306101733.L28504@valinux.com>
In-Reply-To: <20010305095512.A30787@tux.gsfc.nasa.gov> <Pine.LNX.4.21.0103051224450.5591-100000@imladris.rielhome.conectiva> <20010305105943.A25964@iglou.com> <3AA3BC4E.FA794103@ftel.co.uk> <jeae70m97e.fsf@hawking.suse.de> <3AA3EEDF.D0547D4@dawa.demon.co.uk> <jeae6zkwmy.fsf@hawking.suse.de> <3AA4D92D.CDDB764D@ftel.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AA4D92D.CDDB764D@ftel.co.uk>; from P.Flinders@ftel.co.uk on Tue, Mar 06, 2001 at 12:33:49PM +0000
From: Don Dugger <n0ano@valinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul-

Minor historical note.  The `#!' processing was never done by the
shell, this was always done in the kernel.  Think about about it,
the `#' character denotes a comment line, the shell ignores that
line.  `#!' was used to create a way for the kernel to execute
a shell script directly.  Since the kernel recognized the type of
executable based on a 16-bit magic number `#!' became a new magic
number that meant "break the remainder of the line into `program'
and `args' and then execute `program' with `args'".

A nice side effect of this is that it became a way to create shell
scripts that worked no matter what shell a user was running.  For
efficiency, most shells just read and execute a shell script so
releasing a Bourne shell script to a group of CSH users created
problems.  At the expense of a `fork' and `exec' the `#!' magic
number solved this problem.

On Tue, Mar 06, 2001 at 12:33:49PM +0000, Paul Flinders wrote:
> Andreas Schwab wrote:
> 
> > Paul Flinders <paul@dawa.demon.co.uk> writes:
> >
> > |> Andreas Schwab wrote:
> > |>
> > |> > This [isspace('\r') == 1] has no significance here.  The right thing to
> > |>
> > |> > look at is $IFS, which does not contain \r by default.  The shell only splits
> > |>
> > |> > words by "IFS whitespace", and the kernel should be consistent with it:
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
> > |> It's a difficult one - logically white space should terminate the interpreter
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
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Don Dugger
"Censeo Toto nos in Kansa esse decisse." - D. Gale
n0ano@valinux.com
Ph: 303/938-9838
