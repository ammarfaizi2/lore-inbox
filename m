Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268473AbTBWOZo>; Sun, 23 Feb 2003 09:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268474AbTBWOZo>; Sun, 23 Feb 2003 09:25:44 -0500
Received: from oasis.frogfoot.net ([66.8.28.51]:56554 "HELO oasis.frogfoot.net")
	by vger.kernel.org with SMTP id <S268473AbTBWOZk>;
	Sun, 23 Feb 2003 09:25:40 -0500
Date: Sun, 23 Feb 2003 16:34:41 +0200
From: Abraham van der Merwe <abz@frogfoot.net>
To: Linux Kernel Mailinlist <linux-kernel@vger.kernel.org>
Subject: BUG REPORT: bug in eepro100.c driver
Message-ID: <20030223143441.GA27649@oasis.frogfoot.net>
Mail-Followup-To: Linux Kernel Mailinlist <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Frogfoot Networks
X-Operating-System: Debian GNU/Linux oasis 2.4.20-rc1 i686
X-GPG-Public-Key: http://oasis.frogfoot.net/pgpkeys/keys/frogfoot.gpg
X-Uptime: 16:28:14 up 53 days,  3:55, 12 users,  load average: 0.03, 0.24, 0.22
X-Edited-With-Muttmode: muttmail.sl - 2001-09-27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I keep getting kernel panics with 2.4.21-pre4 (and 2.4.20). Here is the
kernel panic (I couldn't cut & paste in the datacenter, so I just wrote down
the stack trace):

------------< snip <------< snip <------< snip <------------
root@trillian:~/uni-qos# cat panic.txt
c0192eb1
c0176c8c
c017718c
c0176afa
c010810f
c01082b3
c0105240
c0105240
c0105240
c0105240
c0105263
c01052d2
c0105000
c0105027

0f 0b ef 04 e0 87 1e c0 f7 c5 00 04 00 00 74 36 b8 a5 c2 0f

EIP: 0010:c012642e
ESP: c0221eb4

KERNEL BUG slab.c:1263
root@trillian:~/uni-qos#
------------< snip <------< snip <------< snip <------------

A quick objdump through the kernel's vmlinux image reveals, that the stack
trace above looks as follows:

------------< snip <------< snip <------< snip <------------
c0192eb1    alloc_skb
c0176c8c    speedo_refill_rx_buf
c017718c    speedo_rx
c0176afa    speedo_interrupt
c010810f    handle_IRQ_event
c01082b3    do_IRQ
c0105240    default_idle
c0105240    default_idle
c0105240    default_idle
c0105240
c0105263    default_idle
c01052d2    cpu_idle
c0105000    rest_init
c0105027    rest_init
------------< snip <------< snip <------< snip <------------

It crashes when it hits BUG(); in slab.c:

------------< snip <------< snip <------< snip <------------
#if DEBUG
    if (cachep->flags & SLAB_POISON)
        if (kmem_check_poison_obj(cachep, objp))
            BUG();
------------< snip <------< snip <------< snip <------------

Could somebody please tell me what is wrong here and how to fix this?

--=20

Regards
 Abraham

It doesn't matter whether you win or lose -- until you lose.

___________________________________________________
 Abraham vd Merwe [ZR1BBQ] - Frogfoot Networks
 P.O. Box 3472, Matieland, Stellenbosch, 7602
 Cell: +27 82 565 4451 Http: http://www.frogfoot.net/
 Email: abz@frogfoot.net


--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+WNwB0jJV70h31dERAic1AJ911sOZ7jAdmgf6GmFV95oEDS4NEgCfcEsw
uzGFRuQFDLhuQ3CY/xc5am8=
=dKmN
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
