Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUBWVqU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 16:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbUBWVqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 16:46:20 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:14985 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262006AbUBWVqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 16:46:17 -0500
Date: Mon, 23 Feb 2004 13:46:10 -0800
From: Paul Jackson <pj@sgi.com>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: jamie@shareable.org, hjlipp@web.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-Id: <20040223134610.3b6d01a9.pj@sgi.com>
In-Reply-To: <20040223173446.GA2830@pclin040.win.tue.nl>
References: <20040216133418.GA4399@hobbes>
	<20040222020911.2c8ea5c6.pj@sgi.com>
	<20040222155410.GA3051@hobbes>
	<20040222125312.11749dfd.pj@sgi.com>
	<20040222225750.GA27402@mail.shareable.org>
	<20040222214457.6f8d2224.pj@sgi.com>
	<20040223142215.GB30321@mail.shareable.org>
	<20040223173446.GA2830@pclin040.win.tue.nl>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
>  If there is such nonblank text then for SysVR4,
>  SunOS, Solaris, IRIX, HPUX, AIX, Unixware, Linux, OpenBSD, Tru64
>  this group consists of precisely one argument.
>  FreeBSD, BSD/OS, BSDI split the text

Interesting - I notice that 9 Operating Systems, in addition to Linux,
don't split the optional shebang argument, and 3 do.

All else equal, I am not enthusiastic about a somewhat arbitrary change
that could be done either way, that is actually done more often in other
operating systems the current way, and that potentially affects both
script files and their interpreters (shells, awk, perl, python, guile,
tcl, bc, ...).

I will acknowledge however that if there was a shell or interpreter that
allowed at most one '-' prefixed option before the path to the script
file to be interpreted, that that shell or interpreter would be poorly
coded.

And, to be truthful, the usual way that I code awk scripts is not as
a shbang script with an interpreter of awk,

  #!/bin/awk
  BEGIN ...

but rather as a quoted awk script within a shell script:

  #!/bin/sh
  awk '
    BEGIN ...
  '

It is then trivial to supply one or several options to 'awk', and
(as the tclsh man page notes) to cope with possible diverse locations
along $PATH of the interpreter.

This is especially useful in the case of awk, since it is not a
convenient language for many things that are easily done in a shell.
That is, I don't write awk scripts, so much as I write shell scripts
that might make use of awk.

This is a portable habit, that avoids all the afore mentioned
limitations and inconsistencies in shbang handling.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
