Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266826AbUAXAs4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 19:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266823AbUAXAsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 19:48:55 -0500
Received: from h80ad2660.async.vt.edu ([128.173.38.96]:4736 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266830AbUAXAsX (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 19:48:23 -0500
Message-Id: <200401232216.i0NMGT4w002641@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, john stultz <johnstul@us.ibm.com>
Subject: More timer/bogomip damage (was Re: keyboard and USB problems (Re: 2.6.2-rc1-mm2) 
In-Reply-To: Your message of "Fri, 23 Jan 2004 10:46:53 PST."
             <20040123104653.53fe7667.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20040123013740.58a6c1f9.akpm@osdl.org> <20040123160152.GA18073@ss1000.ms.mff.cuni.cz> <20040123161946.GA6934@ucw.cz>
            <20040123104653.53fe7667.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_689244214P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Jan 2004 17:16:29 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_689244214P
Content-Type: text/plain; charset=us-ascii

On Fri, 23 Jan 2004 10:46:53 PST, Andrew Morton said:

> >  > BogoMIPS is figured out to be 8.19 (this was already reported by another
 user),

> Disabling CONFIG_X86_PM_TIMER should fix it up too.

My Dell C840 got bit by the 8.19 bogomips too, and I found some MORE damage
caused by this.

2.6.2-rc1-mm1 with X86_PM_TIMER finds my Ethernet cards just fine.

2.6.2-rc1-mm2, the 3c59x driver fails to find the MAC address for the cards:
(the Xircom pcmcia (eth2 below) and Orinoco wireless (eth3) drivers *do* find
their cards):

% ip link show
1: eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
2: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop qlen 1000
    link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
3: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue 
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
4: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop 
    link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
5: sit0: <NOARP> mtu 1480 qdisc noop 
    link/sit 0.0.0.0 brd 0.0.0.0
6: eth2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop qlen 1000
    link/ether 00:10:a4:9c:a8:86 brd ff:ff:ff:ff:ff:ff
7: eth3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:02:2d:5c:11:48 brd ff:ff:ff:ff:ff:ff

(eth0 is the onboard ethernet, eth1 was the one on the docking station). lspci says:

0000:02:00.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)

Building without X86_PM_TIMER the 3c905 is found:

% ip link show
1: eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:06:5b:b9:5e:27 brd ff:ff:ff:ff:ff:ff
2: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue 
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
3: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop 
    link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
4: sit0: <NOARP> mtu 1480 qdisc noop 
    link/sit 0.0.0.0 brd 0.0.0.0
5: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:10:a4:9c:a8:86 brd ff:ff:ff:ff:ff:ff
6: eth5: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast qlen 1000
    link/ether 00:02:2d:5c:11:48 brd ff:ff:ff:ff:ff:ff

(Am roaming and not docked, which is why the dock 3c905 isn't listed)




--==_Exmh_689244214P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAEZ09cC3lWbTT17ARAigKAKDfFl8VR1CBFD60L14vUeSUjLc/WACgnV1f
ZXBXfSLPp8298gzm4MKz2Mc=
=AzvC
-----END PGP SIGNATURE-----

--==_Exmh_689244214P--
