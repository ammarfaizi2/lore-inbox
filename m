Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWKGM17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWKGM17 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 07:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWKGM17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 07:27:59 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:15548 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S932508AbWKGM16
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 07:27:58 -0500
Message-ID: <4550819C.10403@in.ibm.com>
Date: Tue, 07 Nov 2006 18:22:44 +0530
From: Srinivasa Ds <srinivasa@in.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Tilman Schmidt <tilman@imap.cc>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re:[2.6.19-rc4] "possible recursive locking detected"
 in reiserfs_xattr_set
References: <454B6A64.1000107@imap.cc> <454EFDD8.4020608@in.ibm.com> <454F8AAE.2000705@imap.cc>
In-Reply-To: <454F8AAE.2000705@imap.cc>
Content-Type: multipart/mixed;
 boundary="------------080406070105020904060508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080406070105020904060508
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tilman Schmidt wrote:
> Am 06.11.2006 10:18 schrieb Srinivasa Ds:
>   
>> This patch should solve your problem.
>>     
>
> 'fraid it doesn't. It just changes the message to:
>
> Nov  6 19:47:51 gx110 kernel: [  135.987220]
> Nov  6 19:47:51 gx110 kernel: [  135.987226] =======================================================
> Nov  6 19:47:51 gx110 kernel: [  135.987250] [ INFO: possible circular locking dependency detected ]
> Nov  6 19:47:51 gx110 kernel: [  135.987261] 2.6.19-rc4-noinitrd #2
> Nov  6 19:47:51 gx110 kernel: [  135.987268] -------------------------------------------------------
> Nov  6 19:47:51 gx110 kernel: [  135.987278] kdm/3244 is trying to acquire lock:
> Nov  6 19:47:51 gx110 kernel: [  135.987288]  (&inode->i_mutex){--..}, at: [<c035aced>] mutex_lock+0x1c/0x1f
> Nov  6 19:47:51 gx110 kernel: [  135.987324]
> Nov  6 19:47:51 gx110 kernel: [  135.987326] but task is already holding lock:
> Nov  6 19:47:51 gx110 kernel: [  135.987334]  (&REISERFS_SB(s)->xattr_dir_sem){----}, at: [<c01c398e>] reiserfs_acl_chmod+0x116/0x180
> Nov  6 19:47:51 gx110 kernel: [  135.987374]
> Nov  6 19:47:51 gx110 kernel: [  135.987376] which lock already depends on the new lock.
> Nov  6 19:47:51 gx110 kernel: [  135.987380]
> Nov  6 19:47:51 gx110 kernel: [  135.987389]
> Nov  6 19:47:51 gx110 kernel: [  135.987391] the existing dependency chain (in reverse order) is:
> Nov  6 19:47:51 gx110 kernel: [  135.987400]
> Nov  6 19:47:51 gx110 kernel: [  135.987402] -> #2 (&REISERFS_SB(s)->xattr_dir_sem){----}:
> Nov  6 19:47:51 gx110 kernel: [  135.987417]        [<c012fcb7>] add_lock_to_list+0x62/0x7e
> Nov  6 19:47:51 gx110 kernel: [  135.987446]        [<c0130577>] __lock_acquire+0x8a4/0x99c
> Nov  6 19:47:51 gx110 kernel: [  135.987467]        [<c0130930>] lock_acquire+0x5b/0x7b
> Nov  6 19:47:51 gx110 kernel: [  135.987487]        [<c012c8c5>] down_read+0x3a/0x4b
> Nov  6 19:47:51 gx110 kernel: [  135.987526]        [<c01c381c>] reiserfs_cache_default_acl+0x43/0x9f
> Nov  6 19:47:51 gx110 kernel: [  135.987548]        [<c01a2824>] reiserfs_create+0x68/0x1e3
> Nov  6 19:47:51 gx110 kernel: [  135.987573]        [<c016a559>] vfs_create+0xd1/0x149
> Nov  6 19:47:51 gx110 kernel: [  135.987669]        [<c016a738>] open_namei+0x167/0x57f
> Nov  6 19:47:51 gx110 kernel: [  135.987696]        [<c0160ba4>] do_filp_open+0x26/0x3b
> Nov  6 19:47:51 gx110 kernel: [  135.987727]        [<c0160cc3>] do_sys_open+0x43/0xc2
> Nov  6 19:47:51 gx110 kernel: [  135.987754]        [<c0160d79>] sys_open+0x1a/0x1c
> Nov  6 19:47:51 gx110 kernel: [  135.987780]        [<c0102dfd>] sysenter_past_esp+0x56/0x8d
> Nov  6 19:47:51 gx110 kernel: [  135.987812]        [<ffffffff>] 0xffffffff
> Nov  6 19:47:51 gx110 kernel: [  135.987863]
> Nov  6 19:47:51 gx110 kernel: [  135.987865] -> #1 (&REISERFS_I(inode)->xattr_sem){----}:
> Nov  6 19:47:51 gx110 kernel: [  135.987893]        [<c012fcb7>] add_lock_to_list+0x62/0x7e
> Nov  6 19:47:51 gx110 kernel: [  135.987921]        [<c0130577>] __lock_acquire+0x8a4/0x99c
> Nov  6 19:47:51 gx110 kernel: [  135.987948]        [<c0130930>] lock_acquire+0x5b/0x7b
> Nov  6 19:47:51 gx110 kernel: [  135.987975]        [<c012c8c5>] down_read+0x3a/0x4b
> Nov  6 19:47:51 gx110 kernel: [  135.988003]        [<c01c3806>] reiserfs_cache_default_acl+0x2d/0x9f
> Nov  6 19:47:51 gx110 kernel: [  135.988032]        [<c01a2824>] reiserfs_create+0x68/0x1e3
> Nov  6 19:47:51 gx110 kernel: [  135.988059]        [<c016a559>] vfs_create+0xd1/0x149
> Nov  6 19:47:51 gx110 kernel: [  135.988086]        [<c016a738>] open_namei+0x167/0x57f
> Nov  6 19:47:51 gx110 kernel: [  135.988113]        [<c0160ba4>] do_filp_open+0x26/0x3b
> Nov  6 19:47:51 gx110 kernel: [  135.988140]        [<c0160cc3>] do_sys_open+0x43/0xc2
> Nov  6 19:47:51 gx110 kernel: [  135.988167]        [<c0160d79>] sys_open+0x1a/0x1c
> Nov  6 19:47:51 gx110 kernel: [  135.988193]        [<c0102dfd>] sysenter_past_esp+0x56/0x8d
> Nov  6 19:47:51 gx110 kernel: [  135.988220]        [<ffffffff>] 0xffffffff
> Nov  6 19:47:51 gx110 kernel: [  135.988307]
> Nov  6 19:47:51 gx110 kernel: [  135.988309] -> #0 (&inode->i_mutex){--..}:
> Nov  6 19:47:51 gx110 kernel: [  135.988336]        [<c012fc1f>] print_circular_bug_tail+0x30/0x66
> Nov  6 19:47:51 gx110 kernel: [  135.988364]        [<c0130476>] __lock_acquire+0x7a3/0x99c
> Nov  6 19:47:51 gx110 kernel: [  135.988392]        [<c0130930>] lock_acquire+0x5b/0x7b
> Nov  6 19:47:51 gx110 kernel: [  135.988419]        [<c035ab5d>] __mutex_lock_slowpath+0xc6/0x23a
> Nov  6 19:47:51 gx110 kernel: [  135.988448]        [<c035aced>] mutex_lock+0x1c/0x1f
> Nov  6 19:47:52 gx110 kernel: [  135.988474]        [<c01c29cd>] reiserfs_xattr_set+0xe4/0x2bf
> Nov  6 19:47:52 gx110 kernel: [  135.988503]        [<c01c33f7>] reiserfs_set_acl+0x18d/0x204
> Nov  6 19:47:52 gx110 kernel: [  135.988532]        [<c01c399c>] reiserfs_acl_chmod+0x124/0x180
> Nov  6 19:47:52 gx110 kernel: [  135.988561]        [<c01a3c49>] reiserfs_setattr+0x20b/0x243
> Nov  6 19:47:52 gx110 kernel: [  135.988590]        [<c0173963>] notify_change+0x135/0x2c2
> Nov  6 19:47:52 gx110 kernel: [  135.988631]        [<c015fbbf>] sys_fchmodat+0xa5/0xcf
> Nov  6 19:47:52 gx110 kernel: [  135.988658]        [<c015fc0a>] sys_chmod+0x21/0x23
> Nov  6 19:47:52 gx110 kernel: [  135.988684]        [<c0102dfd>] sysenter_past_esp+0x56/0x8d
> Nov  6 19:47:52 gx110 kernel: [  135.988712]        [<ffffffff>] 0xffffffff
> Nov  6 19:47:52 gx110 kernel: [  135.988739]
> Nov  6 19:47:52 gx110 kernel: [  135.988741] other info that might help us debug this:
> Nov  6 19:47:52 gx110 kernel: [  135.988745]
> Nov  6 19:47:52 gx110 kernel: [  135.988776] 3 locks held by kdm/3244:
> Nov  6 19:47:52 gx110 kernel: [  135.988790]  #0:  (&inode->i_mutex/1){--..}, at: [<c015fb8b>] sys_fchmodat+0x71/0xcf
> Nov  6 19:47:52 gx110 kernel: [  135.988819]  #1:  (&REISERFS_I(inode)->xattr_sem){----}, at: [<c01c3959>] reiserfs_acl_chmod+0xe1/0x180
> Nov  6 19:47:52 gx110 kernel: [  135.988849]  #2:  (&REISERFS_SB(s)->xattr_dir_sem){----}, at: [<c01c398e>] reiserfs_acl_chmod+0x116/0x180
> Nov  6 19:47:52 gx110 kernel: [  135.988879]
> Nov  6 19:47:52 gx110 kernel: [  135.988881] stack backtrace:
> Nov  6 19:47:52 gx110 kernel: [  135.988908]  [<c0103dc4>] dump_trace+0x64/0x1cc
> Nov  6 19:47:52 gx110 kernel: [  135.988936]  [<c0103f45>] show_trace_log_lvl+0x19/0x2e
> Nov  6 19:47:52 gx110 kernel: [  135.988960]  [<c01042a2>] show_trace+0x12/0x14
> Nov  6 19:47:52 gx110 kernel: [  135.988983]  [<c01042bb>] dump_stack+0x17/0x19
> Nov  6 19:47:52 gx110 kernel: [  135.989006]  [<c012fc4c>] print_circular_bug_tail+0x5d/0x66
> Nov  6 19:47:52 gx110 kernel: [  135.989029]  [<c0130476>] __lock_acquire+0x7a3/0x99c
> Nov  6 19:47:52 gx110 kernel: [  135.989052]  [<c0130930>] lock_acquire+0x5b/0x7b
> Nov  6 19:47:52 gx110 kernel: [  135.989074]  [<c035ab5d>] __mutex_lock_slowpath+0xc6/0x23a
> Nov  6 19:47:52 gx110 kernel: [  135.989097]  [<c035aced>] mutex_lock+0x1c/0x1f
> Nov  6 19:47:52 gx110 kernel: [  135.989119]  [<c01c29cd>] reiserfs_xattr_set+0xe4/0x2bf
> Nov  6 19:47:52 gx110 kernel: [  135.989143]  [<c01c33f7>] reiserfs_set_acl+0x18d/0x204
> Nov  6 19:47:52 gx110 kernel: [  135.989167]  [<c01c399c>] reiserfs_acl_chmod+0x124/0x180
> Nov  6 19:47:52 gx110 kernel: [  135.989190]  [<c01a3c49>] reiserfs_setattr+0x20b/0x243
> Nov  6 19:47:52 gx110 kernel: [  135.989214]  [<c0173963>] notify_change+0x135/0x2c2
> Nov  6 19:47:52 gx110 kernel: [  135.989237]  [<c015fbbf>] sys_fchmodat+0xa5/0xcf
> Nov  6 19:47:52 gx110 kernel: [  135.989259]  [<c015fc0a>] sys_chmod+0x21/0x23
> Nov  6 19:47:52 gx110 kernel: [  135.989280]  [<c0102dfd>] sysenter_past_esp+0x56/0x8d
> Nov  6 19:47:52 gx110 kernel: [  135.989306] DWARF2 unwinder stuck at sysenter_past_esp+0x56/0x8d
> Nov  6 19:47:52 gx110 kernel: [  135.989322]
> Nov  6 19:47:52 gx110 kernel: [  135.989334] Leftover inexact backtrace:
> Nov  6 19:47:52 gx110 kernel: [  135.989338]
> Nov  6 19:47:52 gx110 kernel: [  135.989359]  =======================
>
> Thanks
> Tilman
>
>   
This looks like a different problem which got revealed after my patch 
got applied. Please test below patch and let me know your comments.
Signed-off-by: Srinivasa DS <srinivasa@in.ibm.com>


--------------080406070105020904060508
Content-Type: text/plain;
 name="reiserfs.fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reiserfs.fix"

 open.c           |    2 +-
 reiserfs/xattr.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.19-rc4/fs/open.c
===================================================================
--- linux-2.6.19-rc4.orig/fs/open.c	2006-10-31 09:07:36.000000000 +0530
+++ linux-2.6.19-rc4/fs/open.c	2006-11-06 14:28:19.000000000 +0530
@@ -549,7 +549,7 @@
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
 		goto dput_and_out;
 
-	mutex_lock(&inode->i_mutex);
+	mutex_lock_nested(&inode->i_mutex, I_MUTEX_PARENT);
 	if (mode == (mode_t) -1)
 		mode = inode->i_mode;
 	newattrs.ia_mode = (mode & S_IALLUGO) | (inode->i_mode & ~S_IALLUGO);
Index: linux-2.6.19-rc4/fs/reiserfs/xattr.c
===================================================================
--- linux-2.6.19-rc4.orig/fs/reiserfs/xattr.c	2006-10-31 09:07:36.000000000 +0530
+++ linux-2.6.19-rc4/fs/reiserfs/xattr.c	2006-11-07 17:51:30.000000000 +0530
@@ -526,7 +526,7 @@
 	/* Resize it so we're ok to write there */
 	newattrs.ia_size = buffer_size;
 	newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME;
-	mutex_lock(&xinode->i_mutex);
+	mutex_lock_nested(&xinode->i_mutex, I_MUTEX_CHILD);
 	err = notify_change(fp->f_dentry, &newattrs);
 	if (err)
 		goto out_filp;

--------------080406070105020904060508--
