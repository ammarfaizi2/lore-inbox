Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbTHSTlo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbTHSTk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:40:59 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:31616 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261388AbTHSTjA (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:39:00 -0400
Message-Id: <200308191938.h7JJcpBC004873@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Daniel Gryniewicz <dang@fprintf.net>
Cc: Andi Kleen <ak@muc.de>, Lars Marowsky-Bree <lmb@suse.de>, davem@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices 
In-Reply-To: Your message of "Tue, 19 Aug 2003 15:17:00 EDT."
             <1061320620.3744.16.camel@athena.fprintf.net> 
From: Valdis.Kletnieks@vt.edu
References: <mdtk.Zy.1@gated-at.bofh.it> <mgUv.3Wb.39@gated-at.bofh.it> <mgUv.3Wb.37@gated-at.bofh.it> <miMw.5yo.31@gated-at.bofh.it> <m365ktxz3k.fsf@averell.firstfloor.org>
            <1061320620.3744.16.camel@athena.fprintf.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1094003853P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 19 Aug 2003 15:38:51 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1094003853P
Content-Type: text/plain; charset=us-ascii

On Tue, 19 Aug 2003 15:17:00 EDT, Daniel Gryniewicz said:

> So, changing your default route is a "hack"?  That's all that's
> necessary.  You can even do it with "route del/route add".

(trimming down a bit)

% ip link show
3: eth3: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:06:5b:ea:8e:4e brd ff:ff:ff:ff:ff:ff
6: eth1: <BROADCAST,MULTICAST,NOTRAILERS,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:02:2d:5c:11:48 brd ff:ff:ff:ff:ff:ff
% ip route sho
198.82.168.0/24 dev eth1  proto kernel  scope link  src 198.82.168.169 
128.173.12.0/22 dev eth3  proto kernel  scope link  src 128.173.14.107 
127.0.0.0/8 dev lo  scope link 
default via 128.173.12.1 dev eth3 

eth1 is an 11mbit wireless on a fairly loaded net, eth3 is a 100mbit line.

If I try 'ip ro add default dev eth1 metric 1 via 198.82.168.1', things
actually work As Expected - if I'm in the docking station, traffic goes via
eth3 because it's lower cost, if I'm wandering it goes via wireless.

Until I fall out of the 128.173.12.1 ARP cache, it ARPS for my eth3 address,
and my laptop gratuitously answers via eth1 - and since that isn't even the
same router, it doesn't listen.  Meanwhile, my laptop *doesnt* fall over to
using wireless because it still has a lower-cost default route for the 100mbit
side (and even if it did, any existing connections would still be hosed).

I can't believe I need to go beat my kernel over the head with 'arpfilter' or
other crap just to get 2 interfaces to each reliably say "here I am" on their
own damned subnet, not the OTHER subnet where nobody gives a rat's posterior
about the other interface....


--==_Exmh_-1094003853P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/QnzLcC3lWbTT17ARAgRxAKD9i5x0avXDR5PsFHvd2JwxQOnbdgCcD898
A+oyKFOtJXLAvnRhRyugjRs=
=GK71
-----END PGP SIGNATURE-----

--==_Exmh_-1094003853P--
