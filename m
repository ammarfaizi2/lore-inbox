Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130650AbRCFMeZ>; Tue, 6 Mar 2001 07:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130647AbRCFMeP>; Tue, 6 Mar 2001 07:34:15 -0500
Received: from big-relay-1.ftel.co.uk ([192.65.220.123]:8939 "EHLO
	old-callisto.ftel.co.uk") by vger.kernel.org with ESMTP
	id <S130636AbRCFMeF>; Tue, 6 Mar 2001 07:34:05 -0500
Message-ID: <3AA4D92D.CDDB764D@ftel.co.uk>
Date: Tue, 06 Mar 2001 12:33:49 +0000
From: Paul Flinders <P.Flinders@ftel.co.uk>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
CC: Jeff Mcadams <jeffm@iglou.com>, Rik van Riel <riel@conectiva.com.br>,
        John Kodis <kodis@mail630.gsfc.nasa.gov>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, bug-bash@gnu.org
Subject: Re: binfmt_script and ^M
In-Reply-To: <20010305095512.A30787@tux.gsfc.nasa.gov>
		<Pine.LNX.4.21.0103051224450.5591-100000@imladris.rielhome.conectiva>
		<20010305105943.A25964@iglou.com> <3AA3BC4E.FA794103@ftel.co.uk>
		<jeae70m97e.fsf@hawking.suse.de> <3AA3EEDF.D0547D4@dawa.demon.co.uk> <jeae6zkwmy.fsf@hawking.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab wrote:

> Paul Flinders <paul@dawa.demon.co.uk> writes:
>
> |> Andreas Schwab wrote:
> |>
> |> > This [isspace('\r') == 1] has no significance here.  The right thing to
> |>
> |> > look at is $IFS, which does not contain \r by default.  The shell only splits
> |>
> |> > words by "IFS whitespace", and the kernel should be consistent with it:
> |> >
> |> > $ echo -e 'ls foo\r' | sh
> |> > ls: foo: No such file or directory
> |>
> |> The problem with that argument is that #!<interpreter> can be applied
> |> to more than just shells which understand $IFS, so which environment
> |> variable does the kernel pick?
>
> The kernel should use the same default value of IFS as the Bourne shell,
> ie. the same value you'll get with /bin/sh -c 'echo "$IFS"'.  This is
> independent of any settings in the environment.
>
> |> It's a difficult one - logically white space should terminate the interpreter
>
> No, IFS-whitespace delimits arguments in the Bourne shell.

Way back whenever processing #! was moved from the
shell to the kernel** this argument would have made sense -
today I'm not so sure.

But I'm quite happy for the kernel to use just space and
tab if it wishes, or anything else for that matter but it _is_
confusing that the error code doesn't distinguish problems
with the script from problems with the interpreter.

**Did linux ever rely on the shell for this?

