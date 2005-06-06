Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVFFMrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVFFMrj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 08:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVFFMrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 08:47:39 -0400
Received: from lucifer.czad.org ([80.55.246.78]:33736 "EHLO lucifer.czad.org")
	by vger.kernel.org with ESMTP id S261383AbVFFMrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 08:47:07 -0400
Subject: XFS oops, kernel 2.4.30 w/grsecurity
From: Marek Materzok <tilk@lucifer.czad.org>
Reply-To: tilk@lucifer.czad.org
To: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 06 Jun 2005 14:47:02 +0200
Message-Id: <1118062022.6266.19.camel@lucifer.czad.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A following error happened on my server today:

Jun  6 11:40:08 lucifer kernel: Filesystem "ide0(3,6)": XFS internal error xfs_btree_check_lblock at line 222 of file xfs_btree.c.  Caller 0xc01ed58d
Jun  6 11:40:08 lucifer kernel: c9871750 c01efc41 c0374857 00000001 d71ffc00 c037484b 000000de c01ed58d 
Jun  6 11:40:08 lucifer kernel:        c8bd4f80 d76b2940 00ca1740 00000000 00000008 00000000 c987178c cf416124 
Jun  6 11:40:08 lucifer kernel:        00000000 e8421900 d0df8000 c01ed58d cf416124 d0df8000 00000000 d7e66d40 
Jun  6 11:40:08 lucifer kernel: Call Trace:    [xfs_btree_check_lblock+97/416] [xfs_bmbt_rshift+253/1584] [xfs_bmbt_rshift+253/1584] [kmem_zone_zalloc+53/95] [xfs_buf_item_init+85/192]
Jun  6 11:40:08 lucifer kernel:   [xfs_bmbt_insrec+1072/1552] [xfs_btree_check_lblock+155/416] [xfs_bmbt_lookup+1191/1296] [xfs_bmbt_insert+109/320] [xfs_bmap_add_extent_delay_real+4261/5440] [xfs_trans_mod_dquot_byino+272/288]
Jun  6 11:40:08 lucifer kernel:   [xfs_trans_mod_dquot+58/304] [xfs_bmap_add_extent+829/1104] [kmem_zone_zalloc+53/95] [xfs_bmapi+1706/5584] [xfs_bmap_do_search_extents+248/1056] [xfs_bmap_search_extents+107/272]
Jun  6 11:40:08 lucifer kernel:   [xfs_log_reserve+191/208] [xfs_iomap_write_allocate+698/1392] [xfs_iunlock+62/128] [xfs_iomap+987/1344] [xfs_map_blocks+88/144] [xfs_page_state_convert+1208/1600]
Jun  6 11:40:08 lucifer kernel:   [create_buffers+107/224] [linvfs_writepage+126/304] [fsync_buffers_list+290/384] [__block_commit_write+128/192] [generic_osync_inode+143/176] [do_generic_file_write+875/1056]
Jun  6 11:40:08 lucifer kernel:   [xfs_write+684/2432] [do_generic_file_read+494/1120] [update_atime+108/112] [linvfs_write+245/400] [do_readv_writev+451/560] [linvfs_write+0/400]
Jun  6 11:40:09 lucifer kernel:   [sys_writev+90/128] [system_call+51/64]
Jun  6 11:40:09 lucifer kernel: xfs_force_shutdown(ide0(3,6),0x8) called from line 1091 of file xfs_trans.c.  Return address = 0xc023aa4b
Jun  6 11:40:09 lucifer kernel: Filesystem "ide0(3,6)": Corruption of in-memory data detected.  Shutting down filesystem: ide0(3,6)
Jun  6 11:40:09 lucifer kernel: Please umount the filesystem, and rectify the problem(s)

Then, the /home partition (/dev/hda6) was disabled, and every access to
it ended with EIO. A reboot fixed the problem - the filesystem was
rebuilt and mounted correctly. Nothing like this happened ever to my XFS
filesystems.

My kernel is:

Linux version 2.4.30-tilk1 (tilk@lucifer.czad.org) (gcc version 3.3.4
(Debian 1:3.3.4-3)) #1 sob kwi 9 12:54:22 CEST 2005

Patches applied are: grsecurity 2.1.5, lm_sensors 2.8.8, XFS ACL.

-- 
 _____ _ _ _   
|_   _(_) | |__ |   Marek "Tilk" Materzok  --  tilk@lucifer.czad.org   |
  | | | | | / / |   http://tilk.czad.org/  --      GPG #F8C12ABE       |
  |_| |_|_|_\_\ | "How can you challenge a perfect, immortal machine?" |

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GCS d- s: a--- C++ UL+++$ P-- L+++$ E- W++ N+ o? K? w--- O? M? V?
PS+ PE- Y+ PGP+ !t 5? X R* tv b+ DI+ D G e h! !r y- 
------END GEEK CODE BLOCK------
