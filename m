Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266887AbUHRA75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266887AbUHRA75 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 20:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268535AbUHRA75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 20:59:57 -0400
Received: from smtp.terra.es ([213.4.129.129]:8387 "EHLO tsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id S266887AbUHRA7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 20:59:52 -0400
Date: Wed, 18 Aug 2004 02:59:51 +0200
From: Diego Calleja <diegocg@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: [RFC] ext3 documentation (lack of)
Message-Id: <20040818025951.63c4134e.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lots of people think that ext3 is very slow. While I'm not claiming that ext3
is the fatest fs in the world, I told some people to look at 
Documentation/filesystem/ext3.txt and try to tweak it before doing some
benchmarks. To my surprise, several ext3 mount options were not documented
(not even in the source) except in some sites spread across the internet, so
it's not a surprise that lots of people ignores some mount options when doing
benchmarks, like the commit interval.

This documents commit (or it tries, sorry for my english), groups the
journal-related options in the same place of the document and adds other
mount options without documenting them (like the ones related to acl, xattr,
resizing, reservations, barriers). Hopefully people will explain those better
than me.

--- stable/Documentation/filesystems/ext3.txt-documentsync	2004-08-18 01:55:48.000000000 +0200
+++ stable/Documentation/filesystems/ext3.txt	2004-08-18 02:54:00.000000000 +0200
@@ -22,6 +22,52 @@
 			the inode which will represent the ext3 file
 			system's journal file.
 
+noload			Don't load the journal on mounting.
+
+data=journal		All data are committed into the journal prior 
+			to being written into the main file system.
+
+data=ordered	(*)	All data are forced directly out to the main file
+			system prior to its metadata being committed to
+			the journal.
+
+data=writeback		Data ordering is not preserved, data may be 
+			written into the main file system after its
+			metadata has been committed to the journal.
+
+commit=nrsec	(*)	Ext3 can be told to write all its data and metadata
+			every 'nrsec' seconds. The default value is 5 seconds.
+			This means that if you lose your power, you will lose,
+			as much, the latest 5 seconds of work. This default
+			value (or any low value) will hurt performance, but
+			it's good for data-safety. Setting it to 0 disables it.
+			Disabling it or setting it to very large values will
+			improve performance, 
+
+barrier=??	(*)??	This enables/disables the "journal barrier"
+
+orlov		(*)	This enables the new Orlov block allocator. It's enabled
+			by default. 
+
+oldalloc		This disables the Orlov block allocator and enables the
+			old block allocator. Orlov should have better performance,
+			we'd like to get some feedback if it's the contrary for
+			you.
+
+user_xattr=
+
+nouser_xattr=
+
+acl=
+
+noacl=
+
+reservation=
+
+noreservation=
+
+resize=
+
 bsddf 		(*)	Make 'df' act like BSD.
 minixdf			Make 'df' act like Minix.
 
@@ -30,8 +76,6 @@
 
 debug			Extra debugging information is sent to syslog.
 
-noload			Don't load the journal on mounting.
-
 errors=remount-ro(*)	Remount the filesystem read-only on an error.
 errors=continue		Keep going on a filesystem error.
 errors=panic		Panic and halt the machine if an error occurs.
@@ -48,17 +92,6 @@
 
 sb=n			Use alternate superblock at this location.
 
-data=journal		All data are committed into the journal prior 
-			to being written into the main file system.
-		
-data=ordered	(*)	All data are forced directly out to the main file 
-			system prior to its metadata being committed to 
-			the journal.
-		
-data=writeback  	Data ordering is not preserved, data may be 
-			written into the main file system after its
-			metadata has been committed to the journal.
-
 quota			Quota options are currently silently ignored.
 noquota			(see fs/ext3/super.c, line 594)
 grpquota
