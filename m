Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVCHSAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVCHSAS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 13:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbVCHSAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 13:00:18 -0500
Received: from mail.satronet.sk ([217.144.16.198]:56196 "EHLO mail.satronet.sk")
	by vger.kernel.org with ESMTP id S261455AbVCHSAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 13:00:01 -0500
From: Michal Vanco <vanco@satro.sk>
Organization: Satro, s.r.o.
To: linux-kernel@vger.kernel.org
Subject: 2.6.11 on AMD64 traps
Date: Tue, 8 Mar 2005 19:00:18 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1211657.sL8xc06FFV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200503081900.18686.vanco@satro.sk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1211657.sL8xc06FFV
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I see this problem running 2.6.11 on dual AMD64:

Running quagga routing daemon (ospf+bgp) and issuing "netstat -rn |wc -l" command
while quagga tries to load more than 154000 routes from its bgp neighbours causes this trap:

Unable to handle kernel paging request at 00000000007f5c60 RIP:
<ffffffff8041be35>{fib_get_next+181}
PGD 3a112067 PUD 3a115067 PMD 0
Oops: 0000 [1] SMP
CPU 1
Modules linked in:
Pid: 2537, comm: netstat Not tainted 2.6.11-mv
RIP: 0010:[<ffffffff8041be35>] <ffffffff8041be35>{fib_get_next+181}
RSP: 0018:ffff81003a13fe90  EFLAGS: 00010206
RAX: ffff81003a74c000 RBX: 0000000000000000 RCX: ffff81003a13ff50
RDX: 00000000007f5c60 RSI: 0000000000000000 RDI: ffff81003a004d00
RBP: ffff81003a13fed8 R08: ffff81003f3ff7c0 R09: 0000000000000800
R10: 00007fffffffefe0 R11: 0000000000000246 R12: ffff810002231480
R13: 00002aaaaab08000 R14: 0000000000000400 R15: ffff8100022314a8
FS:  00002aaaaae00620(0000) GS:ffffffff806195c0(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00000000007f5c60 CR3: 000000003a12e000 CR4: 00000000000006e0
Process netstat (pid: 2537, threadinfo ffff81003a13e000, task ffff81003a66a760)
Stack: ffffffff8041bf0f ffff810002231480 ffff81003a67ac80 0000000000000000
ffffffff8019576b 0000000000000000 ffff81003a13ff50 00002aaaaab08000
00000000000006f7 00000000000006f8
Call Trace:<ffffffff8041bf0f>{fib_seq_start+63} <ffffffff8019576b>{seq_read+219}
<ffffffff8017497f>{vfs_read+191} <ffffffff80174c53>{sys_read+83}
<ffffffff8010d1ba>{system_call+126}

Code: 48 8b 0a 0f 18 09 48 8b 72 10 48 8b 06 0f 18 08 48 8d 42 10
RIP <ffffffff8041be35>{fib_get_next+181} RSP <ffff81003a13fe90>
CR2: 00000000007f5c60

I saw the same issue on 2.6.10 before. I'm not a kernel hacker but it sounds like
locking problem. But may be I'm totally wrong in this.

michal

--nextPart1211657.sL8xc06FFV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCLegySBxxqpMaGkMRAtVIAKCzk6w7F8oCSk2URpTyGZJUF6OjEACcCe8Q
40Uq+TnaRG4VNI3ntJgSSFU=
=4n7m
-----END PGP SIGNATURE-----

--nextPart1211657.sL8xc06FFV--
