Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318972AbSHSS2q>; Mon, 19 Aug 2002 14:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318973AbSHSS2q>; Mon, 19 Aug 2002 14:28:46 -0400
Received: from ext-ch1gw-3.online-age.net ([216.34.191.37]:21233 "EHLO
	ext-ch1gw-3.online-age.net") by vger.kernel.org with ESMTP
	id <S318972AbSHSS2p>; Mon, 19 Aug 2002 14:28:45 -0400
Message-ID: <A9713061F01AD411B0F700D0B746CA6802FC1463@vacho6misge.cho.ge.com>
From: "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>
To: "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Cc: "'andre@linux-ide.org'" <andre@linux-ide.org>,
       "Warner, Bill (IndSys, GEFanuc, VMIC)" <Bill.Warner@gefanuc.com>
Subject: IDE-flash device and hard disk on same controller 
Date: Mon, 19 Aug 2002 14:31:53 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The IDE driver, file ide-probe.c currently contains this test do prevent
hard drives and IDE-flash devices (ex CompactFlash) from co-existing on the
same IDE controller. 

        /*
         * Prevent long system lockup probing later for non-existant
         * slave drive if the hwif is actually a flash memory card of some
variety:
         */
        if (drive_is_flashcard(drive)) {
                ide_drive_t *mate =
&HWIF(drive)->drives[1^drive->select.b.unit];
                if (!mate->ata_flash) {
                        mate->present = 0;
                        mate->noprobe = 1;
                }
        }

This test's assumption that a spinning hard drive cannot coexist on the same
controller as an IDE-flash device is incorrect.  I have a working setup with
such a configuration.  I don't think that the IDE subsystem should punish
everyone because _some_ hardware cannot tolerate this configuration.

One solution may be to remove this test from the IDE subsystem and force
users with buggy hardware to explicitly  disable probing for a second
device.  I think the parameters hdx=none or hdx=noprobe should work for
them.

Comments??


