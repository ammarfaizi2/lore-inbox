Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269226AbTGOSPC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 14:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269242AbTGOSPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 14:15:01 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:9344 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S269226AbTGOSOz (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 14:14:55 -0400
Message-Id: <200307151829.h6FITd43003528@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andries.Brouwer@cwi.nl
Cc: ahu@ds9a.nl, linux-kernel@vger.kernel.org
Subject: Re: what is needed to test the in-kernel crypto loop? 
In-Reply-To: Your message of "Fri, 11 Jul 2003 15:46:55 +0200."
             <UTC200307111346.h6BDktG25627.aeb@smtp.cwi.nl> 
From: Valdis.Kletnieks@vt.edu
References: <UTC200307111346.h6BDktG25627.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1008539756P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 15 Jul 2003 14:29:39 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1008539756P
Content-Type: text/plain; charset=us-ascii

On Fri, 11 Jul 2003 15:46:55 +0200, Andries.Brouwer@cwi.nl said:

> Try util-linux 2.12, available in 60 hours.

(using this version from ftp.kernel.org/pub/linux/utils/util-linux:
-rw-r--r--   1 korg     korg      1285674   Jul 13 22:09   util-linux-2.12pre.tar.bz2

Umm.. OK... I'll bite.  How do I get 2.12pre to actually use cryptoloop?

losetup -e aes /dev/loop yadd yadda says 'Unknown encryption type aes',
mostly because of this code in lomount.c:

struct crypt_type_struct {
        int id;
        char *name; 
} crypt_type_tbl[] = { 
        { LO_CRYPT_NONE, "no" },
        { LO_CRYPT_NONE, "none" },
        { LO_CRYPT_XOR, "xor" },
        { LO_CRYPT_DES, "DES" },
        { -1, NULL   }          
};                      
                
static int      
crypt_type (const char *name) {
        int i;
        
        if (name) {
                for (i = 0; crypt_type_tbl[i].id != -1; i++)
                        if (!strcasecmp (name, crypt_type_tbl[i].name))
                                return crypt_type_tbl[i].id;
        }
        return -1;
}

none, xor, DES.  Those are the choices - and yes, aes.o is built and in-kernel.

--==_Exmh_1008539756P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/FEgScC3lWbTT17ARAvQRAKDIm7CdeW0szf9vUpMMqbDFC8qpDACgnIAw
86XpwfOYOBmZKdko7/dsW90=
=u3YM
-----END PGP SIGNATURE-----

--==_Exmh_1008539756P--
