Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265395AbUJEUku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbUJEUku (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 16:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265910AbUJEUjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 16:39:40 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:60381 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265395AbUJEUiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 16:38:14 -0400
Message-Id: <200410052038.i95Kc8VM004041@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: Andreas Jellinghaus <aj@dungeon.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: block till hotplug is done? 
In-Reply-To: Your message of "Tue, 05 Oct 2004 22:13:15 +0200."
             <4163005B.2090000@t-online.de> 
From: Valdis.Kletnieks@vt.edu
References: <1097005927.4953.4.camel@simulacron>
            <4163005B.2090000@t-online.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_262601700P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 05 Oct 2004 16:38:08 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_262601700P
Content-Type: text/plain; charset=us-ascii

On Tue, 05 Oct 2004 22:13:15 +0200, Harald Dunkel said:
> Andreas Jellinghaus wrote:
> > Hi,
> > 
> > is there any way to block till all hotplug events are handled/
> > the hotplug processes terminated?
> > 
> 
> while [ "`ps | grep /sbin/hotplug | grep -v grep`" ]; do sleep 1; done

Save a process:

while [ "`ps | grep '/sbin/[h]otplug'`" ]; do sleep 1; done

Depending on what exactly you're waiting on, you might also try:

while [ ! -b /dev/hdc1 ]; do sleep 1; done

(Assuming you know what device name you're expecting - this may depend on
the exact list of things that you want to do - there *might* be a race
condition where fdisk has created hd?1 but it's not the *right* one because
the media was previously partitioned and fdisk hasn't told the kernel to
read the new one yet. YMMV and all that...)

--==_Exmh_262601700P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBYwYucC3lWbTT17ARAgM+AKDW3oEHjbW6Uh3ltMVSqRDSH15TFgCfVhLs
kIHMifXDiuOugOFoXuBGZ50=
=zPsg
-----END PGP SIGNATURE-----

--==_Exmh_262601700P--
