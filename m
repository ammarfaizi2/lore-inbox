Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030303AbWJCREW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030303AbWJCREW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 13:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbWJCREW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 13:04:22 -0400
Received: from mx6.mail.ru ([194.67.23.26]:64848 "EHLO mx6.mail.ru")
	by vger.kernel.org with ESMTP id S1030303AbWJCRET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 13:04:19 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18: BUG: lock held at task exit time! on resume from STR
Date: Tue, 3 Oct 2006 21:04:20 +0400
User-Agent: KMail/1.9.4
Cc: linux-acpi@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610032104.21492.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Running Toshiba Portege 4000, I have intermittent lockups at resume from STR. 
Those lockups were less frequent before 2.6.18 ("it mostly works"); after 
switching to 2.6.18 it is rather "it almost never works". After enabling full 
console output (SysRq-9) and doing suspend/resume I got:

BUG: lock held at task exit time!
echo/1931 is exiting with locks still held!
1 lock held by by echo/1931
  #0 (acpi_gbl_hardware_lock) {+...}, at [<c01df0d8>] 
acpi_os_acquire_lock+0x8/0xa

I also have relatively bad photo of screen with stack trace but it is not 
actually interesting (it just says task was exiting).

After that system stays still, I only can press power button.

echo mentioned above is likely to be

    FILE=/sys/power/state
    PARAM=mem

    /usr/share/suspend-scripts/run_scripts $debug suspend s3

    if ! (/bin/echo $PARAM > $FILE &) ;then
        ret=1
    fi

I appreciate any hint how to further debug the issue.


TIA

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFIpgVR6LMutpd94wRAlIwAKCPPlxwmeogp6mKdNfSo3teAtqYywCgrP6B
uD5IBV2GYyxwfjmusTlHzrM=
=6QeU
-----END PGP SIGNATURE-----
