Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265208AbTFSUDv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 16:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265416AbTFSUDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 16:03:51 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:51942 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265208AbTFSUDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 16:03:47 -0400
Date: Thu, 19 Jun 2003 13:06:26 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: linux-kernel <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 833] New: kernel-2.5.72 could not be booted. 
Message-ID: <9180000.1056053186@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=833

           Summary: kernel-2.5.72 could not be booted.
    Kernel Version: 2.5.72
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: avenkat@us.ibm.com
                CC: sglass@us.ibm.com


Distribution:RedHat Linux 8.0 (psyche)
Hardware Environment:IBM x440, 8.0GB RAM, Intel Xeon 1.6GHz processors, 4-way
Software Environment: 2.5.70
Problem Description: The system was running on Linux kernel-2.5.70.  Compile the
2.5.72 (pulled from kernel.org). Made the necessory changes to lilo.conf so that
2.5.72 will be the default kernel.  During the boot time the server could not be
booted and the display dumped the following message:
NMI Watchdog detected LOCKUP on CPU1, eip c0112bf2, regsiters:
CPU:
1
EIP:
0060:[<c0112bf2>]
	Not tainted
EFLAGS:
00000082
EIP is at ipi_handler+0x54/0x6e
eax:
c0142cf8
ebx:
f7f93f64
ecx:
000002ff
edx:
00000000
esi:
00000086
edi:
f7f90000
ebp:
c0106ece
esp:
f7f91f50
ds:
007b
es:
007b
ss:
0068
Process swapper (pid: 0, threadinfo=f7f90000 task=f7f95310)
Stack:
00000002
00000001
c058c084
f7f91f7c
f7f90000
00000000
c0116392
f7f93f64
		c0106ece	f7f90000	c0109e6a	c0106ece	00000a00	f7f90000	f7f90000	f7f90000
		c0106ece	00000000	0000007b	fffffffb	c0106ef8	00000060	00000246
Call Trace:
 [<c0116392>] smp_call_function_interrupt+0x44/0x8c
 [<c0106ece>] default_idle+0x0/0x2e
 [<c0109e6a>] call_function_interrupt+0x1a/0x20
 [<c0106ece>] default_idle+0x0/0x2e
 [<c0106ece>] default_idle+0x0/0x2e
 [<c0106ef8>] default_idle+0x2a/0x2e
 [<c0106f6f>] cpu_idle+0x39/0x42
 [<c0121250>] printk+0x1b4/0x258

Code: 8b 43 04 85 c0 75 f7 56 9d 83 c4 10 5b 5e c3 a1 24 54 49 c0
console shuts up ...

Following is the contents of lilo.conf file:
prompt
timeout=50
default=linux-2.5.72
boot=/dev/sda
map=/boot/map
install=/boot/boot.b
message=/boot/message
linear

image=/boot/vmlinuz-2.5.72
        label=linux-2.5.72
        read-only
        root=/dev/sda3
        append="nmi_watchdog=1"

image=/boot/vmlinuz-2.5.70
        label=linux-2.5.70
        read-only
        root=/dev/sda3
        append="nmi_watchdog=1"
image=/boot/vmlinuz-2.4.18-14bigmem
        label=linux
        initrd=/boot/initrd-2.4.18-14bigmem.img
        read-only
        append="root=LABEL=/"

image=/boot/vmlinuz-2.4.18-14smp
        label=linux-smp
        initrd=/boot/initrd-2.4.18-14smp.img
        read-only
        append="root=LABEL=/"



The config file that was used will be in the form of an attachment.

Steps to reproduce:
(1) Install RedHat Linux 8.0 (psyche).
(2) Download kernel 2.5.70 from kernel.org. Compile and configure the 2.5.70
kernel and reboot with 2.5.70 as the default kernel.(3) Download kernel 2.5.72
from kernel.org.  (Make sure the server is running on 2.5.70). Compile and copy
the System.map and bzImage to the /boot directory.  Modify the lilo.conf so that
2.5.72 is the default kernel.  Also make sure the "nmi_watchdog=1" in the
lilo.conf for 2.5.72. (lilo.conf file is shown in the above.)
(4) execute the command: reboot


