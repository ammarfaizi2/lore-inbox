Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264821AbUELAqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264821AbUELAqc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 20:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbUELAmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 20:42:32 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:57273 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265014AbUELAjh (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 20:39:37 -0400
Message-Id: <200405120039.i4C0dHs0010426@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Matt Porter <mporter@kernel.crashing.org>
Cc: akpm@osdl.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH 1/2] PPC32: New OCP core support 
In-Reply-To: Your message of "Tue, 11 May 2004 17:01:50 PDT."
             <20040511170150.A4743@home.com> 
From: Valdis.Kletnieks@vt.edu
References: <20040511170150.A4743@home.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-463625020P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 11 May 2004 20:39:17 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-463625020P
Content-Type: text/plain; charset=us-ascii

On Tue, 11 May 2004 17:01:50 PDT, Matt Porter said:
> New OCP infrastructure ported from 2.4 along with several
> enhancements. Please apply.

Big honking patch.  Wholesale removal of old code. Wholesale addition of new code.

And this is the closest to a hint of what an OCP in the old code:

- * @device: OCP device such as PCI, GPT, UART, OPB, IIC, GPIO, EMAC, ZMII
- * @dev_num: ocp device number whos paddr you want

And in the new:

+extern struct ocp_def core_ocp[];	/* Static list of devices, provided by
+					   CPU core */

And some vendor IDs that say that IBM and FreeScale make them, and Motorola
apparently rebadges/clones Freescale's (or vice versa)..

I'm *guessing* that this is some all-in-one integrated north/south/PCI/east bridge
with an APIC or similar and some I/O controllers....  Or maybe it's a board-level
designator like 'ebony' seems to be.. or something.. 

It's a UART... or a Bus-level board.. or both.. ;)

arch/ppc/Kconfig says this:
config OCP
        bool
        depends on IBM_OCP
        default y
that leads to arch/ppc/platforms/4xx/Kconfig:
config IBM_OCP
        bool
        depends on ASH || CPCI405 || EBONY || EP405 || OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMOR
E || WALNUT
        default y

Grepping for OCP in arch/ppc/platforms/4xx/* isn't informative either..

Color me mystified.. ;)

(Actually, other than the apparent lack of any comment that says what an OCP
in fact is, I didn't see any really big style problems while scrolling through it..) 

--==_Exmh_-463625020P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAoXI1cC3lWbTT17ARAip9AJ9t5XcStAqfh6jfSTX6CuT/m34GKACfZykY
+5WNVtwAiOk9eNJLavtrFQo=
=GOig
-----END PGP SIGNATURE-----

--==_Exmh_-463625020P--
