Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316594AbSG2M3c>; Mon, 29 Jul 2002 08:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316595AbSG2M3c>; Mon, 29 Jul 2002 08:29:32 -0400
Received: from fw.2d3d.co.za ([66.8.28.230]:6277 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S316594AbSG2M3a>;
	Mon, 29 Jul 2002 08:29:30 -0400
Date: Mon, 29 Jul 2002 14:36:42 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: question about incrementing stats counters in network drivers
Message-ID: <20020729143642.A7130@crystal.2d3d.co.za>
Mail-Followup-To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.17-pre4 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 2:29pm  up 10:27,  6 users,  load average: 0.05, 0.07, 0.06
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

If an error occur that falls into the "detailed errors" category, e.g. a
fifo overrun, are we supposed to increment both the total error count and
the detailed error count or just the detailed error count?

=46rom isa-skeleton.c it seems that I'm supposed to increment both, but the=
n I
spotted things like this in there as well:

------------< snip <------< snip <------< snip <------------
        } else {
            /* Malloc up new buffer. */
            struct sk_buff *skb;

            lp->stats.rx_bytes+=3Dpkt_len;

            skb =3D dev_alloc_skb(pkt_len);
            if (skb =3D=3D NULL) {
                printk(KERN_NOTICE "%s: Memory squeeze, dropping packet.\n",
                       dev->name);
                lp->stats.rx_dropped++;
                break;
            }
            skb->dev =3D dev;

            /* 'skb->data' points to the start of sk_buff data area. */
            memcpy(skb_put(skb,pkt_len), (void*)dev->rmem_start,
                   pkt_len);
            /* or */
            insw(ioaddr, skb->data, (pkt_len + 1) >> 1);

            netif_rx(skb);
            dev->last_rx =3D jiffies;
            lp->stats.rx_packets++;
            lp->stats.rx_bytes +=3D pkt_len;
        }
------------< snip <------< snip <------< snip <------------

Notice that rx_bytes gets incremented twice.

Also it doesn't make sense to increment both since the total count can be
derived from rx_errors+other rx errors or tx_errors+other tx errors, so I'm
not sure what to do.

--=20

Regards
 Abraham

QOTD:
	I love your outfit, does it come in your size?

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Aintree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9RTbazNXhP0RCUqMRAugNAJ45JKTq0432LhbjVhPggnInVNFDMwCfZwVR
HBpTMln5PzBlYTwbZETN4e0=
=MrvC
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
