Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263002AbSJBIvq>; Wed, 2 Oct 2002 04:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263003AbSJBIvq>; Wed, 2 Oct 2002 04:51:46 -0400
Received: from zamok.crans.org ([138.231.136.6]:23972 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id <S263002AbSJBIvo>;
	Wed, 2 Oct 2002 04:51:44 -0400
Date: Wed, 2 Oct 2002 10:57:13 +0200
To: linux-kernel@vger.kernel.org
Subject: Ext3 documentation
Message-ID: <20021002085713.GA23086@darwin.crans.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Email may contain unsmilyfied humor and/or satire.
From: Vincent Hanquez <tab@tuxfamily.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Hi Mailing List,

Here a (small) documentation for ext3 filesystem.
it seem now correct/accurate. report me any problem/bugs

It can be merge in 2.4/2.5 kernel I think. feedback appreciated.

-- 
Vincent Hanquez

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ext3.txt"


Ext3 Filesystem
===============

ext3 was originally released in September 1999. Written by Stephen Tweedie
for 2.2 branch, and ported to 2.4 kernels by Peter Braam, Andreas Dilger, 
Andrew Morton, Alexander Viro, Ted Ts'o and Stephen Tweedie.

ext3 is ext2 filesystem enhanced with journalling capabilities. 

Options
=======

When mounting an ext3 filesystem, the following option are accepted:
(*) == default

jounal=update		Update the ext3 file system's journal to the 
			current format.

journal=inum		When a journal already exists, this option is 
			ignored. Otherwise, it specifies the number of
			the inode which will represent the ext3 file
			system's journal file.

bsddf 		(*)	Make 'df' act like BSD.
minixdf			Make 'df' act like Minix.

check=none		Don't do extra checking of bitmaps on mount.
nocheck		

debug			Extra debugging information is sent to syslog.

noload			Don't load the journal on mounting.

errors=remount-ro(*)	Remount the filesystem read-only on an error.
errors=continue		Keep going on a filesystem error.
errors=panic		Panic and halt the machine if an error occurs.

grpid			Give objects the same group ID as their creator.
bsdgroups		

nogrpid		(*)	New objects have the group ID of their creator.
sysvgroups

resgid=n		The group ID which may use the reserved blocks.

resuid=n		The user ID which may use the reserved blocks.

sb=n			Use alternate superblock at this location.

data=journal		All data are commited into the journal prior 
			to being written into the main file system.
		
data=ordered	(*)	All data are forced directly out to the main file 
			system prior to its metadata being commited to 
			the journal.
		
data=writeback  	Data ordering is not preserved, data may be 
			written into the main file system after its
			metadata has been committed to the journal.

quota			Quota options are currently silently ignored.
noquota			(see fs/ext3/super.c, line 594)
grpquota
usrquota


Specification
=============
ext3 shares all disk implementation with ext2 filesystem, and add
transactions capabilities to ext2.
Journaling is done by the Journaling block device layer.

Journaling Block Device layer
-----------------------------
The Journaling Block Device layer (JBD) isn't ext3 specific. It was design
to add journaling capabilities on a block device.
The ext3 filesystem code will inform the JBD of modifications it is
performing (Call a transaction). the journal support the transactions start
and stop, and in case of crash, the journal can replayed the transactions
to put the partition on a consistant state fastly.

handles represent a single atomic update to a filesystem.
JBD can handle external journal on a block device.

Data Mode
---------
There's 3 different data modes:

* writeback mode
In data=writeback mode, ext3 doesn't do any form of data journaling at
all (as XFS, JFS, and ReiserFS).
Despite the fact it could corrupt recently modified file, this
mode should give you in general the best ext3 performance.

* ordered mode
In data=ordered mode, ext3 only officially journals metadata, but it
logically groups metadata and data blocks into a single unit called a
transaction. When it's time to write the new metadata out to disk, the
associated data blocks are written first.
In general, this mode perform slightly slower than writeback
but significantly faster than journal mode.

* journal mode
data=journal mode provides full data and metadata journaling. All new data
is written to the journal first, and then to its final location.
In the event of a crash, the journal can be replayed, bringing both data
and metadata into a consistent state.
This mode is the slowest except when data needs to be read from and
written to disk at the same time where it outperform all others mode.

Compatibility
-------------
Ext2 partition can be easily convert to ext3, with `tune2fs -j <dev>`.
Ext3 is fully compatible with Ext2. Ext3 partition can easily be mounted
as Ext2.

Quota
=====
Quota implementation for ext3 is available in -ac tree for 2.4.
There is no implementation for 2.5 yet.

External Tools
==============
see manual pages to know more.

tune2fs: 	create a ext3 journal on a ext2 partition with the -j flags
mke2fs: 	create a ext3 partition with the -j flags
debugfs: 	ext2 and ext3 file system debugger

References
==========

kernel source:	file:/usr/src/linux/fs/ext3
		file:/usr/src/linux/fs/jbd

programs: 	http://e2fsprogs.sourceforge.net

useful link:
		http://www.zip.com.au/~akpm/linux/ext3/ext3-usage.html
		http://www-106.ibm.com/developerworks/linux/library/l-fs7/
		http://www-106.ibm.com/developerworks/linux/library/l-fs8/

--pWyiEgJYm5f9v55/--
