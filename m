Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbUDOV5F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 17:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263372AbUDOV5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 17:57:05 -0400
Received: from smtp-out3.xs4all.nl ([194.109.24.13]:39687 "EHLO
	smtp-out3.xs4all.nl") by vger.kernel.org with ESMTP id S262915AbUDOV44
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 17:56:56 -0400
Subject: assertion failure with new megaraid beta driver leads to
	scheduling failure
From: Paul Wagland <paul@wagland.net>
To: Linux SCSI mailing list <linux-scsi@vger.kernel.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Atul Mukker <atulm@lsil.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-STRVJmuVbXRlc4WhGBWQ"
Message-Id: <1082066202.2176.143.camel@morsel.kungfoocoder.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 15 Apr 2004 23:56:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-STRVJmuVbXRlc4WhGBWQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi all,

Well, seems I have a penchance for causing trouble ;-)

I was playing around with the new beta driver, and was trying to remove
some logical drives using the dellmgr utility.

Well, something between the driver and the BIOS got unhappy, and all of
a sudden I got about 20 of the following lines:

assertion failed:(spin_is_locked(adapter->host_lock)), file: drivers/scsi/m=
egaraid.c, line: 3061:megaraid_abort_handler

followed by (copied by hand... maybe I should set up a serial console :-):

bad: scheduling while atomic!
Call Trace:
 [<c011cd5f>] schedule+0x58f/0x5a0
 [<c01209a7>] __call_console_drivers+0x57/0x60
 [<c0108126>] __down+0x86/0x100
 [<c011cdc0>] default_wake_function+0x0/0x20
 [<f8832790>] megaraid_reset_handler+0x0/0xc0 [megaraid]
 [<c010833c>] __down_failed+0x8/0xc
 [<f8833fee>] .text.lock.megaraid_clib+0x5/0x17 [megaraid]
 [<f88327be>] megaraid_reset_handler+0x2e/0xc0 [megaraid]

this was called from:
scsi_try_bus_device_reset
scsi_eh_bus_device_reset
scsi_eh_ready_devs
scsi_unjam_host
default_wake_function
scsi_error_handler
scsi_error_handler
kernel_thread_helper



Thoughts and/or suggestions?

Cheers,
Paul

--=-STRVJmuVbXRlc4WhGBWQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAfwUatch0EvEFvxURAnBrAJ92TF6iT6vnzreoINTDTuJGfr471ACgvaDH
kxiJMmvc6u2x8cT5cdpyrjU=
=ze0f
-----END PGP SIGNATURE-----

--=-STRVJmuVbXRlc4WhGBWQ--

