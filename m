Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266407AbSLDL0w>; Wed, 4 Dec 2002 06:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266408AbSLDL0w>; Wed, 4 Dec 2002 06:26:52 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:45579 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S266407AbSLDL0v>; Wed, 4 Dec 2002 06:26:51 -0500
Date: Wed, 4 Dec 2002 12:34:19 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: #! incompatible -- binfmt_script.c broken?
Message-ID: <20021204113419.GA20282@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tried some of the Perl magic tricks shown in the perlrun man page with
Linux 2.4.19; consider this Perl one-liner. It works on FreeBSD and
Solaris, but fails on Linux. Looking at binfmt_script.c, I believe the
"pass the rest of the line as the first argument to the interpreter" is
the problem with Linux. Haven't yet figured if the other boxes just use
the interpreter, ignoring the arguments or if they are doing argument
splitting.

------------------------------------------------------------------------
#!/bin/sh -- # -*- perl -*- -T
eval 'exec perl -wTS $0 ${1+"$@"}'
  if 0; 
print "Hello there.\n";
------------------------------------------------------------------------

FreeBSD 4.7:
$ /tmp/try.pl
Hello there.

Solaris 8:
$ /tmp/try.pl
Hello there.

SuSE Linux 7.0, 7.3, 8.1 (2.4.19 kernel, binfmt_script.c identical to
2.4.20 BK):
$ /tmp/try.pl
/bin/sh: -- # -*- perl -*- -T: invalid option
Usage:  /bin/sh [GNU long option] [option] ...
        /bin/sh [GNU long option] [option] script-file ...
[...]

-- 
Matthias Andree
