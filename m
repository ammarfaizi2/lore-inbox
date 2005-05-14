Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVENVFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVENVFq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 17:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVENVFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 17:05:46 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:56450 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261389AbVENVF1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 17:05:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XptV19kfDftVqTMD7/WVbkyAktmoKrty7TcxIwuaQYDIGRcJVAYafNtyzYdXH5ozG5u7qh1FU76K105OZ7ge11xi3OtW3STH3myU117w7B0YQE+4pUBX/MQzvbvpk70yZWWRZlswhQu0U7XqCzBdo07aXGaMWkQLE9sk3wrMeCo=
Message-ID: <b7561c4a05051414057fa7aa12@mail.gmail.com>
Date: Sat, 14 May 2005 23:05:26 +0200
From: Leroy van Logchem <leroy.vanlogchem@gmail.com>
Reply-To: Leroy van Logchem <leroy.vanlogchem@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-5.0.5 Oops at journal_commit_transaction
In-Reply-To: <b7561c4a05051413465cf1ccc8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <b7561c4a05051413465cf1ccc8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list, thanks for reading my post :)

Background:
After running pre-production file servers for two days we have a
hanging system with a oops related to journal_commit_transaction. It
was hosting nfs v3 exports to about 50 clients and a few smbd
processes. All filesystems are using ext3 with v2 journals
data=ordered mode.

Symptoms:
kernel oops related to ext3 journal commits, can't use the system anymore

Hardware setup:
19" 1U Supermicro 6018-P8 Dual Xeon, 1 GB ram
Three 2U external scsi subsystems U160 connected to the AIC-7902B

Distribution vendor and version:
RedHat Enterprise Linux v4 (updated to 2.6.9-5.0.5)

Research so far:
I found similar reports on various lists but I don't know if it's the
same problem
http://www.ussg.iu.edu/hypermail/linux/kernel/0410.0/1318.html
http://marc.theaimsgroup.com/?l=linux-kernel&m=109776600031754&w=2

PCI listing:
00:00.0 Host bridge: Intel Corp. E7501 Memory Controller Hub (rev 01)
00:00.1 Class ff00: Intel Corp. E7500/E7501 Host RASUM Controller (rev 01)
00:02.0 PCI bridge: Intel Corp. E7500/E7501 Hub Interface B PCI-to-PCI
Bridge (rev 01)
00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 42)
00:1f.0 ISA bridge: Intel Corp. 82801CA LPC Interface Controller (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801CA Ultra ATA Storage Controller (rev 02)
00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus Controller (rev 02)
01:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04)
01:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04)
01:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04)
01:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04)
02:03.0 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet
Controller (Copper) (rev 01)
02:03.1 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet
Controller (Copper) (rev 01)
03:02.0 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
03:02.1 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
04:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)

Kernel log messages:

May 14 07:13:02 filera1 crond(pam_unix)[12998]: session closed for user root
May 14 07:14:01 filera1 crond(pam_unix)[13570]: session opened for
user root by (uid=0)
May 14 07:14:01 filera1 kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000000c
May 14 07:14:01 filera1 kernel:  printing eip:
May 14 07:14:01 filera1 kernel: f085264d
May 14 07:14:01 filera1 kernel: *pde = 00004001
May 14 07:14:01 filera1 kernel: Oops: 0002 [#1]
May 14 07:14:01 filera1 kernel: SMP
May 14 07:14:01 filera1 kernel: Modules linked in: nfsd exportfs
w83781d adm1021 i2c_sensor i2c_i801 i2c_core nfs lockd sunrpc drbd(U)
md5 ipv6 autofs4 dm_mod
 uhci_hcd hw_random e1000 floppy sg ext3 jbd aic79xx sd_mod scsi_mod
May 14 07:14:01 filera1 kernel: CPU:    1
May 14 07:14:01 filera1 kernel: EIP:    0060:[<f085264d>]    Not tainted VLI
May 14 07:14:01 filera1 kernel: EFLAGS: 00010286   (2.6.9-5.0.5.ELsmp)
May 14 07:14:01 filera1 kernel: EIP is at
journal_commit_transaction+0x442/0xfb1 [jbd]
May 14 07:14:01 filera1 kernel: eax: e6aa286c   ebx: 00000000   ecx:
c1a89080   edx: e30bf0ec
May 14 07:14:01 filera1 kernel: esi: e03aa800   edi: e6aa286c   ebp:
e011fd80   esp: c84f8df0
May 14 07:14:01 filera1 kernel: ds: 007b   es: 007b   ss: 0068
May 14 07:14:01 filera1 kernel: Process kjournald (pid: 8992,
threadinfo=c84f8000 task=ee735330)
May 14 07:14:01 filera1 kernel: Stack: 00000021 00000000 00000000
00000000 00000000 00000000 eaf75fbc e03aa800
May 14 07:14:01 filera1 kernel:        eaf750bc 000008f3 00000000
ee735330 c011e8a2 c84f8e44 c84f8e44 00000002
May 14 07:14:01 filera1 kernel:        00000118 00000000 c0111352
002ab128 00000000 00000000 c0111352 002ad5a8
May 14 07:14:01 filera1 kernel: Call Trace:
May 14 07:14:01 filera1 kernel:  [<c011e8a2>] autoremove_wake_function+0x0/0x2d
May 14 07:14:01 filera1 kernel:  [<c0111352>] mark_offset_tsc+0x285/0x303
May 14 07:14:01 filera1 kernel:  [<c0111352>] mark_offset_tsc+0x285/0x303
May 14 07:14:01 filera1 kernel:  [<f0854e6d>] kjournald+0xc7/0x213 [jbd]
May 14 07:14:01 filera1 kernel:  [<c011e8a2>] autoremove_wake_function+0x0/0x2d
May 14 07:14:01 filera1 kernel:  [<c011e8a2>] autoremove_wake_function+0x0/0x2d
May 14 07:14:01 filera1 kernel:  [<c011bcf0>] schedule_tail+0x12/0x55
May 14 07:14:01 filera1 kernel:  [<f0854da0>] commit_timeout+0x0/0x5 [jbd]
May 14 07:14:01 filera1 kernel:  [<f0854da6>] kjournald+0x0/0x213 [jbd]
May 14 07:14:01 filera1 kernel:  [<c01041f1>] kernel_thread_helper+0x5/0xb
May 14 07:14:01 filera1 kernel: Code: 00 00 e8 54 6d 90 cf 8b 54 24 14
89 d8 e8 88 0b 00 00 89 f0 e8 54 29 a7 cf 83 7d 18 00 0f 84 1f 01 00
00 8b 45 18 8b 78
20 8b 1f <f0> ff 43 0c 8b 03 a8 04 74 5a 8b 4c 24 1c 8d 81 e4 00 00 00 e8
May 14 07:15:01 filera1 crond(pam_unix)[14152]: session opened for
user root by (uid=0)
May 14 07:16:01 filera1 crond(pam_unix)[14719]: session opened for
user root by (uid=0)
May 14 07:17:01 filera1 crond(pam_unix)[15281]: session opened for
user root by (uid=0)

Can someone please tell me if I should apply Stephen Tweedie patch? or
is this something different?

--Leroy
