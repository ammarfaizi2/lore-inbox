Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269181AbUIYBrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269181AbUIYBrm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 21:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269184AbUIYBrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 21:47:42 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:24731 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S269181AbUIYBrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 21:47:32 -0400
Message-Id: <200409250147.i8P1kxtm016914@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: Andrea Arcangeli <andrea@novell.com>
Cc: David Lang <david.lang@digitalinsight.com>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1) 
In-Reply-To: Your message of "Sat, 25 Sep 2004 03:30:13 +0200."
             <20040925013013.GD3309@dualathlon.random> 
From: Valdis.Kletnieks@vt.edu
References: <41547C16.4070301@pobox.com> <20040924132247.W1973@build.pdx.osdl.net> <1096060045.10800.4.camel@localhost.localdomain> <20040924225900.GY3309@dualathlon.random> <1096069581.3591.23.camel@desktop.cunninghams> <20040925010759.GA3309@dualathlon.random> <Pine.LNX.4.60.0409241819580.1341@dlang.diginsite.com>
            <20040925013013.GD3309@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-444664008P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 24 Sep 2004 21:46:59 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-444664008P
Content-Type: text/plain; charset=us-ascii

On Sat, 25 Sep 2004 03:30:13 +0200, Andrea Arcangeli said:
> On Fri, Sep 24, 2004 at 06:21:27PM -0700, David Lang wrote:
> > if you don't do a -c mkswap runs fast enough that it shouldn't be a 
> > problem to do it every boot.
> 
> yep, speed isn't my worry, my worry is a misconfigured /etc/fstab wiping
> out a filesystem...

If the mkswap doesn't nuke the filesystem, the first time we actually
send a page to swap will do the job.  Plus, there's more chance of paging
on a filesystem and managing to *not* notice, if we merely corrupt data
by dropping an essentially random 4K page on top of 4K of file data and
manage to not hit any metadata.

Maybe have mkswap check the partition table and not do it if the partition
isn't id=82 (Linux swap) unless -f is specified?  Not sure what to do if
the space is a loop or LVM device though.....

--==_Exmh_-444664008P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBVM4TcC3lWbTT17ARAkQ1AKCErNWd8mA5rlhw92K+kUFRtm/iDACgooX3
rJh8y6A02pb7J9zVUeU85BU=
=maed
-----END PGP SIGNATURE-----

--==_Exmh_-444664008P--
