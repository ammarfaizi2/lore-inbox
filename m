Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266384AbSLDOTI>; Wed, 4 Dec 2002 09:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266411AbSLDOTI>; Wed, 4 Dec 2002 09:19:08 -0500
Received: from boden.synopsys.com ([204.176.20.19]:33772 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S266384AbSLDOTH>; Wed, 4 Dec 2002 09:19:07 -0500
Date: Wed, 4 Dec 2002 15:26:28 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: #! incompatible -- binfmt_script.c broken?
Message-ID: <20021204142628.GE26745@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
References: <20021204113419.GA20282@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021204113419.GA20282@merlin.emma.line.org>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 12:34:19PM +0100, Matthias Andree wrote:
> Hi,
> 
> I tried some of the Perl magic tricks shown in the perlrun man page with
> Linux 2.4.19; consider this Perl one-liner. It works on FreeBSD and
> Solaris, but fails on Linux. Looking at binfmt_script.c, I believe the
> "pass the rest of the line as the first argument to the interpreter" is
> the problem with Linux. Haven't yet figured if the other boxes just use
> the interpreter, ignoring the arguments or if they are doing argument
> splitting.
> 
> ------------------------------------------------------------------------
> #!/bin/sh -- # -*- perl -*- -T
> eval 'exec perl -wTS $0 ${1+"$@"}'
>   if 0; 
> print "Hello there.\n";
> ------------------------------------------------------------------------
> 
> FreeBSD 4.7:
> $ /tmp/try.pl
> Hello there.
> 
> Solaris 8:
> $ /tmp/try.pl
> Hello there.
> 
> SuSE Linux 7.0, 7.3, 8.1 (2.4.19 kernel, binfmt_script.c identical to
> 2.4.20 BK):
> $ /tmp/try.pl
> /bin/sh: -- # -*- perl -*- -T: invalid option

looks correct. The interpreter (/bin/sh) has got everything after
its name. IOW: "-- # -*- perl -*- -T"
It's just solaris' shell (/bin/sh) just ignores options starting with
"--". And freebsd's as well.
Anyway - it's bash, not the bin_fmt.

> Usage:  /bin/sh [GNU long option] [option] ...
>         /bin/sh [GNU long option] [option] script-file ...
> [...]
