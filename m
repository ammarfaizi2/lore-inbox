Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262641AbSJVX1K>; Tue, 22 Oct 2002 19:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262664AbSJVX1K>; Tue, 22 Oct 2002 19:27:10 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:7304 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262641AbSJVX1I>; Tue, 22 Oct 2002 19:27:08 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.5.44: How to decode call trace
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Wed, 23 Oct 2002 01:33:04 +0200
Message-ID: <87elai82xb.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the following call tree:

Oct 22 22:35:36 goat kernel: rm            D 00000246     0   615    387                     (NOTLB)
Oct 22 22:35:36 goat kernel: Call Trace:
Oct 22 22:35:36 goat kernel:  [<c0105ebf>] __down+0x67/0xb8
Oct 22 22:35:36 goat kernel:  [<c0112a5c>] default_wake_function+0x0/0x34
Oct 22 22:35:36 goat kernel:  [<c0106034>] __down_failed+0x8/0xc
Oct 22 22:35:36 goat kernel:  [<c0143601>] .text.lock.namei+0x5/0x174
Oct 22 22:35:36 goat kernel:  [<c0140768>] do_lookup+0x9c/0x1bc
Oct 22 22:35:36 goat kernel:  [<c0140dde>] link_path_walk+0x556/0x868
Oct 22 22:35:36 goat kernel:  [<c015bedc>] ext2_commit_chunk+0x38/0x6c
Oct 22 22:35:36 goat kernel:  [<e08696a9>] name.810+0xd/0x10 [fscaps]
Oct 22 22:35:36 goat kernel:  [<c015bf09>] ext2_commit_chunk+0x65/0x6c
Oct 22 22:35:36 goat kernel:  [<e086969c>] name.810+0x0/0x10 [fscaps]
Oct 22 22:35:36 goat kernel:  [<c0141117>] path_walk+0x27/0x28
Oct 22 22:35:36 goat kernel:  [<e086909f>] __fscap_lookup+0x3f/0x40 [fscaps]
Oct 22 22:35:36 goat kernel:  [<e0869266>] fscap_drop_op+0x1a/0x5c [fscaps]
Oct 22 22:35:36 goat kernel:  [<c01424de>] vfs_unlink+0x14e/0x178
Oct 22 22:35:36 goat kernel:  [<c01425b2>] sys_unlink+0xaa/0x120
Oct 22 22:35:36 goat kernel:  [<c0106d93>] syscall_call+0x7/0xb

and this is the code:
static int __fscap_lookup(struct vfsmount *mnt, struct nameidata *nd)
{
	static char name[] = ".capabilities";
	nd->mnt = mntget(mnt);
	nd->dentry = dget(mnt->mnt_sb->s_root);
	nd->flags = 0;
	return path_walk(name, nd);
}

What does .text.lock.namei and name.810 mean?
Is there a way to get the line number out of these hex values?

TIA
Regards, Olaf.
