Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265506AbTAJRE4>; Fri, 10 Jan 2003 12:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbTAJRE4>; Fri, 10 Jan 2003 12:04:56 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:47488 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S265506AbTAJREy>; Fri, 10 Jan 2003 12:04:54 -0500
Message-Id: <200301101713.h0AHDYLK010367@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Jochen Hein <jochen@jochen.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.55, PCI, PCMCIA, XIRCOM] 
In-Reply-To: Your message of "Fri, 10 Jan 2003 17:21:51 +0100."
             <87znq9ynz4.fsf@jupiter.jochen.org> 
From: Valdis.Kletnieks@vt.edu
References: <87znq9ynz4.fsf@jupiter.jochen.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-339300526P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Jan 2003 12:13:34 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-339300526P
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-3397501320"

This is a multipart MIME message.

--==_Exmh_-3397501320
Content-Type: text/plain; charset=us-ascii

On Fri, 10 Jan 2003 17:21:51 +0100, Jochen Hein <jochen@jochen.org>  said:
> 
> 
> With 2.4.20 the xircom_cb driver works perfectly on my Thinkpad 600.
> Loading the driver with 2.5.55 for my IBM ethernet card I get:

> Jan 10 11:35:24 gswi1164 kernel: PCI: Device 01:00.0 not available because of
 resource collisions

The problem is (as I understand it) that drivers/pcmcia/cardbus.c ends up
not allocating the onboard ROM resource for some cards before trying to
enable it.  I've attached a patch that worked for me on 2.5.52, although
said patch caused a lot of discussion here about the *right* way to do it
(even *I* admit it's a hack) - and I've seen a report it causes an OOPS
on 2.5.53.  I've not tried it on post-52, but I had a -54 kernel OOPS
right around that point in bootup (right after IDE and somewhere in PCI
init).  Haven't chased that one at all...

/Valdis

--==_Exmh_-3397501320
Content-Type: application/x-patch ; name="pcmcia.patch"
Content-Description: pcmcia.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pcmcia.patch"

LS0tIGRyaXZlcnMvcGNtY2lhL2NhcmRidXMuYy5kaXN0CTIwMDItMTItMDMgMDE6NDk6Mjku
MDAwMDAwMDAwIC0wNTAwCisrKyBkcml2ZXJzL3BjbWNpYS9jYXJkYnVzLmMJMjAwMi0xMi0w
MyAwMTo1MDoyMy4wMDAwMDAwMDAgLTA1MDAKQEAgLTI4Myw4ICsyODMsNiBAQAogCQlkZXYt
Pmhkcl90eXBlID0gaGRyICYgMHg3ZjsKIAogCQlwY2lfc2V0dXBfZGV2aWNlKGRldik7Ci0J
CWlmIChwY2lfZW5hYmxlX2RldmljZShkZXYpKQotCQkJY29udGludWU7CiAKIAkJc3RyY3B5
KGRldi0+ZGV2LmJ1c19pZCwgZGV2LT5zbG90X25hbWUpOwogCkBAIC0zMDIsNiArMzAwLDgg
QEAKIAkJCXBjaV93cml0ZWIoZGV2LCBQQ0lfSU5URVJSVVBUX0xJTkUsIGlycSk7CiAJCX0K
IAorCQlpZiAocGNpX2VuYWJsZV9kZXZpY2UoZGV2KSkKKwkJCWNvbnRpbnVlOwogCQlkZXZp
Y2VfcmVnaXN0ZXIoJmRldi0+ZGV2KTsKIAkJcGNpX2luc2VydF9kZXZpY2UoZGV2LCBidXMp
OwogCX0K

--==_Exmh_-3397501320--


--==_Exmh_-339300526P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+Hv89cC3lWbTT17ARAqlQAKCvsruCe+1zEd/6fRDUAnsQOrA/sgCeMXy9
GsmrxEcc4c0Lz0I7Dn/ThYM=
=9kaC
-----END PGP SIGNATURE-----

--==_Exmh_-339300526P--
