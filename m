Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbTAQWGR>; Fri, 17 Jan 2003 17:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261686AbTAQWGQ>; Fri, 17 Jan 2003 17:06:16 -0500
Received: from ausadmmsrr503.aus.amer.dell.com ([143.166.83.90]:10244 "HELO
	AUSADMMSRR503.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S261660AbTAQWGP>; Fri, 17 Jan 2003 17:06:15 -0500
X-Server-Uuid: 91331657-2068-4fb8-8b09-a4fcbc1ed29f
Message-ID: <20BF5713E14D5B48AA289F72BD372D68011A4264@AUSXMPC122.aus.amer.dell.com>
From: Gary_Lerhaupt@Dell.com
To: linux-kernel@vger.kernel.org
Subject: Devlabel: static device naming via symlinks (improved)
Date: Fri, 17 Jan 2003 16:15:08 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 12365FE7138022-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've added a couple useful features to devlabel (available at
http://domsch.com/linux/devlabel).  Of the foremost of these is that it now
includes the usage of Partition UUIDs (as provided by ext2, ext3, xfs, jfs
or ocfs).  Since these UUIDs are partition specific, if a partition-level
failure event occurs (eg. you delete /dev/sde6 and /dev/sde7 then becomes
/dev/sde6), devlabel is now smart enough to handle it for the aforementioned
filesystem types.  If you aren't using one of these filesystem types or if
there is no filesystem at all, devlabel will then fall back on using SCSI
UUIDs or IDE identifiers as it used before (these support disk-wide
failures, when /dev/sdb6 becomes /dev/sda6).

As well, devlabel now also supports automounting.  For example, with a USB
flash reader, you should now add it to devlabel with the --automount option.
If --automount is specified, every time you hotplug your device, it will
check /etc/fstab for an entry containing the symlink that you've added for
this device, and if it finds one, it will automatically mount it.  Nice and
simple.

Lastly, you can also now do adds by UUID.  This is especially helpful in
shared storage environments.  For example, you can add a symlink on the
master node and then add by UUID on all the secondary nodes to ensure that
the same symlink on all nodes points to the same shared storage device
regardless of the device naming scheme of those nodes.

Gary Lerhaupt
Linux Development
Dell Computer Corporation

