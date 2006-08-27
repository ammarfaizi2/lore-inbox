Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWH0Vuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWH0Vuf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 17:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWH0Vuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 17:50:35 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:63198 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S932300AbWH0Vue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 17:50:34 -0400
Date: Sun, 27 Aug 2006 23:50:32 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Updated libata acpi patches for GIT HEAD
Message-ID: <20060827215032.GG8271@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Randy Dunlap <randy_d_dunlap@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@mellanox.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11-2006-07-11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Randy,
I have a T60 and use your libata acpi patch which saves/restores the
taskfile of the disk on hibernation and resume. I wonder if you have an
updated patch for GIT HEAD because a colleague with a similar notebook
has to use GIT HEAD to get his soundcard supported. I tried to port it
myself and there was only one reject which I maybe fixed, but I don't
intend to try the patch so I don't know:

@@ -4290,6 +4294,7 @@ int ata_device_resume(struct ata_port *a
        }
        if (!ata_dev_present(dev))
                return 0;
+       ata_acpi_exec_tfs(ap);
        if (dev->class == ATA_DEV_ATA)
                ata_start_drive(ap, dev);

in libata-core.c. This function ata_device_resume does no longer exist in GIT
HEAD, so I modified the following function ata_scsi_device_resume instead:

diff -ruN linux-2.6.orig/drivers/scsi/libata-scsi.c linux-2.6/drivers/scsi/libata-scsi.c
--- linux-2.6.orig/drivers/scsi/libata-scsi.c   2006-08-27 20:01:34.000000000 +0200
+++ linux-2.6/drivers/scsi/libata-scsi.c        2006-08-27 23:13:00.000000000 +0200
@@ -499,6 +499,8 @@
            sdev->sdev_state == SDEV_CANCEL || sdev->sdev_state == SDEV_DEL)
                goto out_unlock;

+       ata_acpi_exec_tfs(ap);
+
        /* request resume */
        action = ATA_EH_RESUME;
        if (sdev->sdev_gendev.power.power_state.event == PM_EVENT_SUSPEND)

        Thomas
