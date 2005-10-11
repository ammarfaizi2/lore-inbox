Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbVJLACM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbVJLACM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 20:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVJLACM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 20:02:12 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:48546 "HELO
	briare1.heliogroup.fr") by vger.kernel.org with SMTP
	id S932374AbVJLACL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 20:02:11 -0400
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: linux-kernel@vger.kernel.org
Subject: MPT fusion driver, better but still buggy at errors handling under 2.6
Date: Tue, 11 Oct 2005 23:58:15 GMT
Message-ID: <05ELX94@briare1.heliogroup.fr>
X-Mailer: Pliant 94
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MPT fusion driver under Linux 2.6 still fails to recover properly from tiny
SCSI troubles through doing reset then resend pending commands just like
any good Linux SCSI driver does transparently.

Here is the behaviour of MPT fusion driver I noticed on various Linux kernels:
2.4.xx  recovers gracefully (only reading the kernel log will enable
        to discover that a tiny problem did append).
2.6.xx  xx <= 11, enters an infinit loop attempting to reset the SCSI
        so the box gets unusable and requires a rough power cycle to recover.
2.6.12  untested.
2.6.13  puts the disk offline, so the box continues to run, but Linux
        software RAID removed the disk. A software reboot is required
        to get the disk back online, and a 'raidhotadd' will also be to get
        the all service back online, also this is a remote server, and the
        box did not came up after the remote sofware reboot request :-(

I reported this bug about Linux 2.6.5 on Fri, 23 Apr 2004,
about Linux 2.6.9 on Wed, 26 Jan 2005,
and the bug is still there.


Here is the 2.6.13 kernel console:

<4>mptscsih: ioc0: >> Attempting task abort! (sc=da1adb00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=da1adb00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=da1ad980)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=da1ad980)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=da1ad800)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=da1ad800)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=da1ad680)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=da1ad680)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=da1ad500)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=da1ad500)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=da1ad380)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=da1ad380)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=da1ad200)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=da1ad200)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=da1ad080)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=da1ad080)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f39ebe00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f39ebe00)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f39ebc80)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f39ebc80)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f39ebb00)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f39ebb00)
<6>mptbase: ioc0: IOCStatus(0x0048): SCSI Task Terminated
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f39eb980)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting task abort! (sc=f39eb980)
<6>mptbase: ioc0: IOCStatus(0x004a): SCSI Task Management Failed
<4>mptscsih: ioc0: >> Attempting target reset! (sc=da1adb00)
<6>mptbase: Initiating ioc0 recovery
<6>mptbase: ioc0: IOCStatus(0x0047): SCSI Protocol Error
<4>mptscsih: ioc0: >> Attempting target reset! (sc=da1ad500)
<4>mptscsih: ioc0: >> Attempting bus reset! (sc=da1adb00)
<6>mptbase: ioc0: IOCStatus(0x0043): SCSI Device Not There
<6>mptbase: ioc0: IOCStatus(0x0043): SCSI Device Not There
<6>mptbase: ioc0: IOCStatus(0x0043): SCSI Device Not There
<6>mptbase: ioc0: IOCStatus(0x0043): SCSI Device Not There
<6>mptbase: ioc0: IOCStatus(0x0043): SCSI Device Not There
<6>mptbase: ioc0: IOCStatus(0x0043): SCSI Device Not There
<4>mptscsih: ioc0: >> Attempting host reset! (sc=da1adb00)
<6>mptbase: Initiating ioc0 recovery
<6>mptbase: ioc0: IOCStatus(0x0043): SCSI Device Not There
<6>mptbase: ioc0: IOCStatus(0x0043): SCSI Device Not There
<6>mptbase: ioc0: IOCStatus(0x0043): SCSI Device Not There
<6>mptbase: ioc0: IOCStatus(0x0043): SCSI Device Not There
<6>mptbase: ioc0: IOCStatus(0x0043): SCSI Device Not There
<6>mptbase: ioc0: IOCStatus(0x0043): SCSI Device Not There
<6>scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 0 lun 0
<6>scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 0 lun 0
<6>scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 0 lun 0
<6>scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 0 lun 0
<6>scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 0 lun 0
<6>scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 0 lun 0
<3>scsi0 (0:0): rejecting I/O to offline device
<1>raid1: Disk failure on sda1, disabling device. 
<4> Operation continuing on 1 devices
<3>scsi0 (0:0): rejecting I/O to offline device
<3>scsi0 (0:0): rejecting I/O to offline device
<3>scsi0 (0:0): rejecting I/O to offline device
<3>scsi0 (0:0): rejecting I/O to offline device
<3>scsi0 (0:0): rejecting I/O to offline device
<4>RAID1 conf printout:
<4> --- wd:1 rd:2
<4> disk 0, wo:1, o:0, dev:sda1
<4> disk 1, wo:0, o:1, dev:sdb1
<4>RAID1 conf printout:
<4> --- wd:1 rd:2
<4> disk 1, wo:0, o:1, dev:sdb1

and after an attempt to futher read the disk without rebooting:

<3>scsi0 (0:0): rejecting I/O to offline device
<3>Buffer I/O error on device sda1, logical block 17649664
<3>Buffer I/O error on device sda1, logical block 17649665
<3>Buffer I/O error on device sda1, logical block 17649666
<3>Buffer I/O error on device sda1, logical block 17649667
<3>Buffer I/O error on device sda1, logical block 17649668
<3>scsi0 (0:0): rejecting I/O to offline device

