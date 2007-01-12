Return-Path: <linux-kernel-owner+w=401wt.eu-S1751614AbXALFPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbXALFPE (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 00:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbXALFPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 00:15:04 -0500
Received: from mail.ggsys.net ([69.26.161.131]:56840 "EHLO mail.ggsys.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751614AbXALFPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 00:15:03 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jan 2007 00:15:03 EST
Subject: Ext3 mounted as ext2 but journal still in effect.
From: Alberto Alonso <alberto@ggsys.net>
To: linux-kernel@vger.kernel.org
Cc: Alberto Alonso <alberto@ggsys.net>
Content-Type: text/plain
Organization: Global Gate Systems LLC.
Date: Thu, 11 Jan 2007 23:08:16 -0600
Message-Id: <1168578496.9707.6.camel@w100>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an ext3 filesystem that has been having problems
with its journal. The result is that the file system
remounts internally as read-only and the server becomes
unusable, even shutdown does not work, using up 100% of
the CPU but not rebooting.

I found some postings indicating that mounting it as
ext2 should fix the problem, as it doesn't appear to be
a hardware issue.

So, I decided to mount everything as ext2. Mount shows this:

# mount
/dev/hda2 on / type ext2 (rw,usrquota)
none on /proc type proc (rw)
none on /sys type sysfs (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
usbfs on /proc/bus/usb type usbfs (rw)
/dev/hda1 on /boot type ext2 (rw)
none on /dev/shm type tmpfs (rw,noexec)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)

But now I still get the error:

# dmesg
[...]
EXT3-fs error (device hda2) in start_transaction: Journal has aborted
EXT3-fs error (device hda2) in start_transaction: Journal has aborted
EXT3-fs error (device hda2) in start_transaction: Journal has aborted
EXT3-fs error (device hda2) in start_transaction: Journal has aborted
[...]


The kernel is:

# uname -a
Linux hyperweb.net 2.6.5-1.358smp #1 SMP Sat May 8 09:25:36 EDT 2004
i686 i686 i386 GNU/Linux


Any ideas?

Thanks,

Alberto

-- 
Alberto Alonso                        Global Gate Systems LLC.
(512) 351-7233                        http://www.ggsys.net
Hardware, consulting, sysadmin, monitoring and remote backups

