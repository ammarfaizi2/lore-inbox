Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbTISCsH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 22:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbTISCsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 22:48:07 -0400
Received: from h80ad275c.async.vt.edu ([128.173.39.92]:6787 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261159AbTISCsD (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 22:48:03 -0400
Message-Id: <200309190247.h8J2lmhx005690@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Russell King <rmk@arm.linux.org.uk>
Cc: Sean Estabrooks <seanlkml@rogers.com>, linux-kernel@vger.kernel.org
Subject: Re: [PCMCIA] Xircom nic hang on boot since cs.c race condition patch 
In-Reply-To: Your message of "Wed, 17 Sep 2003 22:33:36 BST."
             <20030917223336.H16045@flint.arm.linux.org.uk> 
From: Valdis.Kletnieks@vt.edu
References: <20030917144406.753953dd.seanlkml@rogers.com>
            <20030917223336.H16045@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1002345984P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 18 Sep 2003 22:47:48 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1002345984P
Content-Type: text/plain; charset=us-ascii

On Wed, 17 Sep 2003 22:33:36 BST, Russell King said:
> On Wed, Sep 17, 2003 at 02:44:06PM -0400, Sean Estabrooks wrote:
> > [PCMCIA] Fix race condition causing cards to be incorrectly recognised
> > 
> > This patch that went into test5 causes my Toshiba laptop with Xircom 
> > pcmcia nic to freeze on boot at "Socket status: 30000020".  
> 
> Unfortunately this patch does two things:
> 
> (a) it fixes the problem with PCMCIA cards not being recognised on boot.
> (b) it introduces a deadlock between the PCMCIA layer and the driver
>     model.

OK... so what's different about Sean's Toshiba and my Dell (or alternatively,
the fact we both have Xircom cards) that the *old* code worked just fine?

Is it the fact that it's a multi-function card?

lspci -v says:
03:00.0 Ethernet controller: Xircom Cardbus Ethernet 10/100 (rev 03)
        Subsystem: Xircom Cardbus Ethernet 10/100
        Flags: bus master, medium devsel, latency 64, IRQ 9
        I/O ports at 1000 [size=128]
        Memory at 10800000 (32-bit, non-prefetchable) [size=2K]
        Memory at 10800800 (32-bit, non-prefetchable) [size=2K]
        Expansion ROM at 10400000 [disabled] [size=16K]
        Capabilities: [dc] Power Management version 1

03:00.1 Serial controller: Xircom Cardbus Ethernet + 56k Modem (rev 03) (prog-if 02 [16550])
        Subsystem: Xircom CBEM56G-100 Ethernet + 56k Modem
        Flags: medium devsel, IRQ 9
        I/O ports at 1080 [size=8]
        Memory at 10801000 (32-bit, non-prefetchable) [size=2K]
        Memory at 10801800 (32-bit, non-prefetchable) [size=2K]
        Expansion ROM at 10404000 [disabled] [size=16K]
        Capabilities: [dc] Power Management version 1

I could see problems if the serial controller is being added while the ethernet
controller is still getting its act together while holding locks, since it's one
physical card.

I admit not being hot on the programming model  for cardbus, but I'm
quite willing to test patches.. ;)



--==_Exmh_1002345984P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/am5UcC3lWbTT17ARAgqoAJ9+i4Xb72qznNRS11kTb8DQ6vDhKgCgjOMi
eIv6ar7Ec7S4h7YrUCNvye4=
=LiNs
-----END PGP SIGNATURE-----

--==_Exmh_1002345984P--
