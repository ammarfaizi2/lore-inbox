Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965211AbWIERLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbWIERLK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 13:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965212AbWIERLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 13:11:10 -0400
Received: from orca.ele.uri.edu ([131.128.51.63]:27312 "EHLO orca.ele.uri.edu")
	by vger.kernel.org with ESMTP id S965211AbWIERLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 13:11:05 -0400
Date: Tue, 5 Sep 2006 13:10:49 -0400
From: Will Simoneau <simoneau@ele.uri.edu>
To: linux-kernel@vger.kernel.org
Subject: BUG: warning at fs/ext3/inode.c:1016/ext3_getblk()
Message-ID: <20060905171049.GB27433@ele.uri.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 [Linux 2.6.17.11 sparc64]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Has anyone seen this before? These three traces occured at different times
today when three new user accounts (and associated quotas) were created. Th=
is
machine is an NFS server which uses quotas on an ext3 fs (dir_index is on).
Kernel is 2.6.17.11 on an x86 smp w/64G highmem; 4G ram is installed. The
affected filesystem is on a software raid1 of two hardware raid0 volumes fr=
om a
megaraid card.

BUG: warning at fs/ext3/inode.c:1016/ext3_getblk()
 <c01c5140> ext3_getblk+0x98/0x2a6  <c03b2806> md_wakeup_thread+0x26/0x2a
 <c01c536d> ext3_bread+0x1f/0x88  <c01cedf9> ext3_quota_read+0x136/0x1ae
 <c018b683> v1_read_dqblk+0x61/0xac  <c0188f32> dquot_acquire+0xf6/0x107
 <c01ceaba> ext3_acquire_dquot+0x46/0x68  <c01897d4> dqget+0x155/0x1e7
 <c018a97b> dquot_transfer+0x3e0/0x3e9  <c016fe52> dput+0x23/0x13e
 <c01c7986> ext3_setattr+0xc3/0x240  <c0120f66> current_fs_time+0x52/0x6a
 <c017320e> notify_change+0x2bd/0x30d  <c0159246> chown_common+0x9c/0xc5
 <c02a222c> strncpy_from_user+0x3b/0x68  <c0167fe6> do_path_lookup+0xdf/0x2=
66
 <c016841b> __user_walk_fd+0x44/0x5a  <c01592b9> sys_chown+0x4a/0x55
 <c015a43c> vfs_write+0xe7/0x13c  <c01695d4> sys_mkdir+0x1f/0x23
 <c0102a97> syscall_call+0x7/0xb=20

BUG: warning at fs/ext3/inode.c:1016/ext3_getblk()
 <c01c5140> ext3_getblk+0x98/0x2a6  <c0141311> buffered_rmqueue+0xed/0x15b
 <c01414a6> get_page_from_freelist+0x80/0x9e  <c01c536d> ext3_bread+0x1f/0x=
88
 <c01cedf9> ext3_quota_read+0x136/0x1ae  <c018b683> v1_read_dqblk+0x61/0xac
 <c0188f32> dquot_acquire+0xf6/0x107  <c01ceaba> ext3_acquire_dquot+0x46/0x=
68
 <c01897d4> dqget+0x155/0x1e7  <c018a97b> dquot_transfer+0x3e0/0x3e9
 <c016fe52> dput+0x23/0x13e  <c01c7986> ext3_setattr+0xc3/0x240
 <c0120f66> current_fs_time+0x52/0x6a  <c017320e> notify_change+0x2bd/0x30d
 <c0159246> chown_common+0x9c/0xc5  <c02a222c> strncpy_from_user+0x3b/0x68
 <c0167fe6> do_path_lookup+0xdf/0x266  <c016841b> __user_walk_fd+0x44/0x5a
 <c01592b9> sys_chown+0x4a/0x55  <c015a43c> vfs_write+0xe7/0x13c
 <c0104f4f> do_IRQ+0x63/0xa1  <c0102a97> syscall_call+0x7/0xb

BUG: warning at fs/ext3/inode.c:1016/ext3_getblk()
 <c01c5140> ext3_getblk+0x98/0x2a6  <c01d5f8b> __journal_file_buffer+0x18d/=
0x284
 <c01d5142> journal_dirty_metadata+0x141/0x218  <c01dad97> journal_alloc_jo=
urnal_head+0x12/0x68
 <c01c536d> ext3_bread+0x1f/0x88  <c01cedf9> ext3_quota_read+0x136/0x1ae
 <c018b683> v1_read_dqblk+0x61/0xac  <c0188f32> dquot_acquire+0xf6/0x107
 <c01ceaba> ext3_acquire_dquot+0x46/0x68  <c01897d4> dqget+0x155/0x1e7
 <c018a97b> dquot_transfer+0x3e0/0x3e9  <c016fe52> dput+0x23/0x13e
 <c01c7986> ext3_setattr+0xc3/0x240  <c0120f66> current_fs_time+0x52/0x6a
 <c017320e> notify_change+0x2bd/0x30d  <c0159246> chown_common+0x9c/0xc5
 <c02a222c> strncpy_from_user+0x3b/0x68  <c0167fe6> do_path_lookup+0xdf/0x2=
66
 <c016841b> __user_walk_fd+0x44/0x5a  <c01592b9> sys_chown+0x4a/0x55
 <c015a43c> vfs_write+0xe7/0x13c  <c01695d4> sys_mkdir+0x1f/0x23
 <c0102a97> syscall_call+0x7/0xb=20

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE/a+ZLYBaX8VDLLURAi2SAJ9st3OTBl3Ssl5qw3EdMW8qYPGp1gCgwvE5
kUBvZzY5DvD60kN7Z+S4sJg=
=SRvG
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
