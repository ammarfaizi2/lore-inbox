Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVABMeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVABMeS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 07:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVABMeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 07:34:18 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:18123 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S261214AbVABMeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 07:34:13 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: the umount() saga for regular linux desktop users
To: Andy Lutomirski <luto@myrealbox.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sun, 02 Jan 2005 13:38:29 +0100
References: <fa.iji5lco.m6nrs@ifi.uio.no> <fa.fv0gsro.143iuho@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1Cl509-0000TI-00@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski wrote:

> I have this complaint too, and MNT_DETACH doesn't really do it.
> Sometimes I want to "unmount cleanly, damnit, and I don't care if
> applications that are currently accessing it lose data."  Windows can do
> this, and it's _useful_.

I have an additional feature request: The umount -l will currently not work
for unmounting the cwd of something like the midnight commander without
closing it. On the other hand, rmdiring the cwd of running application
works just fine.

Maybe it's possible to extend the semantics of umount -l to change all
cwds under that mountpoint to be deleted directories which will no
longer cause the mountpoint to be busy (e.g. by redirecting them to a
special inode on initramfs). Most applications can cope with that (if
not, they're buggy), and it will do 90% of the usural cases while still
avoiding data loss.



Pseudocode:

on boot:
mkdir("/deleteddirectory");
deleted_dir_fd=open("/deleteddirectory");
rmdir("/deleteddirectory");

on umount -l:
if mountpoints - mountpoints_in_lazy_unmount_state == 0
then for each process
do if process->cwd->device == umount_device
then process->fchdir(deleted_dir_fd)

