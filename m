Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263491AbSKHXJm>; Fri, 8 Nov 2002 18:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263517AbSKHXJm>; Fri, 8 Nov 2002 18:09:42 -0500
Received: from u195-95-94-30.goplanet.pi.be ([195.95.94.30]:62724 "EHLO
	jebril.pi.be") by vger.kernel.org with ESMTP id <S263491AbSKHXJm>;
	Fri, 8 Nov 2002 18:09:42 -0500
Message-Id: <200211082316.gA8NGGEP007418@jebril.pi.be>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: 2.5.46 scsi (aic7xxx?) reboot failure & kernel panic
Date: Sat, 09 Nov 2002 00:16:16 +0100
From: "Michel Eyckmans (MCE)" <mce@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since a couple of releases ago my box fails to reboot, spitting out 
scsi related errors and a kernel panic instead. At first I tought 
this to be the double driver registration issue, but since the 
latest kernel still has this problem...

This is 2.5.46 smp on a box with 2 scsi drivers like so:

 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_AHA152X=y
 CONFIG_SCSI_AIC7XXX=y
 CONFIG_AIC7XXX_CMDS_PER_DEVICE=8
 CONFIG_AIC7XXX_RESET_DELAY_MS=5000

The messages look like this (scsi0 is the aic7xxx):

 Rebooting.
 <a pause of several seconds here>
 scsi0: Dumping Card State in Data-out phase, at SEQADDR 0x0
 ACCUM = 0x0, SINDEX = 0x0, DINDEX = 0x0, ARG_2 = 0x0
 HCNT = 0x0
 SCSISEQ = 0x0, SBLKCTL = 0xc0
  DFCNTRL = 0x0, DFSTATUS = 0x29
 LASTPHASE = 0x0, SCSISIGI = 0x0, SXFRCTL0 = 0x0
 SSTAT0 = 0x0, SSTAT1= 0x8
 STACK == 0x0, 0x0, 0x0, 0x0
 SCB count = 4
 Kernel NEXTQSCB = 2
 Card NEXTQSCB = 0
 QINFIFO entries: 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 2 3 ... <a lot more of these >
 Waiting Queue entries: 0:255 1:255 2:255
 Disconnected Queue entries: 0:255 1:255 2:255
 QOUTFIFO entries:
 Sequencer Free SCB List: 0 1 2
 Pending list: 3
 Kernel Free SCB list: 1 0
 Untagged Q(0): 3
 DevQ(0:0:0): 0 waiting
 qinpos = 1, SCB index = 2
 Kernel panic: Loop 1
