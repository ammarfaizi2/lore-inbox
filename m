Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130392AbRCETt4>; Mon, 5 Mar 2001 14:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130390AbRCETtq>; Mon, 5 Mar 2001 14:49:46 -0500
Received: from dawa.demon.co.uk ([194.222.0.39]:7296 "EHLO dawa.demon.co.uk")
	by vger.kernel.org with ESMTP id <S130392AbRCETtm>;
	Mon, 5 Mar 2001 14:49:42 -0500
Message-ID: <3AA3EEDF.D0547D4@dawa.demon.co.uk>
Date: Mon, 05 Mar 2001 19:54:08 +0000
From: Paul Flinders <paul@dawa.demon.co.uk>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
CC: Paul Flinders <P.Flinders@ftel.co.uk>, Jeff Mcadams <jeffm@iglou.com>,
        Rik van Riel <riel@conectiva.com.br>,
        John Kodis <kodis@mail630.gsfc.nasa.gov>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, bug-bash@gnu.org
Subject: Re: binfmt_script and ^M
In-Reply-To: <20010305095512.A30787@tux.gsfc.nasa.gov>
		<Pine.LNX.4.21.0103051224450.5591-100000@imladris.rielhome.conectiva>
		<20010305105943.A25964@iglou.com> <3AA3BC4E.FA794103@ftel.co.uk> <jeae70m97e.fsf@hawking.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab wrote:

> This [isspace('\r') == 1] has no significance here.  The right thing to

> look at is $IFS, which does not contain \r by default.  The shell only splits

> words by "IFS whitespace", and the kernel should be consistent with it:
>
> $ echo -e 'ls foo\r' | sh
> ls: foo: No such file or directory

The problem with that argument is that #!<interpreter> can be applied
to more than just shells which understand $IFS, so which environment
variable does the kernel pick?

It's a difficult one - logically white space should terminate the interpreter
name but the definition of what is, or isn't, white space is quite definately
a user space issue. Unfortunately if you do use the user's locale to decide
you then open the possibility that whether a scipt works or not depends
on the locale - and that, surely, is equally unacceptable and deferring
to a user-space "script launcher" app is going to open yet more problems.

In the end I suspect that the only practical way out _is_ to say that the kernel
uses space (0x20) and tab (0x8) as white space and no other character.

This does miss the point though - whatever the rules are used to parse
the interpreter name it is still confusing when the error reported by the
shell is "No such file or directory". Especially when the file is sitting
in front of you. Would it be so bad to add an ENOINTERP error?



