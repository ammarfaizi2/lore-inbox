Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271845AbTHRPRF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 11:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271938AbTHRPRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 11:17:05 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:384 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S271845AbTHRPRA (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 11:17:00 -0400
Message-Id: <200308181403.h7IE3YnP030524@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3-mm2 - failure to panic
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-881346320P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 18 Aug 2003 10:03:32 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-881346320P
Content-Type: text/plain; charset=us-ascii

Last night, I left my laptop running all night, and find this on the terminals this morning:

Message from syslogd@turing-police at Mon Aug 18 04:01:01 2003 ...
turing-police kernel: In idle task - not syncing

So I go digging in the syslogs and find:

Aug 18 04:00:59 turing-police kernel: Unable to handle kernel paging request at virtual address fff95fb8
Aug 18 04:00:59 turing-police kernel:  printing eip:
Aug 18 04:00:59 turing-police kernel: c0238135
Aug 18 04:00:59 turing-police kernel: *pde = 00001067
Aug 18 04:00:59 turing-police kernel: *pte = 00000000
Aug 18 04:00:59 turing-police kernel: Oops: 0000 [#1]
Aug 18 04:00:59 turing-police kernel: PREEMPT
Aug 18 04:00:59 turing-police kernel: CPU:    0
Aug 18 04:01:00 turing-police kernel: EIP:    0060:[acpi_processor_idle+371/485]    Tainted: P   VLI
Aug 18 04:01:00 turing-police kernel: EFLAGS: 00010206
Aug 18 04:01:00 turing-police kernel: EIP is at acpi_processor_idle+0x173/0x1e5
Aug 18 04:01:00 turing-police kernel: eax: 00000a14   ebx: 00000a10   ecx: 00000000   edx: 00000808
Aug 18 04:01:00 turing-police kernel: esi: c138eab0   edi: c138ea00   ebp: fff95fcc   esp: c04b5fb4
Aug 18 04:01:00 turing-police kernel: ds: 007b   es: 007b   ss: 0068
Aug 18 04:01:00 turing-police kernel: Process swapper (pid: 0, threadinfo=c04b4000 task=c04279c0)
Aug 18 04:01:00 turing-police kernel: Stack: c0237fc2 c138ea00 c023007b c04b4000 0009b800 c0107000 c04b5fd8 c010ace7
Aug 18 04:01:00 turing-police kernel:        0001080e c04b5ff8 c04b66f0 c04279c0 00000000 c04db0c8 00000005 c04b644a
Aug 18 04:01:00 turing-police kernel:        c04e4240 0008e000 c010017e
Aug 18 04:01:00 turing-police kernel: Call Trace:
Aug 18 04:01:00 turing-police kernel:  [acpi_processor_idle+0/485] acpi_processor_idle+0x0/0x1e5
Aug 18 04:01:00 turing-police kernel:  [acpi_tb_build_common_facs+8/181] acpi_tb_build_common_facs+0x8/0xb5
Aug 18 04:01:00 turing-police kernel:  [rest_init+0/96] _stext+0x0/0x60
Aug 18 04:01:00 turing-police kernel:  [cpu_idle+47/56] cpu_idle+0x2f/0x38
Aug 18 04:01:01 turing-police kernel:  [start_kernel+379/416] start_kernel+0x17b/0x1a0
Aug 18 04:01:01 turing-police kernel:  [unknown_bootoption+0/248] unknown_bootoption+0x0/0xf8
Aug 18 04:01:01 turing-police kernel:
Aug 18 04:01:01 turing-police kernel: Code: f6 05 71 b7 4f c0 01 75 0f 29 fb 8d 83 ff ff ff 00 25 ff ff ff 00 eb 05 29 fb 8d 43 ff 2b 46 0c 8d 58 fc eb 03 fb eb 6d 8b 4e 1c <8b> 7d ec 85 c9 8b 57 14 74 2f 3b 5e 24 76 2a 8b 46 18 c7 46 30
Aug 18 04:01:01 turing-police kernel:  <0>Kernel panic: Attempted to kill the idle task!
Aug 18 04:01:01 turing-police kernel: In idle task - not syncing

However, we somehow managed to survive the call to panic():

% date
Mon Aug 18 09:16:06 EDT 2003
% uptime
 09:16:09  up 2 days, 11:09,  4 users,  load average: 0.11, 0.23, 0.18
 
Leaving the two questions:

1) Why did acpi_processor_idle() get a bad pointer?
2) Why wasn't the laptop dead as a doornail this morning?

Any ideas?

--==_Exmh_-881346320P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/QNy0cC3lWbTT17ARAmpsAKCUFs1B3hJ4gzt1UPYEQKSpMg1XcACfSZjh
+4esBa0pztDTvOmpKj17Dpk=
=9kna
-----END PGP SIGNATURE-----

--==_Exmh_-881346320P--
