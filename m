Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270682AbTHSOxR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 10:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270686AbTHSOxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 10:53:17 -0400
Received: from h80ad2795.async.vt.edu ([128.173.39.149]:57990 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S270682AbTHSOxM (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 10:53:12 -0400
Message-Id: <200308191452.h7JEqpVq025379@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged 
In-Reply-To: Your message of "Tue, 19 Aug 2003 09:54:17 +0300."
             <200308190654.h7J6sIL07040@Port.imtp.ilyichevsk.odessa.ua> 
From: Valdis.Kletnieks@vt.edu
References: <MDEHLPKNGKAHNMBLJOLKIEFLFDAA.davids@webmaster.com>
            <200308190654.h7J6sIL07040@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_572622020P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 19 Aug 2003 10:52:50 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_572622020P
Content-Type: text/plain; charset=us-ascii

On Tue, 19 Aug 2003 09:54:17 +0300, Denis Vlasenko said:

> > char *j=NULL;
> > signal(SIGSEGV, SIG_DFL);
> > *j++;

> I disagree. _exit(2) is the most sensible way to terminate.

Not if you want it *dead*, *now*, with a core dump, and with minimal disruption
of program state.  Sometimes (especially when trying to shoot a race condition)
you just can't run the program under gdb - and if it calls _exit() there's not much
wreckage left for gdb to look at....

> Logginh kernel-induced SEGVs and ILLs are definitely a help when you hunt
> daemons mysteriously crashing. This outweighs DoS hazard.

Well, I can *see* the fact it exited with a signal in 'lastcomm' already.  If that's all
the info you're providing, it's of no help.

Now, if you figure out how to read the module's -g data and give me a line number
it died at:

	kprint(DEBUG "Process %d (%s) died on  signal %d at line %d of function %s", ....

but that would involve a lot of file I/O from kernelspace, soo.....

--==_Exmh_572622020P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/QjnBcC3lWbTT17ARAuKjAKDEibMr+La3grxnkcfBDMqC2M5ZKwCfXT8V
UIo+EBSt6o7iFZd58gW3XmA=
=owc3
-----END PGP SIGNATURE-----

--==_Exmh_572622020P--
