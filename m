Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVBSAYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVBSAYZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 19:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVBSAYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 19:24:20 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:22796 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261598AbVBSAXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 19:23:17 -0500
Message-Id: <200502190023.j1J0NBDi023090@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device 
In-Reply-To: Your message of "Fri, 18 Feb 2005 15:23:44 EST."
             <cv5hv3$ana$1@gatekeeper.tmr.com> 
From: Valdis.Kletnieks@vt.edu
References: <cv36kk$54m$1@gatekeeper.tmr.com> <cv36kk$54m$1@gatekeeper.tmr.com> <20050218103107.GA15052@wszip-kinigka.euro.med.ge.com>
            <cv5hv3$ana$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1108772589_19784P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Feb 2005 19:23:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1108772589_19784P
Content-Type: text/plain; charset=us-ascii

On Fri, 18 Feb 2005 15:23:44 EST, Bill Davidsen said:

> I'll try to build a truth table for this, I'm now working with some 
> non-iso data sets, so I'm a bit more interested. I would expect read() 
> to only try to read one sector, so I'll just do a quick and dirty to get 
> the size from the command line, seek and read.
> 
> I haven't had a problem using dd to date, as long as I know how long the 
> data set was, but I'll try to have results tonight.

The problem is that often you don't know exactly how long the data set is
(think "backup burned to CD/RW") - there's a *lot* of code that does stuff
like

	while (actual=read(fd,buffer,65536) > 0) {
		...
	}

with the realistic expectation that the last read might return less than 64k,
in which case 'actual' will tell us how much was read.  Instead, we just get
an error on the read.

Note that 'dd' does this - that's why you get messages like '12343+1 blocks read'.
We *really* want to get to a point where 'dd' will work *without* having to
tell it a 'bs=' and 'count=' to get the size right....

--==_Exmh_1108772589_19784P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCFobtcC3lWbTT17ARAiW1AKDegIyylALvHPOK+HO3KMswZHSdnwCfSPpu
U1gHNAfQaawyCFEj7uAGSKQ=
=cFNb
-----END PGP SIGNATURE-----

--==_Exmh_1108772589_19784P--
