Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279548AbRKFOiZ>; Tue, 6 Nov 2001 09:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279557AbRKFOiP>; Tue, 6 Nov 2001 09:38:15 -0500
Received: from t2.redhat.com ([199.183.24.243]:17909 "EHLO
	dhcp-177.hsv.redhat.com") by vger.kernel.org with ESMTP
	id <S279505AbRKFOhz>; Tue, 6 Nov 2001 09:37:55 -0500
Date: Tue, 6 Nov 2001 08:37:49 -0600
From: Tommy Reynolds <reynolds@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PCI interrupts
Message-Id: <20011106083749.23fbd03e.reynolds@redhat.com>
In-Reply-To: <Pine.OSF.4.31.0111052332160.25619-100000@perry>
In-Reply-To: <Pine.OSF.4.31.0111052332160.25619-100000@perry>
Organization: Red Hat Software, Inc. / Embedded Development
X-Mailer: Sylpheed version 0.6.4cvs13 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=._uw3o/W.pWi74r"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=._uw3o/W.pWi74r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

It was a dark and stormy night.  Suddenly "Matthew Clark" <matt@eee.nott.ac.uk> wrote:

> In my development system the PCI card I am developing  the
> driver for reports (from the PCI config region) that it is using
> interrupt 5.  I can't register this interrupt as it is already
> in use by the USB controller.

PCI interrupts can be shared, but every handler must be registered with the
SA_SHIRQ flag on the request_irq() call.  Both the request_irq() and free_irq()
routines need a "dev_id" cookie to uniquely identify your instance of the
interrurpt handler.

You can see shared interrupts in "/proc/interrupts" because there will be a
comma-separated list of handler names for each IRQ level.

---------------------------------------------+-----------------------------
Tommy Reynolds                               | mailto: <reynolds@redhat.com>
Red Hat, Inc., Embedded Development Services | Phone:  +1.256.704.9286
307 Wynn Drive NW, Huntsville, AL 35805 USA  | FAX:    +1.256.837.3839
Senior Software Developer                    | Mobile: +1.919.641.2923

--=._uw3o/W.pWi74r
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAjvn9cIACgkQWEn3bOOMcuoYFwCfQlwTBPW6BG9XTSISdA+pqMnD
FUgAnj4TGhaeRzaNQ7PMXJsSNZrjHHMK
=V9lM
-----END PGP SIGNATURE-----

--=._uw3o/W.pWi74r--

