Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751707AbWBMNpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbWBMNpD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 08:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbWBMNpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 08:45:03 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:34716 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750938AbWBMNpA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 08:45:00 -0500
Subject: Re: kernel-2.6.16-rc2-git8 - reiserfs 3.6 - write problem !!!
From: Stephen Smalley <sds@tycho.nsa.gov>
To: art@usfltd.com
Cc: linux-kernel@vger.kernel.org, reiser@namesys.com
In-Reply-To: <200602101830.AA329122124@usfltd.com>
References: <200602101830.AA329122124@usfltd.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 13 Feb 2006 08:50:25 -0500
Message-Id: <1139838625.14253.19.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-10 at 18:30 -0600, art wrote:
> kernel-2.6.16-rc2-git8 - reiserfs - write problem !!!
> 
> it started ~from kernel-2.6.16-rc2
> 2.6.16-rc1-git6 works ok
> 
> with 2.6.16-rc2-git8
> --reiserfs is 3.6 on ide hdd mounted on /mnt on scsi-hdd with ext3 on it--
> mount
> /dev/hda1 on /mnt/mountpoint-reiserfs type reiserfs (rw)
> /dev/sdb1 on /mnt/mountpoint-ext3 type ext3 (rw)
> 
> [bebe@localhost mnt]$ ls -l -Z
> drwxr-xr-x root root system_u:object_r:file_t mountpoint-ext3
> drwxr-xr-x root root system_u:object_r:file_t mountpoint-reiserfs
> 
> [root@localhost mountpoint-ext3]# ls -Z
> drwxrwxrwx root root root:object_r:file_t abc
> drwxr-xr-x bebe bebe root:object_r:file_t def
> drwx------  root root system_u:object_r:file_t lost+found
> 
> [root@localhost mountpoint-reiserfs]# ls -Z
> drwxr-xr--  bebe bebe system_u:object_r:file_t abc
> drwxr-xr-x  root root system_u:object_r:file_t def
> 
> [bebe@localhost abc]$ su
> Password:
> [root@localhost abc]# ls >xxxxxx
> bash: xxxxxx: Permission denied
> [root@localhost abc]#
> 
> same in targeted and permissive mode in selinux

Not that it explains your problem in permissive mode, but note that
reiserfs and selinux aren't going to work together very well in
enforcing mode due to the atomic inode security labeling patches that
went into 2.6.14.  ext2, ext3, tmpfs, jfs, and (recently) xfs have been
converted to call the security_inode_init_security hook and set security
attributes for new inodes.

-- 
Stephen Smalley
National Security Agency

