Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbUJYOjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbUJYOjZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 10:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbUJYOjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 10:39:24 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:37032 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261395AbUJYOik convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:38:40 -0400
Cc: raven@themaw.net
Subject: [PATCH 0/28] Autofs NG Patchset 0.2
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:38:29 -0400
Message-Id: <10987151092039@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The following patchset (against 2.6.9) is a breakdown of all the changes
required to support autofng (currently hosted at http://autofsng.bkbits.net/).
I'm posting this patchset to get more people's eyes on the code.

The series consists of core vfs changes as well as a couple small changes to
the call_usermodehelper interface.  I've also sent the autofsng filesystem as a single patch to introduce it seperated from the rest of the changes.

This isn't ready for inclusion as there are bound to be errors and the
interfaces described haven't settled.

Please review / test / comment / flame.



01-unexport_umount_tree.diff
 - drop an export with no intree users

02-rename_mnt_fslink_mnt_expire.diff
 - give vfsmount->mnt_fslink a more appropriate name

03-move_expiry_into_vfs.diff
 - pull expiry stuff that was recently added to be contained within vfs

04-stat_on_root_shouldnt_stop_expire.diff
 - don't let ops on the root of a mountpoint affect expiry timeouts

05-expiry_is_countdown.diff
 - mountpoint expiry now has configurable timeouts

06-expiry_is_recursive.diff
 - allow for atomic expiry of subtrees of mountpoints

07-update_kafs_automount_expiry.diff
 - update AFS to use new expiry interface

08-drop_expire_umount_flag.diff
 - drop unused old expiry interface (MNT_EXPIRE flag to umount(2))

09-expiry_semantics_bind.diff
 - fix up the expiry semantics and document them

10-move_next_mnt.diff
 - move next_mnt() in preparation for later patches

11-detachable_subtrees.diff
 - allow subtrees of mountpoints to not be bound to a struct namespace

12-remove_check_mnt.diff
 - remove the now bogus check_mnt calls (bogus with detachable_subtree.diff)

13-introduce_soft_ref_counts.diff
 - introduce 'soft' reference counts that don't affect umount(2) == EBUSY
   semantics

14-introduce_mountfd.diff
 - introduce the mountfd() syscall

15-mountfd_umounts.diff
 - add unmount functionality to mountfd interface

16-mountfd_attach.diff
 - add attach interface to mountfd interface

17-mountfd_walk.diff
 - allow for userspace to walk a tree of mountfds

18-mountfd_read.diff
 - allow for reading properties of a mountfd

19-mountfd_vfsexpire.diff
 - give vfs expiry an interface through mountfds

20-call_usermodehelper_cb.diff
 - add a way to have a caller of call_usermodehelper get a callback before
   execvce.

21-call_usermodehelper_execve_hack.diff
 - quick hack that allows for execve to be called without having to define
   errno.

22-export_put_namespace.diff
 - autofsng wants to call put_namespace.  export it.

23-export_get_sb_pseudo.diff
 - autofsng wants get_sb_pseudo.

24-follow_link_on_root.diff
 - update follow_link logic to pass the right vfsmount to follow_link on root
   directory.

25-statfs_nofollow.diff
 - hack - statfs doesn't follow symlink on last component.

26-umount_mnt_nofollow.diff
 - allow umount to not follow symlink on last component.

27-temp_expiry_syscall.diff
 - dummy interface to expiry testing

28-autofsng_support.diff
 - big patch for autofsng.

