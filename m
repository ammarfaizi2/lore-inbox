Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWBLH5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWBLH5P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 02:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWBLH5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 02:57:15 -0500
Received: from mail.polishnetwork.com ([69.222.0.23]:4362 "EHLO usfltd.com")
	by vger.kernel.org with ESMTP id S932327AbWBLH5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 02:57:14 -0500
Date: Sun, 12 Feb 2006 01:56:52 -0600
Message-Id: <200602120156.AA112460246@usfltd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "art" <art@usfltd.com>
Reply-To: <art@usfltd.com>
To: <linux-kernel@vger.kernel.org>
CC: <jeffm@suse.com>
Subject: Re: kernel-2.6.16-rc2-git8 - reiserfs - write problem !!!
X-Mailer: <IMail v8.05>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FROM:   	   	
Jeffrey Mahoney <jeffm@suse.com> | Save Address
DATE: 	  	Sat, 11 Feb 2006 16:58:20 -0500
TO: 	  	<art@usfltd.com>  
SUBJECT: 	  	Re: kernel-2.6.16-rc2-git8 - reiserfs 3.6 - write problem !!!
  	
  	art wrote:
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
>
> up to 2.6.16-rc1-git6 it works OK

Can you post the output of 'lsattr <dir>' where you get permission
denied? Also, please include any relevant dmesg output as well.

-Jeff
------------------------------------

mount /dev/hda1 /mnt/mountpoint-reiserfs
mount /dev/sdb1 /mnt/mountpoint-ext3

kernel-2.6.16-rc1-git6     OK

[bebe@localhost ~]$ cd /mnt
[bebe@localhost mnt]$ lsattr
------------- ./mountpoint-ext3
lsattr: Inappropriate ioctl for device While reading flags on ./mountpoint-reiserfs
[bebe@localhost mnt]$

[bebe@localhost mnt]$ cd  mountpoint-reiserfs
[bebe@localhost mountpoint-reiserfs]$ lsattr
lsattr: Inappropriate ioctl for device While reading flags on ./v
lsattr: Inappropriate ioctl for device While reading flags on ./tmp

[bebe@localhost mountpoint-reiserfs]$

kernel-2.6.16-rc1-git6     OK

-----------------------------------

kernel-2.6.16-rc2-git9     BAD

[bebe@localhost ~]$ cd /mnt
[bebe@localhost mnt]$ lsattr
------------- ./mountpoint-ext3
su---ad-cjI-- ./mountpoint-reiserfs

[bebe@localhost mnt]$ cd mountpoint-reiserfs
[bebe@localhost mountpoint-reiserfs]$ lsattr
s-S-i-dAc--t- ./v
s-S-i-dAc--t- ./tmp

kernel-2.6.16-rc2-git9     BAD

looks like system automaticly sets attribs mounting reiserfs

"A file with the `i' attribute cannot be modified: it cannot be deleted or renamed, no link can be created to this file and no data can be written to the file. Only the superuser or a process possessing the CAP_LINUX_IMMUTABLE capability can set or clear this attribute."

"A file with the `a' attribute set can only be open in append mode for writing. Only the superuser or a process possessing the CAP_LINUX_IMMUTABLE capability can set or clear this attribute."

xboom

