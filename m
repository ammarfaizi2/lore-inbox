Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263458AbTECWjt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 18:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263459AbTECWjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 18:39:49 -0400
Received: from [128.173.39.159] ([128.173.39.159]:20610 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263458AbTECWjs (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 18:39:48 -0400
Message-Id: <200305032252.h43Mq7X9006633@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: thunder7@xs4all.nl
Cc: Gabe Foobar <foobar.gabe@freemail.hu>, linux-kernel@vger.kernel.org
Subject: Re: will be able to load new kernel without restarting? 
In-Reply-To: Your message of "Sat, 03 May 2003 22:56:56 +0200."
             <20030503205656.GA19352@middle.of.nowhere> 
From: Valdis.Kletnieks@vt.edu
References: <freemail.20030403212422.18231@fm9.freemail.hu>
            <20030503205656.GA19352@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-889982082P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 03 May 2003 18:52:07 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-889982082P
Content-Type: text/plain; charset=us-ascii

On Sat, 03 May 2003 22:56:56 +0200, Jurriaan said:

> > Just a simple question. When I will be able to load new
> > kernel without restarting the system? Working anybody on
> > this problem?

> Check the archives for 'kexec'. Some success messages were posted even
> today.
> 

As I understand it, that's still restarting, just skipping the usual detour
through the BIOS and lilo/grub/whatever.

What he wants is the sort of on-the-fly upgrading that bellheads have grown to
know and love, and which is NOT likely to be implemented for the entire Linux
kernel anytime soon.  Large sections can do it now with the "module" stuff, so
you can rmmod the old one and insmod the new one.. but I don't see any easy way
to implement rmmmod/insmod semantics for things like kernel/schedule.c (how
would you get your next timeslice?).  There's also issues with changing the
API for something - it's hard to drop a 2.5.71 kernel/signals.c into a 2.5.70
kernel if the API is different.  Googling around will probably cough up
lots of references to how the telcos do software upgrades - it basically
involves LOTS of up-front design work to make sure all the details are
addressed in the basic design of the system.

Bottom line - you can do it now for things that can be built as modules,
*if* it's something you can effectively rmmod and insmod.  If it's not a module,
or if it's the driver for something you can't rmmod (a disk or network driver,
etc), you can't do it on-the-fly.


--==_Exmh_-889982082P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+tEgWcC3lWbTT17ARAipeAKDXI7/xjQaVzg9HQW7+pQpJRHkH8wCg0mAF
p+dGwFcpwR1X8ayWfGQ738I=
=CHbq
-----END PGP SIGNATURE-----

--==_Exmh_-889982082P--
