Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271844AbTG2P3E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 11:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271845AbTG2P3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 11:29:04 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:22912 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S271844AbTG2P3B (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 11:29:01 -0400
Message-Id: <200307291528.h6TFSo3o004775@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Timothy Miller <miller@techsource.com>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O10int for interactivity 
In-Reply-To: Your message of "Tue, 29 Jul 2003 10:21:35 EDT."
             <3F2682EF.2040702@techsource.com> 
From: Valdis.Kletnieks@vt.edu
References: <200307280112.16043.kernel@kolivas.org> <200307281808.h6SI8C5k004439@turing-police.cc.vt.edu>
            <3F2682EF.2040702@techsource.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1449650900P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 29 Jul 2003 11:28:50 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1449650900P
Content-Type: text/plain; charset=us-ascii

On Tue, 29 Jul 2003 10:21:35 EDT, Timothy Miller said:

> > I'm guessing that the anticipatory scheduler is the culprit here.  Soon as 
I figure
> > out the incantations to use the deadline scheduler, I'll report back....

> It would be unfortunate if AS and the interactivity scheduler were to 
> conflict.  Is there a way we can have them talk to each other and have 
> AS boost some I/O requests for tasks which are marked as interactive?

Well.,.. it turns out I was half right, sort of.  My remaining glitches *were*
I/O related rather than the CPU scheduler.  However, they weren't directly
related to the /sys/block/hda/queue/iosched/* values.

Turns out that at least on this laptop, 256M is just a bit tight on memory under
some conditions (well... OK... having X and xmms running, and then doing a
'tar xjvf linux-2.6.0-test1.tar.bz2' and launching OpenOffice 1.1rc1 all at once
is probably a stress test and a half ;).

Watching /proc/vmstat, it became obvious that audio skips were happening *only*
when 'pswpout' was going up - which means somebody's waiting on a page *IN*
that won't happen till another page goes *out* to swap first.....

Time for more pondering.. ;)

--==_Exmh_1449650900P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/JpKycC3lWbTT17ARAr/hAKCl4mSmWnR3kWSFC5mDZfDpIpQ60ACfZx67
i2XeNG9Q99lleYnA6e4SSv4=
=yMy0
-----END PGP SIGNATURE-----

--==_Exmh_1449650900P--
