Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275332AbTHSEr1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 00:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275335AbTHSEr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 00:47:27 -0400
Received: from h80ad2781.async.vt.edu ([128.173.39.129]:32641 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S275332AbTHSErZ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 00:47:25 -0400
Message-Id: <200308190447.h7J4l0Vq004410@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Narayan Desai <desai@mcs.anl.gov>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: weird pcmcia problem 
In-Reply-To: Your message of "Mon, 18 Aug 2003 19:34:59 CDT."
             <87u18efpsc.fsf@mcs.anl.gov> 
From: Valdis.Kletnieks@vt.edu
References: <87u18efpsc.fsf@mcs.anl.gov>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_456587320P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 19 Aug 2003 00:47:00 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_456587320P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <4399.1061268420.1@turing-police.cc.vt.edu>

On Mon, 18 Aug 2003 19:34:59 CDT, Narayan Desai <desai@mcs.anl.gov>  said:
> Running 2.6.0-test3 (both with and without your recent yenta socket
> patches) pcmcia cards present during boot don't show up until they are
> removed and reinserted. Once reinserted, they work fine. This only
> seems to occur if yenta_socket is build into the kernel; if support is
> modular, cards appear to be recognized properly at boot time. I am
> running on a thinkpad t21.  Let me know if I can help with this
> problem in any way...  thanks

Same issue on 2.6.0-test3-mm2 on a Dell Latitude C840 with a TrueMobile 1150
wireless (uses orinoco_cs driver) - card is recognized at boot, and somewhat
configured:

Aug 18 11:16:52 turing-police kernel: eth1: Station identity 001f:0001:0008:000a
Aug 18 11:16:53 turing-police kernel: eth1: Looks like a Lucent/Agere firmware version 8.10
Aug 18 11:16:53 turing-police kernel: eth1: Ad-hoc demo mode supported
Aug 18 11:16:53 turing-police kernel: eth1: IEEE standard IBSS ad-hoc mode supported
Aug 18 11:16:53 turing-police kernel: eth1: WEP supported, 104-bit key
Aug 18 11:16:53 turing-police kernel: eth1: MAC address 00:02:2D:5C:11:48
Aug 18 11:16:53 turing-police kernel: eth1: Station name "HERMES I"
Aug 18 11:16:53 turing-police kernel: eth1: ready
Aug 18 11:16:53 turing-police kernel: eth1: index 0x01: Vcc 3.3, irq 11, io 0x0100-0x013f

but it takes a 'cardctl eject 2;cardctl insert 2' to actually finish the job
and get things started (actually popping the card out not required, and not
possible, it's a built-in). Relevant .config:

CONFIG_YENTA=y
CONFIG_HERMES=y
# CONFIG_PLX_HERMES is not set
# CONFIG_TMD_HERMES is not set
CONFIG_PCI_HERMES=y
CONFIG_PCMCIA_HERMES=y

I'm wondering if this is a cardmgr/hotplug bug - if they can't insmod the Yenta
support, they don't realize that it could already be onboard so they don't even
try to start the cards?


--==_Exmh_456587320P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/QavEcC3lWbTT17ARAnqYAKDIBso6jjSlZXolOFyCwnSnJ4jSbgCfWczh
IqMUNOaShfFOaKCxDF+5izE=
=u2xp
-----END PGP SIGNATURE-----

--==_Exmh_456587320P--
