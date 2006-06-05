Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751026AbWFERAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWFERAW (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 13:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWFERAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 13:00:22 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:15561 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751026AbWFERAV (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 13:00:21 -0400
Message-Id: <200606051700.k55H015q004029@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>, jack@suse.cz
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc5-mm3-lockdep - locking error in quotaon
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1149526800_3268P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 05 Jun 2006 13:00:01 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1149526800_3268P
Content-Type: text/plain; charset=us-ascii

Using the -lockdep patch that Ingo had a few days ago, plus Stefan Richter's
two patches for ieee1394 (which fixed the *first* locking issue I hit)....

[  219.535000] (         quotaon-1374 |#0): new 222056071 us user-latency.
[  219.535000] stopped custom tracer.
[  219.535000] 
[  219.535000] ======================================
[  219.535000] [ BUG: bad unlock ordering detected! ]
[  219.535000] --------------------------------------
[  219.535000] quotaon/1374 is trying to release lock (&inode->i_mutex) at:
[  219.535000]  [<c0382ba2>] mutex_unlock+0xd/0xf
[  219.535000] but the next lock to release is:
[  219.535000]  (&s->s_dquot.dqonoff_mutex){--..}, at: [<c0382a09>] mutex_lock+0xd/0xf
[  219.535000] 
[  219.535000] other info that might help us debug this:
[  219.535000] 2 locks held by quotaon/1374:
[  219.535000]  #0:  (&s->s_umount#16){----}, at: [<c016828f>] get_super+0x4a/0xd4
[  219.535000]  #1:  (&inode->i_mutex){--..}, at: [<c0382a09>] mutex_lock+0xd/0xf
[  219.535000] 
[  219.535000] stack backtrace:
[  219.535000]  [<c01032d6>] show_trace_log_lvl+0x64/0x125
[  219.535000]  [<c0103865>] show_trace+0x1b/0x20
[  219.535000]  [<c010391c>] dump_stack+0x1f/0x24
[  219.535000]  [<c012dee7>] lockdep_release+0x192/0x35e
[  219.535000]  [<c0382b53>] __mutex_unlock_slowpath+0x29/0x6b
[  219.535000]  [<c0382ba2>] mutex_unlock+0xd/0xf
[  219.535000]  [<c019243c>] vfs_quota_on_inode+0x35e/0x538
[  219.535000]  [<c019334b>] vfs_quota_on+0x55/0x6b
[  219.535000]  [<c01ac3f7>] ext3_quota_on+0x47/0xb6
[  219.535000]  [<c0195a11>] sys_quotactl+0x3b5/0x695
[  219.535000]  [<c03845b2>] sysenter_past_esp+0x63/0xa1






--==_Exmh_1149526800_3268P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEhGMQcC3lWbTT17ARAqTlAKDMmV49U0NXZy1EM9FB7/ONwtro1QCfUwLG
5PO8IvYV6J8D3kGzPuZN4pk=
=dVhN
-----END PGP SIGNATURE-----

--==_Exmh_1149526800_3268P--
