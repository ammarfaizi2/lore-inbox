Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbUCAJRt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 04:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbUCAJRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 04:17:49 -0500
Received: from 81-5-136-19.dsl.eclipse.net.uk ([81.5.136.19]:20195 "EHLO
	vlad.carfax.org.uk") by vger.kernel.org with ESMTP id S261259AbUCAJRK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 04:17:10 -0500
Date: Mon, 1 Mar 2004 09:17:09 +0000
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Netdev Watchdog timeout and badness in local_bh_enable
Message-ID: <20040301091709.GA637@selene>
Mail-Followup-To: Hugo Mills <hugo-lkml@carfax.org.uk>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
X-GPG-Fingerprint: B997 A9F1 782D D1FD 9F87  5542 B2C2 7BC2 1C33 5860
X-GPG-Key: 1C335860
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: hugo darksatanic
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

   I have a machine which, amongst other things, acts as an NFS server
for a small number of (1 or 2) clients.  Under "heavy" NFS load
(copying a large file, opening a large maildir in mutt), it generates
lots of these:

Mar  1 00:20:49 src@vlad kernel: NETDEV WATCHDOG: eth0: transmit timed out
Mar  1 00:20:49 src@vlad kernel: eth0: Transmit timed out, status 0x000000, resetting...

   and quite a few of these:

Mar  1 00:20:49 src@vlad kernel: Badness in local_bh_enable at kernel/softirq.c:121
Mar  1 00:20:49 src@vlad kernel: Call Trace:
Mar  1 00:20:49 src@vlad kernel: [<c011eacf>] local_bh_enable+0x6f/0x80
Mar  1 00:20:49 src@vlad kernel: [<d504be41>] svc_write_space+0x21/0x80 [sunrpc]
Mar  1 00:20:49 src@vlad kernel: [<c024d49b>] sock_wfree+0x3b/0x40
Mar  1 00:20:49 src@vlad kernel: [<c024d460>] sock_wfree+0x0/0x40
Mar  1 00:20:49 src@vlad kernel: [<c024e454>] __kfree_skb+0x54/0xc0
Mar  1 00:20:49 src@vlad kernel: [<d4b053b7>] drain_tx+0x37/0x60 [natsemi]
Mar  1 00:20:49 src@vlad kernel: [<d4b054b7>] reinit_ring+0x17/0xa0 [natsemi]
Mar  1 00:20:49 src@vlad kernel: [<d4b05030>] tx_timeout+0x50/0x100 [natsemi]
Mar  1 00:20:49 src@vlad kernel: [<c025bc60>] dev_watchdog+0x0/0xc0
Mar  1 00:20:49 src@vlad kernel: [<c025bd03>] dev_watchdog+0xa3/0xc0
Mar  1 00:20:49 src@vlad kernel: [<c0122805>] run_timer_softirq+0xc5/0x1a0
Mar  1 00:20:49 src@vlad kernel: [<c011ea53>] do_softirq+0x93/0xa0
Mar  1 00:20:49 src@vlad kernel: [<c010ab25>] do_IRQ+0x105/0x140
Mar  1 00:20:49 src@vlad kernel: [<c01091a8>] common_interrupt+0x18/0x20
Mar  1 00:20:49 src@vlad kernel: [<c01ba91e>] csum_partial_copy_generic+0x6a/0x10c
Mar  1 00:20:49 src@vlad kernel: [<c024fe38>] csum_partial_copy_fromiovecend+0x218/0x2c0
Mar  1 00:20:49 src@vlad kernel: [<c02661f0>] ip_generic_getfrag+0x30/0xa0
Mar  1 00:20:49 src@vlad kernel: [<c026678b>] ip_append_data+0x52b/0x6a0
Mar  1 00:20:49 src@vlad kernel: [<c02655db>] ip_output+0x5b/0x80
Mar  1 00:20:49 src@vlad kernel: [<c02822a5>] udp_sendmsg+0x2e5/0x680
Mar  1 00:20:49 src@vlad kernel: [<c02661c0>] ip_generic_getfrag+0x0/0xa0
Mar  1 00:20:49 src@vlad kernel: [<c024d79b>] sock_alloc_send_pskb+0xbb/0x1e0
Mar  1 00:20:49 src@vlad kernel: [<c024d8d6>] sock_alloc_send_skb+0x16/0x20
Mar  1 00:20:49 src@vlad kernel: [<c026685b>] ip_append_data+0x5fb/0x6a0
Mar  1 00:20:49 src@vlad kernel: [<c0224c48>] ahc_linux_run_device_queue+0x448/0x8c0
Mar  1 00:20:49 src@vlad kernel: [<c02822a5>] udp_sendmsg+0x2e5/0x680
Mar  1 00:20:49 src@vlad kernel: [<c02661c0>] ip_generic_getfrag+0x0/0xa0
Mar  1 00:20:49 src@vlad kernel: [<c02822c4>] udp_sendmsg+0x304/0x680
Mar  1 00:20:49 src@vlad kernel: [<c0289957>] inet_sendmsg+0x37/0x40
Mar  1 00:20:49 src@vlad kernel: [<c024ac21>] sock_sendmsg+0x81/0xa0
Mar  1 00:20:49 src@vlad kernel: [<c0289957>] inet_sendmsg+0x37/0x40
Mar  1 00:20:49 src@vlad kernel: [<c024dc7d>] sock_no_sendpage+0x7d/0xa0
Mar  1 00:20:49 src@vlad kernel: [<c0282715>] udp_sendpage+0xd5/0x100
Mar  1 00:20:49 src@vlad kernel: [<d5092cf6>] nfsd_read+0x296/0x360 [nfsd]
Mar  1 00:20:49 src@vlad kernel: [<c02899cd>] inet_sendpage+0x6d/0xa0
Mar  1 00:20:49 src@vlad kernel: [<d504bb64>] svc_sendto+0x104/0x200 [sunrpc]
Mar  1 00:20:49 src@vlad kernel: [<c024e3f9>] kfree_skbmem+0x19/0x20
Mar  1 00:20:49 src@vlad kernel: [<d504c115>] svc_udp_sendto+0x15/0x40 [sunrpc]
Mar  1 00:20:49 src@vlad kernel: [<d504d2ae>] svc_send+0xce/0x120 [sunrpc]
Mar  1 00:20:49 src@vlad kernel: [<d504b0c4>] svc_process+0x1e4/0x640 [sunrpc]
Mar  1 00:20:49 src@vlad kernel: [<d508f432>] nfsd+0x1b2/0x360 [nfsd]
Mar  1 00:20:49 src@vlad kernel: [<d508f280>] nfsd+0x0/0x360 [nfsd]
Mar  1 00:20:49 src@vlad kernel: [<c0107009>] kernel_thread_helper+0x5/0x1c

   The network card is a Netgear FA312 10/100 card, based on the
natsemi chipset. It replaces an ISA 3c509B 10Mbit card, which never
showed this behaviour. Kernel is 2.6.2-rc2. I've checked all of the
other pieces of the network, and they appear to be fine.

   Any suggestions as to what's wrong?

   Thanks,
   Hugo.

-- 
=== Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
  PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
       --- There's many a slip 'twixt wicket-keeper and gully. ---       

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAQv+VssJ7whwzWGARAnewAKCbKlm/5cuHmyQRTwkm2LzZcGVL+QCcDxom
SNYWBn+xRZErLh9tO4Ry2Kc=
=BuzO
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
