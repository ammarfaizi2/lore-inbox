Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273376AbTG3T3y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 15:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273358AbTG3T1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 15:27:22 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:28167 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S273357AbTG3T1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 15:27:06 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Subject: Re: devfs rescanning?
Date: Wed, 30 Jul 2003 23:27:25 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307302327.25998.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a system with 4 SCA drives.  Originally they were:
> 
> /dev/sda -> scsi/host0/bus0/target0/lun0/disc
> /dev/sdb -> scsi/host0/bus0/target1/lun0/disc
> /dev/sdc -> scsi/host1/bus0/target0/lun0/disc
> /dev/sdd -> scsi/host1/bus0/target1/lun0/disc
>
> SDA drive was hot-pulled to test the raid failover and it worked great.
> Next the box was rebooted after the drive was replaced (these systems
> can hang or go real stupid when a drive is pulled).  The drives remapped
> as was expected.  When it came back up the sd? entries had shifted up 1
> as expected

> /dev/sda -> scsi/host0/bus0/target1/lun0/disc
> /dev/sdb -> scsi/host1/bus0/target0/lun0/disc
> /dev/sdc -> scsi/host1/bus0/target1/lun0/disc
>
> and when the drive was put back in it came up as sdd.  Other than a
> reboot is there any known way to get the drives back in the proper
> order?  Killing devfsd, removing the entries and restarting, etc didn't
> do any good.

devfsd.conf:

REGISTER scsi/host0/bus0/target0/lun0/disc CFUNCTION GLOBAL mksymlink $devname 
diska 
REGISTER scsi/host0/bus0/target1/lun0/disc CFUNCTION GLOBAL mksymlink $devname 
diskb
REGISTER scsi/host1/bus0/target0/lun0/disc CFUNCTION GLOBAL mksymlink $devname 
diskc
REGISTER scsi/host1/bus0/target1/lun0/disc CFUNCTION GLOBAL mksymlink $devname 
diskd

if you insist on calling them sda etc you may comment out MKOLDCOMPAT but 
beware of consequences.

but this breaks anyway if SCSI host numbers change (e.g. if you plug in new 
HBA) and for that there is no solution

-andrey
