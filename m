Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129508AbQKAKic>; Wed, 1 Nov 2000 05:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129057AbQKAKiW>; Wed, 1 Nov 2000 05:38:22 -0500
Received: from ns1.poda.cz ([62.168.18.10]:5904 "EHLO ns1.poda.cz")
	by vger.kernel.org with ESMTP id <S129646AbQKAKiH>;
	Wed, 1 Nov 2000 05:38:07 -0500
Date: Wed, 1 Nov 2000 11:37:54 +0100 (CET)
From: David Trcka <trcka@poda.cz>
To: paulus@linuxcare.com
cc: linux-kernel@vger.kernel.org, trcka@poda.cz, sigut@poda.cz
Subject: PROBLEM: memory leak in Linux 2.4 PPP code
Message-ID: <Pine.LNX.4.20.0011011059140.10238-100000@ns1.poda.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

there is maybe something wrong in newest PPP daemon or in kernel PPP code
for kernels 2.4.x. The situation is:

- - two machines, connected by nullmodem cable
- - /etc/ppp/options:
/dev/ttyS0
115200
asyncmap 0
noauth
crtscts
local
lock
persist
maxfail 0
lcp-echo-interval 10
lcp-echo-failure 6
10.0.0.1:10.0.0.2 (on first machine - server)
defaultroute (on second machine - client)
- - pppd version 2.4.0 (from ppp-2.4.0.tar.gz), kernel 2.4.0-test9 or 2.2.17
with 2.2-newppp.patch or 2.2.18pre17 with 2.2-newppp.patch
- - all of this is running on my own one-floppy distribution based on LRP
3.1.x Eiger
- - ppp 2.4.0 is used because of new multilink option, to be used in future
- - kernel PPP is compiled as modules, ppp_deflate and bsd_comp loaded, pppd
compiled on Debian Slink (distribution used to produce binaries for LRP)

The problem is:
Once the connection is established, everything goes OK, but in case one
machine is down (either client or server), pppd on another machine
periodically tries to establish connection (persist & maxfail 0), and
after some period of time (depends on number of pppd daemons running and
trying to establish connection, and on size of RAM available) that machine
crash with OOM errors (the way of crash vary - sometimes only pppd dies,
another daemons die, or just freezes, etc.)

The same situation with pppd 2.3.11 and kernel 2.2.17 & 2.2.18pre18 -
everything goes OK.

Any ideas? Thanks,

David

__________________________________________
    David Trcka, network administrator
  PODA s.r.o., Internet Service Provider
Ostrava, 28. rijna 150, The Czech Republic
        Voice/Fax: +420 69 6612600
        PGP KeyID: DAE55DA4

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE5//KE5z9w2trlXaQRAr/mAJ9rVpOGDPeuMovJ5us9blZOia3akgCdHx1D
uxOY30SokKXjzOHGM/LQhcI=
=kEIO
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
