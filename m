Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbULANks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbULANks (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 08:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbULANks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 08:40:48 -0500
Received: from smtp08.auna.com ([62.81.186.18]:20687 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S261249AbULANkf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 08:40:35 -0500
Date: Wed, 01 Dec 2004 13:40:33 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: cd burning, capabilities and available modes
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Balsa 2.2.6
Message-Id: <1101908433l.8423l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

Following my little oddisey to let cd-burning easy for my users,
I think I have found another problem.

It looks like the formats available to cdrecord depend on being root
(cdrecord is not suid, if it is it complains it cant reserve some
buffers).

As root:

werewolf:/store/tmp# cdrecord -dummy dev=ATAPI:1,0,0 *.iso
...
Device seems to be: Generic mmc2 DVD-R/DVD-RW.
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE 
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R

As user:
werewolf:/store/tmp> cdrecord -dummy dev=ATAPI:1,0,0 *.iso
...
cdrecord: Cannot allocate memory. WARNING: Cannot do mlockall(2).
cdrecord: WARNING: This causes a high risk for buffer underruns.
cdrecord: Operation not permitted. WARNING: Cannot set RR-scheduler
cdrecord: Permission denied. WARNING: Cannot set priority using setpriority().
cdrecord: WARNING: This causes a high risk for buffer underruns.
scsidev: 'ATAPI:1,0,0'
devname: 'ATAPI'
scsibus: 1 target: 0 lun: 0
Warning: Using ATA Packet interface.
Warning: The related Linux kernel interface code seems to be unmaintained.
Warning: There is absolutely NO DMA, operations thus are slow.
WARNING ! Cannot gain SYS_RAWIO capability ! 
: Operation not permitted
Using libscg version 'schily-0.8'.
Device type    : Removable CD-ROM
Version        : 0
Response Format: 2
Capabilities   : 
Vendor_info    : 'HL-DT-ST'
Identifikation : 'DVDRAM GSA-4120B'
Revision       : 'A102'
Device seems to be: Generic mmc2 DVD-R/DVD-RW.
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE 
Supported modes: 
cdrecord: Drive does not support TAO recording.
cdrecord: Illegal write mode for this drive.

Uh ?

Some suggestions ?

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-rc2-jam4 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1


