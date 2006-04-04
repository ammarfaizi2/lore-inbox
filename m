Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWDDVVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWDDVVs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 17:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbWDDVVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 17:21:48 -0400
Received: from mail.charite.de ([160.45.207.131]:48540 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S1750886AbWDDVVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 17:21:47 -0400
Date: Tue, 4 Apr 2006 23:21:44 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Cc: linux-xfs@oss.sgi.com
Subject: 2.6.16.1: XFS internal error xfs_btree_check_lblock at line 215 of file fs/xfs/xfs_btree.c
Message-ID: <20060404212144.GM15722@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was running xfs_fsr on our /home at night when this happened:
(Kernel 2.6.16.1)

Security Events
=-=-=-=-=-=-=-=
Apr  2 00:26:17 postamt kernel: xfs_force_shutdown(sda5,0x8) called from line 1032 of file fs/xfs/xfs_trans.c.  Return address = 0xb1128274

System Events
=-=-=-=-=-=-=
Apr  2 00:17:10 postamt fsr[28019]: /home start inode=0
Apr  2 00:25:29 postamt fsr[28938]: /home start inode=0
Apr  2 00:26:17 postamt kernel: Filesystem "sda5": XFS internal error xfs_btree_check_lblock at line 215 of file fs/xfs/xfs_btree.c.  Caller 0xb10dba58
Apr  2 00:26:17 postamt kernel:  [xfs_btree_check_lblock+82/407] xfs_btree_check_lblock+0x52/0x197
Apr  2 00:26:17 postamt kernel:  [xfs_bmbt_lookup+636/1471] xfs_bmbt_lookup+0x27c/0x5bf
Apr  2 00:26:17 postamt kernel:  [xfs_bmbt_lookup+636/1471] xfs_bmbt_lookup+0x27c/0x5bf
Apr  2 00:26:17 postamt kernel:  [xfs_bmap_del_extent+491/2774] xfs_bmap_del_extent+0x1eb/0xad6
Apr  2 00:26:17 postamt kernel:  [xfs_mod_incore_sb_batch+60/134] xfs_mod_incore_sb_batch+0x3c/0x86
Apr  2 00:26:17 postamt kernel:  [kmem_zone_alloc+61/176] kmem_zone_alloc+0x3d/0xb0
Apr  2 00:26:17 postamt kernel:  [xfs_bmap_search_extents+117/279] xfs_bmap_search_extents+0x75/0x117
Apr  2 00:26:17 postamt kernel:  [xfs_bunmapi+1851/4334] xfs_bunmapi+0x73b/0x10ee
Apr  2 00:26:17 postamt kernel:  [xfs_trans_ijoin+43/134] xfs_trans_ijoin+0x2b/0x86
Apr  2 00:26:17 postamt kernel:  [xfs_itruncate_finish+617/942] xfs_itruncate_finish+0x269/0x3ae
Apr  2 00:26:17 postamt kernel:  [xfs_trans_ijoin+43/134] xfs_trans_ijoin+0x2b/0x86
Apr  2 00:26:17 postamt kernel:  [xfs_inactive+1058/1282] xfs_inactive+0x422/0x502
Apr  2 00:26:17 postamt fsr[28938]: could not remove tmpdir: /home/.fsr/ag0: Input/output error
Apr  2 00:26:17 postamt kernel:  [linvfs_clear_inode+140/164] linvfs_clear_inode+0x8c/0xa4
Apr  2 00:26:17 postamt kernel:  [dquot_drop+0/106] dquot_drop+0x0/0x6a
Apr  2 00:26:17 postamt kernel:  [clear_inode+173/290] clear_inode+0xad/0x122
Apr  2 00:26:17 postamt fsr[28938]: could not remove tmpdir: /home/.fsr/ag1: Input/output error
Apr  2 00:26:17 postamt kernel:  [truncate_inode_pages+23/27] truncate_inode_pages+0x17/0x1b
Apr  2 00:26:17 postamt kernel:  [generic_delete_inode+207/284] generic_delete_inode+0xcf/0x11c
Apr  2 00:26:17 postamt kernel:  [iput+83/101] iput+0x53/0x65
Apr  2 00:26:17 postamt kernel:  [dput+106/302] dput+0x6a/0x12e
Apr  2 00:26:17 postamt kernel:  [__fput+258/350] __fput+0x102/0x15e
Apr  2 00:26:17 postamt kernel:  [filp_close+60/123] filp_close+0x3c/0x7b
Apr  2 00:26:17 postamt kernel:  [sys_close+86/143] sys_close+0x56/0x8f
Apr  2 00:26:17 postamt fsr[28938]: could not remove tmpdir: /home/.fsr/ag2: Input/output error
Apr  2 00:26:17 postamt kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
Apr  2 00:26:17 postamt kernel: Filesystem "sda5": XFS internal error xfs_trans_cancel at line 1031 of file fs/xfs/xfs_trans.c.  Caller 0xb1118f9f
Apr  2 00:26:17 postamt fsr[28938]: could not remove tmpdir: /home/.fsr/ag3: Input/output error
Apr  2 00:26:17 postamt kernel:  [xfs_trans_cancel+211/270] xfs_trans_cancel+0xd3/0x10e
Apr  2 00:26:17 postamt fsr[28938]: could not remove tmpdir: /home/.fsr/ag4: Input/output error
Apr  2 00:26:17 postamt kernel:  [xfs_inactive+1080/1282] xfs_inactive+0x438/0x502
Apr  2 00:26:17 postamt kernel:  [xfs_inactive+1080/1282] xfs_inactive+0x438/0x502
Apr  2 00:26:17 postamt kernel:  [linvfs_clear_inode+140/164] linvfs_clear_inode+0x8c/0xa4
Apr  2 00:26:17 postamt fsr[28938]: could not remove tmpdir: /home/.fsr/ag5: Input/output error
Apr  2 00:26:17 postamt kernel:  [dquot_drop+0/106] dquot_drop+0x0/0x6a
Apr  2 00:26:17 postamt fsr[28938]: could not remove tmpdir: /home/.fsr/ag6: Input/output error
Apr  2 00:26:17 postamt kernel:  [clear_inode+173/290] clear_inode+0xad/0x122
Apr  2 00:26:17 postamt kernel:  [truncate_inode_pages+23/27] truncate_inode_pages+0x17/0x1b
Apr  2 00:26:17 postamt fsr[28938]: could not remove tmpdir: /home/.fsr/ag7: Input/output error
Apr  2 00:26:17 postamt kernel:  [generic_delete_inode+207/284] generic_delete_inode+0xcf/0x11c
Apr  2 00:26:17 postamt kernel:  [iput+83/101] iput+0x53/0x65
Apr  2 00:26:17 postamt fsr[28938]: could not remove tmpdir: /home/.fsr/ag8: Input/output error
Apr  2 00:26:17 postamt kernel:  [dput+106/302] dput+0x6a/0x12e
Apr  2 00:26:17 postamt kernel:  [__fput+258/350] __fput+0x102/0x15e
Apr  2 00:26:17 postamt kernel:  [filp_close+60/123] filp_close+0x3c/0x7b
Apr  2 00:26:17 postamt fsr[28938]: could not remove tmpdir: /home/.fsr/ag9: Input/output error
Apr  2 00:26:17 postamt kernel:  [sys_close+86/143] sys_close+0x56/0x8f
Apr  2 00:26:17 postamt kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
Apr  2 00:26:17 postamt fsr[28938]: could not remove tmpdir: /home/.fsr/ag10: Input/output error
Apr  2 00:26:17 postamt kernel: Filesystem "sda5": Corruption of in-memory data detected.  Shutting down filesystem: sda5
Apr  2 00:26:17 postamt fsr[28938]: could not remove tmpdir: /home/.fsr/ag11: Input/output error
Apr  2 00:26:17 postamt kernel: Please umount the filesystem, and rectify the problem(s)
Apr  2 00:26:17 postamt fsr[28938]: could not remove tmpdir: /home/.fsr/ag12: Input/output error
Apr  2 00:26:17 postamt fsr[28938]: could not remove tmpdir: /home/.fsr/ag13: Input/output error
Apr  2 00:26:17 postamt fsr[28938]: could not remove tmpdir: /home/.fsr/ag14: Input/output error
Apr  2 00:26:17 postamt fsr[28938]: could not remove tmpdir: /home/.fsr/ag15: Input/output error
Apr  2 00:26:17 postamt fsr[28938]: could not remove tmpdir: /home/.fsr: Input/output error
Apr  2 00:26:17 postamt fsr[29047]: /home start inode=0
Apr  2 00:26:17 postamt fsr[29047]: could not create tmpdir: /home/.fsr: Input/output error
Apr  2 00:26:17 postamt fsr[29048]: /home start inode=0
Apr  2 00:26:17 postamt fsr[29048]: could not create tmpdir: /home/.fsr: Input/output error
Apr  2 00:26:17 postamt fsr[29049]: /home start inode=0
Apr  2 00:26:17 postamt fsr[29049]: could not create tmpdir: /home/.fsr: Input/output error
Apr  2 00:26:17 postamt fsr[29050]: /home start inode=0
Apr  2 00:26:17 postamt fsr[29050]: could not create tmpdir: /home/.fsr: Input/output error
Apr  2 00:26:17 postamt fsr[29051]: /home start inode=0
Apr  2 00:26:17 postamt fsr[29051]: could not create tmpdir: /home/.fsr: Input/output error
Apr  2 00:26:17 postamt fsr[29052]: /home start inode=0
Apr  2 00:26:17 postamt fsr[29052]: could not create tmpdir: /home/.fsr: Input/output error
Apr  2 00:26:17 postamt fsr[29053]: /home start inode=0
Apr  2 00:26:17 postamt fsr[29053]: could not create tmpdir: /home/.fsr: Input/output error
Apr  2 00:26:17 postamt fsr[25409]: Completed all 10 passes

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
