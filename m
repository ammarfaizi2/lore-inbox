Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161060AbVLWV6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161060AbVLWV6A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 16:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161063AbVLWV6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 16:58:00 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:48752 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161060AbVLWV57 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 16:57:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=n1ryDHwnXr6zh5WQCpFaCiZt+pCHKtZnxW5db3ojp1g3X1aLTxq2NJX9qD87fNicRjJdzA0lnY4kr7YOtF3wtDS5v8U/vBkf9IQfFojsQ3RPBjv1nnqPF4RPr56Nmc5Pp1HYghIoAd1nWH8P9XozoWerfGtn8h58osMQugK9XYI=
Message-ID: <832d89d20512231357v79bb46baubda9285f493ea957@mail.gmail.com>
Date: Fri, 23 Dec 2005 23:57:58 +0200
From: maxim not this time <maximvex@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [Question] Bringing up a LSI 53C1030 scsi controller on 2.6.15-rc6
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kernel : 2.6.14@patch-2.6.15-rc6
Distro : Mandriva 2006.0
Machine : HP xw9300 workstation

Target Device : LSI 53C1030 scsi


I'm trying to compile my kernel to support this device, since the
driver has been accepted into  2.6.15-rc5 I hope to get it working for
me as well.

I booted the new kernel from an ATA harddrive, and trying to get the
scsi driver up so that I could talk to the device.

For some reason - The driver fails to find the controller.

# uname -a
Linux localhost 2.6.15-rc6 #1 SMP Tue Dec 20 22:32:06 EST 2005 x86_64
Dual Core AMD Opteron(tm) Processor 270 unknown GNU/Linux

# modprobe -v --show-depends mptspi
insmod /lib/modules/2.6.15-rc6/kernel/drivers/scsi/scsi_mod.ko
insmod /lib/modules/2.6.15-rc6/kernel/drivers/message/fusion/mptbase.ko
insmod
/lib/modules/2.6.15-rc6/kernel/drivers/message/fusion/mptscsih.ko
insmod /lib/modules/2.6.15-rc6/kernel/drivers/message/fusion/mptspi.ko

# modprobe -l | grep mpt
/lib/modules/2.6.15-rc6/kernel/drivers/message/fusion/mptspi.ko
/lib/modules/2.6.15-rc6/kernel/drivers/message/fusion/mptscsih.ko
/lib/modules/2.6.15-rc6/kernel/drivers/message/fusion/mptsas.ko
/lib/modules/2.6.15-rc6/kernel/drivers/message/fusion/mptlan.ko
/lib/modules/2.6.15-rc6/kernel/drivers/message/fusion/mptfc.ko
/lib/modules/2.6.15-rc6/kernel/drivers/message/fusion/mptctl.ko
/lib/modules/2.6.15-rc6/kernel/drivers/message/fusion/mptbase.ko

# modprobe mptspi
# ls /dev/sd*
ls: /dev/sd*: No such file or directory

# tail -n 10 /var/log/kernel/*
==> /var/log/kernel/errors <==
Dec 20 23:28:43 localhost kernel: PCI: Failed to allocate mem resource
#6:20000@e0000000 for 0000:0a:00.0
Dec 20 23:28:43 localhost kernel: ibm_acpi: ec object not found
Dec 20 23:38:40 localhost kernel: sata_vsc: Unknown parameter
`sata_via'
Dec 22 22:57:12 localhost kernel: audit(1135310222.260:0): initialized
Dec 22 23:20:52 localhost kernel: PCI: Failed to allocate mem resource
#6:20000@e0000000 for 0000:0a:00.0
Dec 22 23:20:52 localhost kernel: ibm_acpi: ec object not found

==> /var/log/kernel/info <==
Dec 22 23:20:52 localhost kernel: GSI 19 sharing vector 0xD9 and IRQ 19
Dec 22 23:20:52 localhost kernel: ACPI: PCI Interrupt 0000:00:0a.0[A]
-> Link [LMAC] -> GSI 20 (level, high) -> IRQ 217
Dec 22 23:20:52 localhost kernel: PCI: Setting latency timer of device
0000:00:0a.0 to 64
Dec 22 23:20:52 localhost kernel: eth0: forcedeth.c: subsystem:
0103c:1500 bound to 0000:00:0a.0
Dec 22 23:20:53 localhost kernel: eth0: link up.
Dec 22 23:20:55 localhost kernel: NET: Registered protocol family 10
Dec 22 23:20:55 localhost kernel: lo: Disabled Privacy Extensions
Dec 22 23:20:55 localhost kernel: IPv6 over IPv4 tunneling driver
Dec 22 23:20:59 localhost kernel: Installing knfsd (copyright (C) 1996
okir@monad.swb.de).
Dec 22 23:21:05 localhost kernel: eth0: no IPv6 routers present

==> /var/log/kernel/warnings <==
Dec 22 23:20:52 localhost kernel: nvidia: module license 'NVIDIA'
taints kernel.
Dec 22 23:20:52 localhost kernel: ACPI: PCI Interrupt Link [LNKC]
enabled at IRQ 19
Dec 22 23:20:52 localhost kernel: NVRM: loading NVIDIA Linux x86_64
NVIDIA Kernel Module  1.0-7676  Fri Jul 29 13:15:16 PDT 2005
Dec 22 23:20:52 localhost kernel: ip_conntrack version 2.4 (8192
buckets, 65536 max) - 312 bytes per conntrack
Dec 22 23:20:52 localhost kernel: ip_tables: (C) 2000-2002 Netfilter
core team
Dec 22 23:20:52 localhost kernel: ACPI: PCI Interrupt Link [LMAC]
enabled at IRQ 20
Dec 22 23:20:52 localhost kernel: eth0: no link during initialization.
Dec 22 23:20:59 localhost kernel: NFSD: Using /var/lib/nfs/v4recovery
as the NFSv4 state recovery directory
Dec 22 23:20:59 localhost kernel: NFSD: recovery directory
/var/lib/nfs/v4recovery doesn't exist
Dec 22 23:20:59 localhost kernel: NFSD: starting 90-second grace period

# cat /lib/modules/2.6.15-rc6/modules.alias | grep mpt
alias pci:v00001000d00000032sv*sd*bc*sc*i* mptspi
alias pci:v00001000d00000030sv*sd*bc*sc*i* mptspi
alias pci:v00001000d00000058sv*sd*bc*sc*i* mptsas
alias pci:v00001000d0000005Asv*sd*bc*sc*i* mptsas
alias pci:v00001000d00000056sv*sd*bc*sc*i* mptsas
alias pci:v00001000d00000054sv*sd*bc*sc*i* mptsas
alias pci:v00001000d0000005Esv*sd*bc*sc*i* mptsas
alias pci:v00001000d00000050sv*sd*bc*sc*i* mptsas
alias pci:v00001000d00000640sv*sd*bc*sc*i* mptfc
alias pci:v00001000d00000642sv*sd*bc*sc*i* mptfc
alias pci:v00001000d00000626sv*sd*bc*sc*i* mptfc
alias pci:v00001000d00000628sv*sd*bc*sc*i* mptfc
alias pci:v00001000d00000622sv*sd*bc*sc*i* mptfc
alias pci:v00001000d00000624sv*sd*bc*sc*i* mptfc
alias pci:v00001000d00000621sv*sd*bc*sc*i* mptfc

# cat /lib/modules/2.6.15-rc6/modules.pcimap | grep mpt
mptspi               0x00001000 0x00000030 0xffffffff 0xffffffff
0x00000000 0x00000000 0x0
mptspi               0x00001000 0x00000032 0xffffffff 0xffffffff
0x00000000 0x00000000 0x0
mptsas               0x00001000 0x00000050 0xffffffff 0xffffffff
0x00000000 0x00000000 0x0
mptsas               0x00001000 0x0000005e 0xffffffff 0xffffffff
0x00000000 0x00000000 0x0
mptsas               0x00001000 0x00000054 0xffffffff 0xffffffff
0x00000000 0x00000000 0x0
mptsas               0x00001000 0x00000056 0xffffffff 0xffffffff
0x00000000 0x00000000 0x0
mptsas               0x00001000 0x0000005a 0xffffffff 0xffffffff
0x00000000 0x00000000 0x0
mptsas               0x00001000 0x00000058 0xffffffff 0xffffffff
0x00000000 0x00000000 0x0
mptfc                0x00001000 0x00000621 0xffffffff 0xffffffff
0x00000000 0x00000000 0x0
mptfc                0x00001000 0x00000624 0xffffffff 0xffffffff
0x00000000 0x00000000 0x0
mptfc                0x00001000 0x00000622 0xffffffff 0xffffffff
0x00000000 0x00000000 0x0
mptfc                0x00001000 0x00000628 0xffffffff 0xffffffff
0x00000000 0x00000000 0x0
mptfc                0x00001000 0x00000626 0xffffffff 0xffffffff
0x00000000 0x00000000 0x0
mptfc                0x00001000 0x00000642 0xffffffff 0xffffffff
0x00000000 0x00000000 0x0
mptfc                0x00001000 0x00000640 0xffffffff 0xffffffff
0x00000000 0x00000000 0x0


What am I doing wrong ?


b.t.w
Can I somehow just "od" from the pci path of the device to see that
it's working (to rule out a hardware problem) ?


Thank you.


--
Cheers,
Maxim Vexler (hq4ever).

Do u GNU ?
