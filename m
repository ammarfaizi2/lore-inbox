Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUBXBTN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 20:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbUBXBQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 20:16:54 -0500
Received: from imap.gmx.net ([213.165.64.20]:46731 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262167AbUBXBNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 20:13:54 -0500
X-Authenticated: #20799612
Date: Tue, 24 Feb 2004 02:13:55 +0100
From: Hansjoerg Lipp <hjlipp@web.de>
To: Paul Jackson <pj@sgi.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, jamie@shareable.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-ID: <20040224011355.GC6426@hobbes>
References: <20040216133418.GA4399@hobbes> <20040222020911.2c8ea5c6.pj@sgi.com> <20040222155410.GA3051@hobbes> <20040222125312.11749dfd.pj@sgi.com> <20040222225750.GA27402@mail.shareable.org> <20040222214457.6f8d2224.pj@sgi.com> <20040223142215.GB30321@mail.shareable.org> <20040223173446.GA2830@pclin040.win.tue.nl> <20040223134610.3b6d01a9.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040223134610.3b6d01a9.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 01:46:10PM -0800, Paul Jackson wrote:
> Andries Brouwer wrote:
> >  If there is such nonblank text then for SysVR4,
> >  SunOS, Solaris, IRIX, HPUX, AIX, Unixware, Linux, OpenBSD, Tru64
> >  this group consists of precisely one argument.
> >  FreeBSD, BSD/OS, BSDI split the text
> 
> Interesting - I notice that 9 Operating Systems, in addition to Linux,
> don't split the optional shebang argument, and 3 do.

Yes. And this shows, that Linux would not be the first OS which splits
arguments. One more reason, why I'm sure this change won't cause lots of
problems.

> All else equal, I am not enthusiastic about a somewhat arbitrary change
> that could be done either way, that is actually done more often in other
> operating systems the current way, and that potentially affects both
> script files and their interpreters (shells, awk, perl, python, guile,
> tcl, bc, ...).
[...]

As written in my previous mail, it only affects scripts, that already
have multiple arguments in the shebang line. So, I don't see a lot of
problems here.

> And, to be truthful, the usual way that I code awk scripts is not as
> a shbang script with an interpreter of awk,
> 
>   #!/bin/awk
>   BEGIN ...
> 
> but rather as a quoted awk script within a shell script:
> 
>   #!/bin/sh
>   awk '
>     BEGIN ...
>   '
> 
[...]

This may be right for awk, although I still consider wrapper scripts to
be somewhat awkward. But your argument is not true for shells, perl,
python, ... And I still think, it's somewhat strange, that perl has to
parse the shebang line of the scripts, because the OS can't do it. And
as other interpreters don't act this way, there are totally unnecessary
restrictions writing certain scripts...

> This is a portable habit, that avoids all the afore mentioned
> limitations and inconsistencies in shbang handling.

If you write scripts for several OSes you are right. On the other hand,
I don't see any reason, why one should stick to the limits of some other
operating systems, when it's not necessary. Acting this way will never
change these limitations. If the three OSes mentioned above _and_ Linux
handle the shebang line in a more sensible way, this could be one step
to get rid of these inconsistencies.

Regards,

	Hansjoerg Lipp
