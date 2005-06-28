Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVF1OGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVF1OGz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 10:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVF1OEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 10:04:25 -0400
Received: from h80ad2540.async.vt.edu ([128.173.37.64]:35278 "EHLO
	h80ad2540.async.vt.edu") by vger.kernel.org with ESMTP
	id S261685AbVF1OAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 10:00:22 -0400
Message-Id: <200506281400.j5SE07pB005563@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: cigarette Chan <benbenshi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: route trouble with kernel 
In-Reply-To: Your message of "Tue, 28 Jun 2005 20:57:04 +0800."
             <dc849d8505062805573a73ec99@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <dc849d8505062805573a73ec99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119967205_4284P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Jun 2005 10:00:06 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1119967205_4284P
Content-Type: text/plain; charset=us-ascii

On Tue, 28 Jun 2005 20:57:04 +0800, cigarette Chan said:
> i add a route to the kernel
> eg: # route add -net XXX.XXX.XXX.XXX/24 gw XXX.XXX.XXX.XXX dev eth1
> 
> but after i restart eth1
> 
> #ifdown eth1
> #ifup eth1
> 
> the route disappear,this make me a lot of troubles.i have several
> interfaces,and i have to
> re-add all of these routes...
> 
> Is there any way or patches to make route work like iptables,after i
> restart the interface,
> rules  are still there.

Your system should have a way of doing this in a callout during the ifup
and ifdown scripts.  Under Fedora, ifup calls ifup-post, which calls
/sbin/ifup-local - you could add your routes there.

More importantly, routes are different from iptables.  At worst, an iptable
rule has a dangling '-i ethX' match that will fail if the interface is down,
but that's a harmless because the packet isn't from that interface.

On the other hand, what is the kernel supposed to do with a route that
points to a down'ed ethX after you've done the ifdown, but before you've
done the ifup?  It may as well clear routes to the down'ed interface....

--==_Exmh_1119967205_4284P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCwVflcC3lWbTT17ARAoyzAKCjGAp51hnoZJaUVHvpwhLIcmNyxQCcC1iF
tF4zt9Sgyg05VqQHd1FqAz0=
=HLkZ
-----END PGP SIGNATURE-----

--==_Exmh_1119967205_4284P--
