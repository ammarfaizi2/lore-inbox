Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265817AbUHRLid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUHRLid (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 07:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUHRLid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 07:38:33 -0400
Received: from smtp.terra.es ([213.4.129.129]:54156 "EHLO tsmtp18.mail.isp")
	by vger.kernel.org with ESMTP id S265817AbUHRLi2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 07:38:28 -0400
Date: Wed, 18 Aug 2004 13:38:18 +0200
From: Diego Calleja <diegocg@teleline.es>
To: Ryan Cumming <ryan@spitfire.gotdns.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] ext3 documentation (lack of)
Message-Id: <20040818133818.7b0582f3.diegocg@teleline.es>
In-Reply-To: <200408172301.09350.ryan@spitfire.gotdns.org>
References: <20040818025951.63c4134e.diegocg@teleline.es>
	<200408172301.09350.ryan@spitfire.gotdns.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 17 Aug 2004 23:01:06 -0700 Ryan Cumming <ryan@spitfire.gotdns.org> escribió:

> Setting commit to zero doesn't seem to disable it, judging from my local 
> 2.6.8.1-mm1 source.


Ugh, sure, I just assumed it'd disable it. Anyway, here's a updated version.

(It'd be nice if people could provide a description for the rest so we can
recollect and submit them)

Diego Calleja

--- stable/Documentation/filesystems/ext3.txt-documentsync	2004-08-18 01:55:48.000000000 +0200
+++ stable/Documentation/filesystems/ext3.txt	2004-08-18 13:37:37.000000000 +0200
@@ -22,6 +22,54 @@
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
+commit=nrsec	(*)	Ext3 can be told to sync all its data and metadata
+			every 'nrsec' seconds. The default value is 5 seconds.
+			This means that if you lose your power, you will lose,
+			as much, the latest 5 seconds of work (your filesystem
+			will not be damaged though, thanks to journaling). This
+			default value (or any low value) will hurt performance,
+			but it's good for data-safety. Setting it to 0 will
+			have the same effect than leaving the default 5 sec.
+			Setting it to very large values will improve
+			performance.
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
 
@@ -30,8 +78,6 @@
 
 debug			Extra debugging information is sent to syslog.
 
-noload			Don't load the journal on mounting.
-
 errors=remount-ro(*)	Remount the filesystem read-only on an error.
 errors=continue		Keep going on a filesystem error.
 errors=panic		Panic and halt the machine if an error occurs.
@@ -48,17 +94,6 @@
 
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
