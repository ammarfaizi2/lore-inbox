Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWBAHnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWBAHnE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 02:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbWBAHnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 02:43:04 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:52148 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751466AbWBAHnB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 02:43:01 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Chris Mason <mason@suse.com>
Subject: Re: Recursive chmod/chown OOM kills box with 32MB RAM
Date: Wed, 1 Feb 2006 09:42:36 +0200
User-Agent: KMail/1.8.2
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
References: <200601281613.16199.vda@ilport.com.ua> <43DDAE2D.6080300@namesys.com> <200601300822.47821.mason@suse.com>
In-Reply-To: <200601300822.47821.mason@suse.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602010942.36134.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 January 2006 15:22, Chris Mason wrote:
> You can shrink the log of an existing filesystem.  The minimum size is 513 
> blocks, you might try 1024 as a good starting poing.
> 
> reiserfstune -s 1024 /dev/xxxx
> 
> The filesystem must be unmounted first.

It doesn't want to, for no obvious reason:

# mount
rootfs on / type rootfs (rw)
/dev/root on / type ext2 (ro,nogrpid)
none on /proc type proc (rw,nodiratime)
none on /sys type sysfs (rw)
none on /dev type ramfs (rw)
/dev/sda2 on /.share type ext2 (rw,noatime,nogrpid)
/dev/sdb2 on /.1 type reiserfs (rw,noatime)
/dev/sdc2 on /.2 type reiserfs (rw,noatime)
/dev/sdc3 on /.3 type reiserfs (rw,noatime)
/dev/sda2 on /.local type ext2 (rw,noatime,nogrpid)
none on /dev/pts type devpts (rw)
automount(pid1043) on /.local/mnt/auto type autofs (rw)
# umount /.3
umount: /.3: device is busy
# mount -o ro,remount /.3
# umount /.3
umount: /.3: device is busy
# mount
rootfs on / type rootfs (rw)
/dev/root on / type ext2 (ro,nogrpid)
none on /proc type proc (rw,nodiratime)
none on /sys type sysfs (rw)
none on /dev type ramfs (rw)
/dev/sda2 on /.share type ext2 (rw,noatime,nogrpid)
/dev/sdb2 on /.1 type reiserfs (rw,noatime)
/dev/sdc2 on /.2 type reiserfs (rw,noatime)
/dev/sdc3 on /.3 type reiserfs (ro,noatime)
/dev/sda2 on /.local type ext2 (rw,noatime,nogrpid)
none on /dev/pts type devpts (rw)
automount(pid1043) on /.local/mnt/auto type autofs (rw)
# reiserfstune /dev/sdc3
reiserfstune: Reiserfstune is not allowed to be run on mounted filesystem.
# lsof -nP | grep -F '/.3'
# lsof -nP | grep -F '/dev/sdc'

--
vda
