Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbULDXXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbULDXXM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 18:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbULDXXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 18:23:12 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:26549 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261191AbULDXXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 18:23:08 -0500
Message-ID: <41B246E2.7070501@comcast.net>
Date: Sat, 04 Dec 2004 18:23:14 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041119)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: The __KERNEL__ #define
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Recently there has been talk of splitting up include/linux to obsolete
the __KERNEL__ define.  I would like to request that __KERNEL__ remain
defined in the kernel build process and in module building.

A modified specs file on Gentoo enables -fstack-protector{,-all} in gcc,
two switches added by a patch[1][2] to gcc made by Etoh and Yoda of the
IBM Tokyo Research Labs.  This patch relies on several symbols not
defined in the kernel to do a type of artificial bounds checking,
preventing stack-based buffer overflows from being utilized in security
exploits.  It was determined that this is non-useful in the kernel
(although possibly more research should be done-- is it worth it to
panic when we think there's a kernel-level exploit occuring?), and so
the specs file does not enable these if __KERNEL__ is defined.

The specs file also generates PIE-by-default executables, and disables
this functionality if __KERNEL__ is defined; so if it is determined that
~ SSP in the kernel would be useful, this define is still needed.  In
general it is in itself harmless and should stay as an indicator.

The Hardened Debian project is going to implement a similar specs file
alteration, which may be used in Ubuntu and Debian.

[1] trl.ibm.com/projects/security/ssp/
[2] trl.ibm.com/projects/security/ssp/main.html (paper)

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBskbihDd4aOud5P8RAqfyAJwKY9Krn8e8JFBNixlGRkFae9L7XACfQ/AV
x7AtknAzLTVjfuOQjUE1IWs=
=qx1O
-----END PGP SIGNATURE-----
