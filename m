Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267117AbSLDWS1>; Wed, 4 Dec 2002 17:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267122AbSLDWS1>; Wed, 4 Dec 2002 17:18:27 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:1032 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S267117AbSLDWS0>;
	Wed, 4 Dec 2002 17:18:26 -0500
Date: Wed, 4 Dec 2002 23:25:58 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: #! incompatible -- binfmt_script.c broken?
Message-ID: <20021204222558.GA7842@win.tue.nl>
References: <20021204113419.GA20282@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021204113419.GA20282@merlin.emma.line.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 12:34:19PM +0100, Matthias Andree wrote:

> I tried some of the Perl magic tricks shown in the perlrun man page with
> Linux 2.4.19; consider this Perl one-liner. It works on FreeBSD and
> Solaris, but fails on Linux.
> 
> ------------------------------------------------------------------------
> #!/bin/sh -- # -*- perl -*- -T
> eval 'exec perl -wTS $0 ${1+"$@"}'
>   if 0; 
> print "Hello there.\n";
> ------------------------------------------------------------------------
> 
> FreeBSD 4.7 and Solaris 8:
> $ /tmp/try.pl
> Hello there.
> 
> SuSE Linux 7.0, 7.3, 8.1
> $ /tmp/try.pl
> /bin/sh: -- # -*- perl -*- -T: invalid option

See http://www.cwi.nl/~aeb/std/hashexclam-1.html

There I wrote long ago:

...
The interpreter is called with a parameter list consisting of four groups
of arguments: arg0, argi, argn, args.

The first group, arg0, consists of one argument. For SysVR4, SunOS, Solaris,
IRIX, BSDI, DU, AIX, Unixware, Linux this argument is /path/interpreter.
For FreeBSD and HPUX this argument is /scriptpath/script. 

The second group, argi, consists of the 0 or 1 or perhaps more arguments
to the interpreter found in the #! line. Thus, this group is empty if there
is no nonblank text following the interpreter name in the #! line.
If there is such nonblank text then for SysVR4, SunOS, Solaris, IRIX, HPUX,
AIX, Unixware, Linux, FreeBSD this group consists of precisely one argument,
as in the example above where argi consists of the single argument "-a -b".
BSDI splits the text following the interpreter name into zero or more arguments,
and hence has an argi consisting of the two arguments "-a", "-b" in the
above example. (Also Plan9 allows several arguments here.) 
...

Instead of trying this complicated perl example, you might try small scripts
that test one thing at a time. I am interested in the results of such tests
on various operating systems.

But regarding your post: there is no reason to assume that Linux does
something "wrong" here if it disagrees with Solaris and FreeBSD.
There is no standard and no uniformity here.

Andries
