Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbTJTQ2w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 12:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbTJTQ2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 12:28:52 -0400
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:62083
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S262507AbTJTQ2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 12:28:48 -0400
From: John Mock <kd6pag@qsl.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test8 on Sony VAIO R505EL and PowerMac 8500 (summary)
Message-Id: <E1ABctv-0002Jd-00@penngrove.fdns.net>
Date: Mon, 20 Oct 2003 09:28:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a summary of my experience with 2.6.0-test8 on a Sony VAIO R505EL
and PowerMac 8500.  Aside from problems with software-suspend/suspend-to-
disk, my biggest issue on the VAIO R505EL (i386) is that the display only 
seems to work cleanly at 1024x768x8 bits (or less).  It gets past that 
with X kludgery, but software suspend is definitely limited to 8 bit color.
Hopefully once these things get resolved, i won't be running Windows XP
much of the time.

PowerMac 8500 (PPC) has more serious problems, its console display is broken
and it currently cannot come up multi-user, making it difficult to examine 
the problem.  Eventually, i'll hook up a serial console and at least look 
at that problem.  Since 2.4.21 works fine for me, this isn't a major issue 
for me personally.  Given our winter power and summer heat, i wish software
suspend worked for the PPC...

Attached is a summary of the current issues for me, please write if you
would like additional details on any of these, especially those not yet
reported on.
			         -- JM

P.S.  If you respond to anything below, you might want to change the Subject
line so people don't have to follow multiple bugs in this thread.

-------------------------------------------------------------------------------
Outstanding issues for Sony VAIO R505EL

  ohci1394/sbp2 fails after 'modprobe ohci1394' with slab corruption (on
	test7-bk3).  Bug report filed.  Partial fix available (which still
        loses on 'rmmod sbp' or 'rmmod ohci1394').

  'modprobe parport_pc' allocates IO ports 378-37a, 37b-37f but
	'rmmod parport_pc' fails to release 37b-37f.  Bug report filed 
	and patch suggested.

  Inserting infrared card served by 'serial_cs' allocates IO ports 2f8-2ff but
	on ejection, claims it's trying to free non-existent resource 2f8-2ff
	(maybe it's trying to free it twice?).  Appears to be benign, details
	upon request.

  Software suspend (old flavor) does seem to work under limited circumstances
	but might be described as being somewhat fragile.

  Getting started with new flavor of suspend-to-disk was difficult, i couldn't
	find where documention on mounting /sys.  My /etc/fstab now has:
	"/dev/zero	/sys		sysfs	defaults".  Seems kludgey and
	not well documented.

  suspend-to-disk (both flavors) seems not to check for valid swap partition 
	before attempting to suspend. (And then even 'sysrq-S/sysrq-U' won't
	avoid an 'fsck').

  suspend-to-disk (new flavor) does nothing meaningful for 'standby' except
	that it blinks the screen very briefly.  Provided details to existing 
	bug report.

  suspend-to-disk with 'mem'/S3 (e.g. both flavors) puts machine goes into
	a coma, which requires a hard reset to revive.

  New flavor of suspend-to-disk with 'echo -n disk > /sys/power/state' stops
	OK, but goes into a coma when the 'power' button is pressed.  After
	a hard reset, 'power' button then resumes normally.

  suspend-to-disk works for X server utilizing 'vesafb', but double-faults
	and reboots upon resuming if i run X in native mode (drm/i830).  
	Thus i'm stuck with 256 colors if i'm running on battery power 
	(e.g. may need to suspend).  Other(s) have already filed reports 
	on this, so supplied additional comments/information.

  'vesafb' only works at depth 8 (except for 640x480 works at depth 16).  It
	can work at higher depths with X, but that uses kludges beyond the
	scope of this mailing list.

  'uhci-hcd' gets confused after suspend-to-disk.  Attempting to 'rmmod' it
	after suspending gets an oops.  Workaround is to 'rmmod uhci-hcd' 
	in the hibernate script, and i also have a private patch which may
	fix this (more testing needed). Bug report filed on this.

  New flavor of suspend-to-disk under 'test7-bk7' would sometimes get 
	backtraces going to sleep, but they most seem to be harmless.
	Not yet checked yet under -test8.

Outstanding issues for PowerMac 8500

  'drivers/block/swim3.c' won't compile, seems to be missing a couple of
	#includes's (and still gets a couple of warnings).  Bug report filed,
	temporary patch suggested.

  Many other modules get compilation warnings.  Bug report filed.

  PPC gets one 'oops' per SCSI disk during boot up.  Bug report filed.

  Contrary to earlier reports, RAID5 seems to work fine on PPC (on -test7 at
	least).

  Console comes up in an unusable video mode, specifically, sync is good, but
	it appears to have wrong number of bits per scanline.

  X eventually resets it to good video mode on test7-bk7, but X doesn't work
	with an ADB keyboard (and it even doesn't get that far under -test8)

  Currently can only test over network (and as noted, test7-bk7 was last
	kernel i tried that even got that far.

  May no longer fit on floppy, somewhat dangerous given i can't boot from CD
	(not even MacOS) and have RAID5 root/usr.

===============================================================================
