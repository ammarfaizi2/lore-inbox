Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129830AbRB0UCm>; Tue, 27 Feb 2001 15:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129814AbRB0UCd>; Tue, 27 Feb 2001 15:02:33 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:39114 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S129819AbRB0UCO>; Tue, 27 Feb 2001 15:02:14 -0500
To: linux-kernel@vger.kernel.org
Subject: Disk change messages
X-URL: http://www.fi.muni.cz/~pekon/
From: Petr Konecny <pekon@informatics.muni.cz>
Date: 27 Feb 2001 21:02:08 +0100
Message-ID: <qwwvgpvdhdr.fsf@decibel.fi.muni.cz>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Persephone)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been trying to use vold to automount CDs. The daemon tries to open
/dev/cdrom and if it succeeds it examines the media and mounts it under
/cdrom/volume_name.

The problem is that when there is no disk in the drive the following
message:
  VFS: Disk change detected on device ide1(22,0)
is written to system log during each open call.  Vold calls open every 5
seconds, so it's 17280 lines in log/day. I have been able to avoid these
messages by commenting out a line in drivers/ide/ide-cd.c (patch
included) and have not seen any problems yet.

I guess I have three questions:
 1. can this patch break things ? I suppose it could happen only
    if cdrom_saw_media_change was not called when the CD is changed.
 2. is it possible to avoid the message by modifying vold ? E.g. finding
    out that there is no media in the drive without calling open.
 3. is there a clean way to avoid these repeated messages ?

                                                Thanks, Petr

--- ide-cd.c    2001/02/22 22:30:02     1.1.1.11
+++ ide-cd.c    2001/02/27 19:51:58
@@ -601,7 +601,7 @@

                /* Check for tray open. */
                if (sense_key == NOT_READY) {
-                       cdrom_saw_media_change (drive);
+/*                     cdrom_saw_media_change (drive); */
                } else if (sense_key == UNIT_ATTENTION) {
                        /* Check for media change. */
                        cdrom_saw_media_change (drive);

