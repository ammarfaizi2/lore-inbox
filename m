Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130779AbRCFN4M>; Tue, 6 Mar 2001 08:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130781AbRCFNzx>; Tue, 6 Mar 2001 08:55:53 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:29016 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S130779AbRCFNzr>; Tue, 6 Mar 2001 08:55:47 -0500
Date: Tue, 6 Mar 2001 07:55:15 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200103061355.HAA96253@tomcat.admin.navo.hpc.mil>
To: schwab@suse.de, Paul Flinders <paul@dawa.demon.co.uk>
Subject: Re: binfmt_script and ^M
Cc: Paul Flinders <P.Flinders@ftel.co.uk>, Jeff Mcadams <jeffm@iglou.com>,
        Rik van Riel <riel@conectiva.com.br>,
        John Kodis <kodis@mail630.gsfc.nasa.gov>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, bug-bash@gnu.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab <schwab@suse.de>:Andreas Schwab <schwab@suse.de>Andreas Schwab <schwab@suse.de>
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

IFS can be defined in the environment.

The kernel cannot use that definition because it introduces buffer limits
and a potential overflow. Besides, the kernel can run scripts from
applications that may not have or pass IFS, or it's equivalent in whatever
shell is being used (I seem to remember an Icon shell that used commas).

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
