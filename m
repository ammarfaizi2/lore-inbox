Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbSLMRLa>; Fri, 13 Dec 2002 12:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265187AbSLMRLa>; Fri, 13 Dec 2002 12:11:30 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:31361 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S265174AbSLMRL3>; Fri, 13 Dec 2002 12:11:29 -0500
Message-Id: <200212131718.gBDHIw27008173@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Petr Konecny <pekon@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>
Subject: Re: 2.5.5[01]]: Xircom Cardbus broken (PCI resource collisions) 
In-Reply-To: Your message of "Fri, 13 Dec 2002 17:33:00 +0100."
             <200212131633.gBDGX0617899@anxur.fi.muni.cz> 
From: Valdis.Kletnieks@vt.edu
References: <200212131345.gBDDjw27002677@turing-police.cc.vt.edu>
            <200212131633.gBDGX0617899@anxur.fi.muni.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1952560008P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Dec 2002 12:18:58 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1952560008P
Content-Type: text/plain; charset=us-ascii

On Fri, 13 Dec 2002 17:33:00 +0100, Petr Konecny <pekon@informatics.muni.cz>  said:

>  Valdis> I see why the if/continue was added - you don't want to be
>  Valdis> calling device_register()/pci_insert_device() if
>  Valdis> pci_enable_device() loses.  I don't see why 2.5.50 moved the
>  Valdis> code up after pci_setup_device(). There's an outside chance
>  Valdis> that the concept of moving the call was correct, but that it
>  Valdis> should have been moved to between the calls to
>  Valdis> pci_assign_resource() and pci_readb().  If that's the case,
>  Valdis> then you're correct as well....
> I can confirm that this indeed works. I moved the two lines before
> pci_readb and the card works (every character you now read went through
> it). Who shall submit a patch to Linus ?

The problem is this from the 2.5.50 Changelog that Linus posted:

Dave Jones <davej@suse.de>:
...
  o make cardbus PCI enable earlier

I'm willing to submit a patch, but I think Dave has to make the call whether
it should be backed out entirely, or moved after pci_assign_resource().
I certainly don't understand the code *or* PCI well enough to decide between
those two option...

/Valdis


--==_Exmh_1952560008P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE9+haBcC3lWbTT17ARAuFbAJ4wXQaX0gQSdtIDC0bLyjdtpTan5QCg3K9R
ZYn1ZcmNFCdc68kLfCtgm34=
=fgAB
-----END PGP SIGNATURE-----

--==_Exmh_1952560008P--
