Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267612AbUHaJjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267612AbUHaJjo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 05:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267628AbUHaJjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 05:39:44 -0400
Received: from hostmaster.org ([212.186.110.32]:6786 "HELO hostmaster.org")
	by vger.kernel.org with SMTP id S267612AbUHaJjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 05:39:39 -0400
Subject: 2.6.9-rc1 oops
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OVn7zeyHS7Ab8Zzw6Xht"
Date: Tue, 31 Aug 2004 11:39:37 +0200
Message-Id: <1093945177.16908.14.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 (1.5.93-2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OVn7zeyHS7Ab8Zzw6Xht
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

2.6.9-rc1 oopses here reproducibly during boot after bringing up the
sit3 tunneling device:

Unable to handle kernel NULL pointer dereference...
ipv6_get_hoplimit+24, ipv6_rout_add+1367, inet6_rtm_newroute+63,
rtnetlink_rcv+587, netlink_data_ready+22, netlink_sendskb+46,
netlink_sendmsg+703, sock_sendmsg+174, __mark_inode_dirty+52,
verify_iovec+75, sys_sendmsg+528, cap_vm_enough_memory+14, do_page_fault
+497, netlink_autobind+184, sys_getsockname+135, sock_map_fd+376,
netlink_create+207, system_call+126

Normally with 2.6.8.1 and before my routing table looks like this:

Kernel IPv6 routing table
Destination                                 Next Hop                       =
         Flags Metric Ref    Use Iface
::1/128                                     ::                             =
         U     0      104       2 lo
2000::/128                                  2000::                         =
         UC    0      12       0 sit1
2001:850:306::/128                          ::                             =
         U     0      9        0 lo
2001:850:306::1/128                         ::                             =
         U     0      6        0 lo
2001:850:306::/64                           ::                             =
         U     256    0        0 sit1
3ffe:80ee:14fa::/128                        ::                             =
         U     0      9        0 lo
3ffe:80ee:14fa::1/128                       ::                             =
         U     0      6        0 lo
3ffe:80ee:14fa::/64                         ::                             =
         U     256    0        0 sit2
3ffe:80ee:14fa::/64                         ::                             =
         U     256    0        0 sit3
2000::/3                                    ::                             =
         U     1      3        0 sit1
2000::/3                                    ::                             =
         U     1      0        0 sit2
2000::/3                                    ::                             =
         U     1      0        0 sit3
fe80::/128                                  ::                             =
         U     0      0        0 lo
fe80::d4ba:6e20/128                         ::                             =
         U     0      0        0 lo
fe80::2e0:81ff:fe29:9983/128                ::                             =
         U     0      0        0 lo
fe80::/64                                   ::                             =
         U     256    0        0 eth0
fe80::/64                                   ::                             =
         U     256    0        0 sit1
fe80::/64                                   ::                             =
         U     256    0        0 sit2
fe80::/64                                   ::                             =
         U     256    0        0 sit3
ff00::/128                                  ff00::                         =
         UC    0      12       0 eth0
ff00::/8                                    ::                             =
         U     256    0        0 eth0
ff00::/8                                    ::                             =
         U     256    0        0 sit1
ff00::/8                                    ::                             =
         U     256    0        0 sit2
ff00::/8                                    ::                             =
         U     256    0        0 sit3

Tom

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
      finger thomasz@hostmaster.org for key

I hate beeing a DNA molecule - there's so much to remember!



--=-OVn7zeyHS7Ab8Zzw6Xht
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQEVAwUAQTRHWWD1OYqW/8uJAQLGSQgAkC9j9rPvxgDTfVJztBCfAALUhJsWvUxK
LOCYtVna+Gm8BIZHsHpg8Rl9BJ1SeXYSPolkWZPDLavzrJY/wZOp+SG0/H8FJyRj
9sZvQAbjT0eVGbACOnT4hJ3br+KcRzcknRjNmDa9twuGOwNxFL8sfdYUA2mm0zkM
LkOf+lmjDFzrCG3Q4Qh0FlTB/0NNDgaRXHa26lnMbCqopQJA34GDwNxUk3Xlw4zI
NMx63etfUzAq8MAP34whtO38JuTyf2dkEVnLEVxk1AV++tBmsAs1ItVglhHUvh16
Co6A7j2nRz1o7oS+UjnUJfg8zr4Rzwl47/ZT73+Ny/6NHhx3aL3pgA==
=kx3I
-----END PGP SIGNATURE-----

--=-OVn7zeyHS7Ab8Zzw6Xht--

