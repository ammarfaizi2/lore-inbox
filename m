Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbWFHPNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbWFHPNt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 11:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWFHPNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 11:13:49 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:34516 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S964866AbWFHPNs (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 11:13:48 -0400
Message-Id: <200606081513.k58FDEUu008334@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
Cc: Ingo Molnar <mingo@elte.hu>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: lockdep wierdness -  was Re: 2.6.17-rc6-mm1
In-Reply-To: Your message of "Wed, 07 Jun 2006 23:19:57 EDT."
             <200606080319.k583JvjB004726@turing-police.cc.vt.edu>
From: Valdis.Kletnieks@vt.edu
References: <20060607104724.c5d3d730.akpm@osdl.org> <200606072354.41443.rjw@sisk.pl> <20060607221142.GB6287@elte.hu>
            <200606080319.k583JvjB004726@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1149779594_3152P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 08 Jun 2006 11:13:14 -0400
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1149779594_3152P
Content-Type: text/plain; charset=us-ascii

On Wed, 07 Jun 2006 23:19:57 EDT, Valdis.Kletnieks@vt.edu said:
> >   http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-rc6-mm1.patch
> 
> Seems to be making progress.  With this lockdep-combo, I've been up for
> 40 minutes without a peep.

Looks like I spoke too soon.  Caught this while the system was coming
down for a reboot (fortunately syslogd was still running):

[10155.405000] stopped custom tracer.
[10155.405000] BUG: warning at kernel/lockdep.c:2431/check_flags()
[10155.405000]  [<c010316f>] show_trace_log_lvl+0x54/0xfd
[10155.405000]  [<c01036e0>] show_trace+0xd/0x10
[10155.405000]  [<c010377d>] dump_stack+0x19/0x1b
[10155.405000]  [<c0129a70>] check_flags+0x98/0x1f1
[10155.405000]  [<c012c3a4>] lock_release+0x1e/0x369
[10155.405000]  [<c036ddbf>] _spin_unlock_bh+0x16/0x32
[10155.405000]  [<c0324f2e>] igmpv3_clear_delrec+0x9e/0xc6
[10155.405000]  [<c03268ca>] ip_mc_down+0x8e/0xa1
[10155.405000]  [<c032253b>] inetdev_event+0x137/0x289
[10155.405000]  [<c036fb17>] notifier_call_chain+0x20/0x31
[10155.405000]  [<c0120547>] raw_notifier_call_chain+0x8/0xa
[10155.405000]  [<c02ed984>] dev_close+0x5f/0x64
[10155.405000]  [<c02ed187>] dev_change_flags+0x51/0xf1
[10155.405000]  [<c0322c47>] devinet_ioctl+0x23a/0x557
[10155.405000]  [<c03235d6>] inet_ioctl+0x73/0x91
[10155.405000]  [<c02e475d>] sock_ioctl+0x1a7/0x1cc
[10155.405000]  [<c016d642>] do_ioctl+0x22/0x67
[10155.405000]  [<c016d8db>] vfs_ioctl+0x254/0x267
[10155.405000]  [<c016d935>] sys_ioctl+0x47/0x72
[10155.405000]  [<c036e5c3>] syscall_call+0x7/0xb
[10155.405000] irq event stamp: 3577
[10155.405000] hardirqs last  enabled at (3575): [<c0118ebc>] local_bh_enable_ip+0xd7/0x104
[10155.405000] hardirqs last disabled at (3577): [<c036e485>] ret_from_exception+0x9/0xc
[10155.405000] softirqs last  enabled at (3574): [<c0324ebc>] igmpv3_clear_delrec+0x2c/0xc6
[10155.405000] softirqs last disabled at (3576): [<c036db93>] _spin_lock_bh+0xb/0x37


--==_Exmh_1149779594_3152P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEiD6KcC3lWbTT17ARAn/dAKDW0uvbC/INHOYF07B3isUnuNtjJgCg24wP
t2Wx7lWECLuKyh/dqbNTIYQ=
=oPNT
-----END PGP SIGNATURE-----

--==_Exmh_1149779594_3152P--
