Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbUCKUmq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 15:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUCKUjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 15:39:23 -0500
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:8576 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S261732AbUCKUh0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 15:37:26 -0500
Date: Thu, 11 Mar 2004 20:37:24 +0000
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Netdev watchdog time-out (with natsemi driver?)
Message-ID: <20040311203724.GA1470@selene>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: hugo darksatanic
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

   Hi,

   I am experiencing lock-ups and (in some cases) total failures in
networking. It occurs most often when copying "large" amounts (read:
more than a few hundred KiB) of data from one machine to another via
NFS, but it can also be triggered by non-NFS network traffic. Error
logs at the end of the email.

   Network card is a natsemi (Netgear FA312) on each end of the link.
It happens with a cross-over cable as well as with my hub, and I've
tried with several different cables between, so I don't think it's
cables or network infrastructure. It also happens only on one of the
two machines involved -- an old AMD K6-2/500 box. The other machine
(Athlon64) is fine.

   Moving back to a 3c509B ISA card in the K6 machine solves the
lock-ups problem, but obviously is a severly sub-optimal solution.
Fixing the speed of the natsemi card to 10 Mbit does not solve the
problem, although it does reduce it.

   I've had this problem both with 2.6.2-rc2 and 2.6.4 kernels.

   What are the likely causes of the problem, and what can I do about
it to prevent it?

   Thanks,
   Hugo.

   The error logs:

[lots of these at 4-10 second intervals]

Mar 11 19:45:05 src@vlad kernel: NETDEV WATCHDOG: eth0: transmit timed out
Mar 11 19:45:05 src@vlad kernel: eth0: Transmit timed out, status 0x000000, resetting...
Mar 11 19:45:09 src@vlad kernel: NETDEV WATCHDOG: eth0: transmit timed out
Mar 11 19:45:09 src@vlad kernel: eth0: Transmit timed out, status 0x000000, resetting...

[then 8 of these at once]

Mar 11 19:50:10 src@vlad kernel: Badness in local_bh_enable at kernel/softirq.c:122
Mar 11 19:50:10 src@vlad kernel: Call Trace:
Mar 11 19:50:10 src@vlad kernel: [<c011eecf>] local_bh_enable+0x6f/0x80
Mar 11 19:50:10 src@vlad kernel: [<d4df12c1>] svc_write_space+0x21/0x80 [sunrpc]
Mar 11 19:50:10 src@vlad kernel: [<c025c3fb>] sock_wfree+0x3b/0x40
Mar 11 19:50:10 src@vlad kernel: [<c025c3c0>] sock_wfree+0x0/0x40
Mar 11 19:50:10 src@vlad kernel: [<c025d3ba>] __kfree_skb+0x5a/0xe0
Mar 11 19:50:10 src@vlad kernel: [<d49563b7>] drain_tx+0x37/0x60 [natsemi]
Mar 11 19:50:10 src@vlad kernel: [<d49564b7>] reinit_ring+0x17/0xa0 [natsemi]
Mar 11 19:50:10 src@vlad kernel: [<d4956030>] tx_timeout+0x50/0x100 [natsemi]
Mar 11 19:50:10 src@vlad kernel: [<c026af00>] dev_watchdog+0x0/0xc0
Mar 11 19:50:10 src@vlad kernel: [<c026afa3>] dev_watchdog+0xa3/0xc0
Mar 11 19:50:10 src@vlad kernel: [<c0122c25>] run_timer_softirq+0xc5/0x1a0
Mar 11 19:50:10 src@vlad kernel: [<c011ee53>] do_softirq+0x93/0xa0
Mar 11 19:50:10 src@vlad kernel: [<c010ab25>] do_IRQ+0x105/0x140
Mar 11 19:50:10 src@vlad kernel: [<c01091a8>] common_interrupt+0x18/0x20
Mar 11 19:50:10 src@vlad kernel: [<c01bbc28>] csum_partial_copy_generic+0x54/0x10c
Mar 11 19:50:10 src@vlad kernel: [<c025edb8>] csum_partial_copy_fromiovecend+0x218/0x2c0
Mar 11 19:50:10 src@vlad kernel: [<c0275490>] ip_generic_getfrag+0x30/0xa0
Mar 11 19:50:10 src@vlad kernel: [<c027570f>] ip_append_data+0x20f/0x6a0
Mar 11 19:50:10 src@vlad kernel: [<c027487b>] ip_output+0x5b/0x80
Mar 11 19:50:10 src@vlad kernel: [<c0291a25>] udp_sendmsg+0x2e5/0x680
Mar 11 19:50:10 src@vlad kernel: [<c0275460>] ip_generic_getfrag+0x0/0xa0
Mar 11 19:50:10 src@vlad kernel: [<c025c6fb>] sock_alloc_send_pskb+0xbb/0x1e0
Mar 11 19:50:10 src@vlad kernel: [<c025c836>] sock_alloc_send_skb+0x16/0x20
Mar 11 19:50:10 src@vlad kernel: [<c0275afb>] ip_append_data+0x5fb/0x6a0
Mar 11 19:50:10 src@vlad kernel: [<c0291a25>] udp_sendmsg+0x2e5/0x680
Mar 11 19:50:10 src@vlad kernel: [<c0275460>] ip_generic_getfrag+0x0/0xa0
Mar 11 19:50:10 src@vlad kernel: [<c0291a44>] udp_sendmsg+0x304/0x680
Mar 11 19:50:10 src@vlad kernel: [<c02994f7>] inet_sendmsg+0x37/0x40
Mar 11 19:50:10 src@vlad kernel: [<c0259b81>] sock_sendmsg+0x81/0xa0
Mar 11 19:50:10 src@vlad kernel: [<c02994f7>] inet_sendmsg+0x37/0x40
Mar 11 19:50:10 src@vlad kernel: [<c025cbdd>] sock_no_sendpage+0x7d/0xa0
Mar 11 19:50:10 src@vlad kernel: [<c0291e95>] udp_sendpage+0xd5/0x100
Mar 11 19:50:10 src@vlad kernel: [<c029956d>] inet_sendpage+0x6d/0xa0
Mar 11 19:50:10 src@vlad kernel: [<d4df0fe4>] svc_sendto+0x104/0x200 [sunrpc]
Mar 11 19:50:10 src@vlad kernel: [<c025d359>] kfree_skbmem+0x19/0x20
Mar 11 19:50:10 src@vlad kernel: [<d4df1572>] svc_udp_sendto+0x12/0x40 [sunrpc]
Mar 11 19:50:10 src@vlad kernel: [<d4df26e4>] svc_send+0xc4/0x100 [sunrpc]
Mar 11 19:50:10 src@vlad kernel: [<d4df056c>] svc_process+0x1ac/0x600 [sunrpc]
Mar 11 19:50:10 src@vlad kernel: [<d4e38432>] nfsd+0x1b2/0x360 [nfsd]
Mar 11 19:50:10 src@vlad kernel: [<d4e38280>] nfsd+0x0/0x360 [nfsd]
Mar 11 19:50:10 src@vlad kernel: [<c0107009>] kernel_thread_helper+0x5/0x1c
Mar 11 19:50:10 src@vlad kernel: 

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
        --- emacs:  Eighty Megabytes And Constantly Swapping. ---        

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAUM4EssJ7whwzWGARAhmyAJ4tHuM6De1auA97Od+wsIhzYU6eDgCgnror
tXTJqoFWLQgMeCDOn1V09X0=
=nujC
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
