Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbVBVAg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbVBVAg2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 19:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVBVAg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 19:36:28 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:62733 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262184AbVBVAgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 19:36:23 -0500
Message-Id: <200502220036.j1M0aDxr012054@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Anthony DiSante <theant@nodivisions.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: uninterruptible sleep lockups 
In-Reply-To: Your message of "Mon, 21 Feb 2005 19:06:23 EST."
             <421A777F.1010802@nodivisions.com> 
From: Valdis.Kletnieks@vt.edu
References: <421A3414.2020508@nodivisions.com> <200502211945.j1LJjgbZ029643@turing-police.cc.vt.edu> <421A4375.9040108@nodivisions.com> <200502212054.j1LKs3xi032658@turing-police.cc.vt.edu> <421A5E28.1030409@nodivisions.com> <421A6426.6020802@nortel.com>
            <421A777F.1010802@nodivisions.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1109032573_9072P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 21 Feb 2005 19:36:13 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1109032573_9072P
Content-Type: text/plain; charset=us-ascii

On Mon, 21 Feb 2005 19:06:23 EST, Anthony DiSante said:

> The driver code for my devices has "been given" to me as part of the kernel. 
>   Any of a handful of USB devices has caused permanent D states, as has a 
> CDROM and a NIC.  I guess I'll need to start debugging all of these drivers. 
>   When something goes into permanent D sleep, what should I do to start 
> tracking down the problem?  Aside from obvious stuff like dmesg and checking 
> /var/log/messages, neither of which ever seems to say anything useful when 
> this happens.

Alt-Sysrq-T and provide the tracebacks for the wedged process(es). That,
and the other info suggested in the linux/REPORTING-BUGS file will go a long
way to actually getting things fixed.

> > Kernel bugs are not acceptable.
> 
> That's a nice-sounding ideal, but the truth is that kernel bugs exist and 
> are not uncommon.

Yes, but how do you write a "unwedge the hung process" daemon, given that said
daemon needs to know what the bug the process hit was in order to properly
unwedge it (at which point it's easier just to *fix* the frikking bug), and
also given that said unwedger will itself have bugs.

If you need further convincing, look at the rock-solid OOM-killer code, which has
a lot of the same issues as a zombie-unwedger - and all *it* has to do is deliver
a 'kill -9' to the right process.  It doesn't have to unsnarl memory allocations
and locks and semaphores and PCI resources and all the rest....

--==_Exmh_1109032573_9072P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCGn58cC3lWbTT17ARArKlAKC7YgWehgsAeLjupl1qYxj4WzuqowCfZQ66
JOBF4h82LSc0vtuqEQIRzjo=
=eEVY
-----END PGP SIGNATURE-----

--==_Exmh_1109032573_9072P--
