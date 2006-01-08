Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752592AbWAHMHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbWAHMHR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 07:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWAHMHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 07:07:16 -0500
Received: from mail.gmx.net ([213.165.64.21]:8579 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1752592AbWAHMHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 07:07:15 -0500
X-Authenticated: #656597
Date: Sun, 8 Jan 2006 13:05:33 +0100
From: Patrick Leslie Polzer <leslie.polzer@gmx.net>
To: Mikado <mikado4vn@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-c-programming@vger.kernel.org
Subject: Re: Resend: Netlink socket problem
Message-Id: <20060108130533.4cf244af.leslie.polzer@gmx.net>
In-Reply-To: <20060108092505.62484.qmail@web53702.mail.yahoo.com>
References: <20060108092505.62484.qmail@web53702.mail.yahoo.com>
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__8_Jan_2006_13_05_33_+0100_tiMiR_NrPL2qCZp."
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__8_Jan_2006_13_05_33_+0100_tiMiR_NrPL2qCZp.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi Mikado,

On Sun, 8 Jan 2006 01:25:05 -0800 (PST)
Mikado <Mikado <mikado4vn@yahoo.com>> wrote:

 | Is there anything wrong in my codes? I think the problem is the
 | netlink_unicast(), because when I didn't call it, everything work well.
Check whether nl_sk equals NULL.
I don't know whether there's an assert() macro available for you, so try th=
is:

/* [...] */
    if (nl_sk =3D=3D NULL)
    {
        printk(KERN_ALERT "nltest: nl_sk is NULL!");
        goto return_free;
    }

    netlink_unicast(nl_sk, nl_skb, pid, 0);
return_free:
    kfree_skb(nl_skb);
}

A gdb backtrace of the user space part won't give you much, since you
found out the problem lies in kernel space.

What does netlink_unicast() do?

Leslie

--=20
gpg --keyserver pgp.mit.edu --recv-keys 0x52D70289

--Signature=_Sun__8_Jan_2006_13_05_33_+0100_tiMiR_NrPL2qCZp.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDwQAQn/ep3VLXAokRAlaFAKDAkvHMtO3BeJG///dsMYWq5AzcGACgq5Xz
6f8LevCfKagdybzIaaWfkj8=
=M3ZU
-----END PGP SIGNATURE-----

--Signature=_Sun__8_Jan_2006_13_05_33_+0100_tiMiR_NrPL2qCZp.--
