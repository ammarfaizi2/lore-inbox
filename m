Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUENBgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUENBgV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 21:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbUENBgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 21:36:21 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:30921 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S264299AbUENBgD (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 21:36:03 -0400
Message-Id: <200405140135.i4E1Zp7A025139@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Chris Wright <chrisw@osdl.org>
Cc: Andy Lutomirski <luto@myrealbox.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] capabilites, take 2 
In-Reply-To: Your message of "Thu, 13 May 2004 18:20:10 PDT."
             <20040513182010.L21045@build.pdx.osdl.net> 
From: Valdis.Kletnieks@vt.edu
References: <200405131308.40477.luto@myrealbox.com>
            <20040513182010.L21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_2141069913P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 13 May 2004 21:35:51 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_2141069913P
Content-Type: text/plain; charset=us-ascii

On Thu, 13 May 2004 18:20:10 PDT, Chris Wright said:

> I think it still needs more work.  Default behavoiur is changed, like
> Inheritble is full rather than clear, setpcap is enabled, etc.  Also,
> why do you change from Posix the way exec() updates capabilities?  Sure,
> there is no filesystem bits present, so this changes the calculation,
> but I'm not convinced it's as secure this way.  At least with newcaps=0.

The last time the "capabilities" thread reared its head a while ago, Andy made
a posting that pretty conclusively showed that the Posix way was totally b0rken
if you ever intended to support filesystem bits.  So if you wanted to ever have
a snowball's chance of supporting something like:

chcap cap_net_raw+ep /bin/ping

so you could get rid of the set-UID bit on 'ping', you had to toss the Posix
propogation rules out the window.  So we need to do either:

1) Toss the Posix out the window
2) Toss all the filesystems capabilities support out the window.

(I'm assuming that a suggestion that we make the choice a Kconfig option will
be met with the sound of many kernel hackers either retching in disgust or
screaming in horror ;)


--==_Exmh_2141069913P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFApCJ3cC3lWbTT17ARAl9/AKDl+cIkJoNEuiFRYdNKXxJB+fcShwCdEGdw
0ir5nvNk5IxTk1xutq9ib94=
=AkCl
-----END PGP SIGNATURE-----

--==_Exmh_2141069913P--
