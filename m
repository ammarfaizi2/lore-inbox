Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318282AbSG3OHx>; Tue, 30 Jul 2002 10:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318286AbSG3OHx>; Tue, 30 Jul 2002 10:07:53 -0400
Received: from fw.2d3d.co.za ([66.8.28.230]:44431 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S318282AbSG3OHv>;
	Tue, 30 Jul 2002 10:07:51 -0400
Date: Tue, 30 Jul 2002 16:15:05 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: questions about network device drivers
Message-ID: <20020730161505.A23281@crystal.2d3d.co.za>
Mail-Followup-To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.17-pre4 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 3:45pm  up 1 day, 11:43,  9 users,  load average: 0.04, 0.15, 0.11
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

hard_start_xmit() method
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

when should this function return 0 and when should it return 1 and in which
cases should it do netif_stop_queue() and/or free the dev_kfree_skb() ?

I'd really appreciate it if someone could clear this up. Almost all the
source/docs I've looked at seems to contradict each other ):

also, since hard_start_xmit() is protected by xmit_lock, why are some
drivers (e.g. cs89x0.c) guarding against concurrent calls to
hard_start_xmit (see the spinlock in cs89x0.c:net_send_packet)?

is there any way to control alignment of sk_buff's that gets passed to this
function? e.g. if I want the buffer to be aligned on 16-bit boundary and/or
be padded to a 16-bit boundary - is there any way to tell the kernel to pass
the driver buffers with those characterestics?

get_stats() method
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

when errors occur that have details error fields in the net_device_stats
structure, am I supposed to increment both the total error count and the
detailed error count or both? also, what about dropped packets?

e.g.

1. i drop a frame because there's no memory left to allocate a sk_buff when
I receive a packet. Do I increment rx_dropped, rx_errors, or both?

2. there's a crc error. do I increment rx_crc_errors and rx_errors or just
rx_crc_errors?

also, I noticed that many drivers keep a private copy of the
net_device_stats structure and just return a pointer to that structure in
the get_stats method. what prevents the other driver methods from racing
with the functions that gets passed this structure?

tx_timeout() method
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

there is no way to return an error in the tx_timeout method. what should I
do when an error occurs in that function (e.g. I'm unable to reset the
controller)? panic? that seems a bit excessive...

general
=3D=3D=3D=3D=3D=3D=3D

What is the difference between netif_wake_queue() and netif_start_queue()?

--=20

Regards
 Abraham

Humor in the Court:
Q.  And who is this person you are speaking of?
A.  My ex-widow said it.

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Aintree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9Rp9pzNXhP0RCUqMRAlbBAJ44MTSCPaoFadZHcoIzbSw+P1WqfACfaOzG
1R76TU8TO2ebE8W71+osiAI=
=8Eun
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
