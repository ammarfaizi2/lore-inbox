Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVCRQ3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVCRQ3b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 11:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVCRQ3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 11:29:30 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:43155 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S261676AbVCRQ1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 11:27:07 -0500
Date: Fri, 18 Mar 2005 17:22:13 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BK PATCHES] ide-2.6 update
Message-ID: <Pine.GSO.4.62.0503181703510.24383@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please do a

 	bk pull bk://bart.bkbits.net/ide-2.6

This will update the following files:

  Documentation/ioctl/hdio.txt |  179 ++++++++++++++++++++++++++++++++++---------
  drivers/ide/ide-cd.c         |   99 +++++++++++++++++++----
  drivers/ide/ide-cd.h         |    2
  drivers/ide/ide-disk.c       |   96 +++++++++++++++++++++--
  drivers/ide/ide-floppy.c     |  117 +++++++++++++++++++++-------
  drivers/ide/ide-tape.c       |  175 +++++++++++++++++++++++++++++++-----------
  drivers/ide/ide.c            |    3
  drivers/ide/pci/cs5520.c     |    3
  drivers/scsi/ide-scsi.c      |   66 +++++++++++++--
  include/linux/ide.h          |    2
  include/linux/pci_ids.h      |    1
  11 files changed, 594 insertions(+), 149 deletions(-)

through these ChangeSets:

<bzolnier@trik.(none)> (05/03/18 1.2239)
    [ide] ide-tape: fix character device ->open() vs ->cleanup() race

    Similar to the same race but for the block device.

    * store pointer to struct ide_tape_obj in idetape_chrdevs[]
    * rename idetape_chrdevs[] to idetape_devs[] and kill idetape_chrdev_t
    * add ide_tape_chrdev_get() for getting reference to the tape
    * store tape pointer in file->private_data and fix all users of it
    * fix idetape_chrdev_{open,release}() to get/put reference to the tape

    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/03/18 1.2238)
    [ide] ide-scsi: add basic refcounting

    * pointers to a SCSI host and a drive are added to idescsi_scsi_t
    * pointer to the SCSI host is stored in disk->private_data
    * ide_scsi_{get,put}() is used to {get,put} reference to the SCSI host

    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/03/18 1.2237)
    [ide] ide-tape: add basic refcounting

    Similar changes as for ide-cd.c.

    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/03/18 1.2236)
    [ide] ide-floppy: add basic refcounting

    Similar changes as for ide-cd.c.

    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/03/18 1.2235)
    [ide] ide-disk: add basic refcounting

    Similar changes as for ide-cd.c (except that struct ide_disk_obj is added).

    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/03/18 1.2234)
    [ide] ide-cd: add basic refcounting

    * based on reference counting in drivers/scsi/{sd,sr}.c
    * fixes race between ->open() and ->cleanup() (ide_unregister_subdriver()
      tests for drive->usage != 0 but there is no protection against new users)
    * struct kref and pointer to a drive are added to struct ide_cdrom_info
    * pointer to drive's struct ide_cdrom_info is stored in disk->private_data
    * ide_cd_{get,put}() is used to {get,put} reference to struct ide_cdrom_info
    * ide_cd_release() is a release method for struct ide_cdrom_info

    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<bzolnier@trik.(none)> (05/03/18 1.2233)
    [ide] make ide_generic_ioctl() take ide_drive_t * as an argument

    As a result disk->private_data can be used by device drivers now.

    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<htejun@gmail.com> (05/03/18 1.2232)
    [ide] hdio.txt update

    This patch updates Documentation/ioctl/hdio.txt to include more
    detailed descriptions about HDIO_DRIVE_{CMD|TASK|TASKFILE} ioctls.

    Signed-off-by: Tejun Heo <htejun@gmail.com>
    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<tklauser@nuerscht.ch> (05/03/18 1.2231)
    [ide] drivers/ide/cs5520.c: use the DMA_{64,32}BIT_MASK constants

    Description: Use the DMA_{64,32}BIT_MASK constants from dma-mapping.h
    when calling pci_set_dma_mask() or pci_set_consistent_dma_mask()
    See http://marc.theaimsgroup.com/?t=108001993000001&r=1&w=2 for details

    Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<Jason.d.gaston@intel.com> (05/03/18 1.2230)
    [ide] pci_ids.h correction for Intel ICH7R

    This patch removes an incorrect ICH7R DID in pci_ids.h.

    Signed-off-by: Jason Gaston <Jason.d.gaston@intel.com>
    Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

