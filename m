Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318257AbSIOVCl>; Sun, 15 Sep 2002 17:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318258AbSIOVCl>; Sun, 15 Sep 2002 17:02:41 -0400
Received: from line106-15.adsl.actcom.co.il ([192.117.106.15]:58497 "EHLO
	www.veltzer.org") by vger.kernel.org with ESMTP id <S318257AbSIOVCk>;
	Sun, 15 Sep 2002 17:02:40 -0400
Message-Id: <200209152118.g8FLIeL26371@www.veltzer.org>
Content-Type: text/plain; charset=US-ASCII
From: Mark Veltzer <mark@veltzer.org>
Organization: Meta Ltd.
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG?] binfmt_script: interpreted interpreter doesn't work
Date: Mon, 16 Sep 2002 00:18:35 +0300
X-Mailer: KMail [version 1.3.2]
References: <Pine.GSO.4.30.0209151910220.22107-100000@balu> <20020915220651.C642@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20020915220651.C642@nightmaster.csn.tu-chemnitz.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 15 September 2002 23:06, Ingo Oeser wrote:
> Hi Pozsar,
>

> Right, this isn't allowed to avoid eating kernel resources
> without getting anything done.

You mean like writing a program to calculate PI to the 1,000,000th digit ?
The kernel is not supposed to dictate what is done with it. If the user wants 
to link 10,000 such scripts in a chain then let him. I suspect that that 
isn't the problem. The problem is that before the launch of the program the 
time is not counted as time spent on that specific user and so this could be 
used as loop hole to drain resources from other users. If this is the case 
then this time should be accounted for (I'm not sure about this though and if 
the time is accounted for then I don't see any reason to disable the chains 
except avoiding cycles which needs some coding). 

>
> Solution is to always compile an interpreter or to write
> a wrapper in C, which is compiled and calls the perl interpreter
> with your perl script. This wrapper would be ANSI-C with really
> basic POSIX extensions and should thus be as portable as perl ;-)

There is actually already a program that one can use. It's /usr/bin/env and 
is part of the sh-utils package from GNU. I always use and instead of writing 
something like:

#!/usr/bin/perl
.....

I write:

#!/usr/bin/env perl
.....

This way the users preferred perl is used and I'm reducing all my arbitrary 
assumptions about locations of executables to one assumption about the 
location of /usr/bin/env (one hardcoded fact is better than many cause it's 
easier to fix if need be).

You can use env to solve your problem. In your scripts replace all shbang 
lines. /usr/bin/env is, ofcourse, a binary executable.

Name: Mark Veltzer
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9hPkuxlxDIcceXTgRAgB+AKCJ8JtVKrpNfnaTy7/kQASSEtxsdACgyPl/
czeMVYsD5Qp+da49hyoPpFc=
=Ux8a
-----END PGP SIGNATURE-----
