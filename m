Return-Path: <linux-kernel-owner+w=401wt.eu-S964955AbWL1JLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbWL1JLJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 04:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbWL1JLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 04:11:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:5784 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964949AbWL1JLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 04:11:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rZs2Etlqhio29CY/gmW49LeEdBlsRQCkjzGVUIAfTFWz22IP6krcjPIs2TWYqlBdH81MXhP7XgNZ4D4dp9RX0mFaJHiUnyY8rO4RtFOyG/pP5lroIvhVmZiABSRIa6gJnzx6t4c1zfR09ImoknsV09AHxrnN75aQsp53EJtYUxw=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: NMI Watchdog detected LOCKUP
Date: Thu, 28 Dec 2006 10:10:48 +0100
User-Agent: KMail/1.9.5
Cc: linux-scsi@vger.kernel.org, jesper.juhl@gmail.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612281010.48470.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

One of my NFS servers just blew up on me. I found the following in the log - hope it is useful : 

NMI Watchdog detected LOCKUP on CPU 1
CPU 1
Modules linked in: sg eeprom i2c_i801
Pid: 284, comm: scsi_eh_2 Not tainted 2.6.18.1 #1
RIP: 0010:[<ffffffff80375e6a>]  [<ffffffff80375e6a>] __delay+0xa/0x20
RSP: 0000:ffff81022fbf5d80  EFLAGS: 00000097
RAX: 000000000020bb08 RBX: 000000000000d6db RCX: 0000000057489868
RDX: 0000000000192501 RSI: ffff8100cff93528 RDI: 000000000030d2ac
RBP: ffff81022fbf5d80 R08: ffff81022fbf4000 R09: 0000000000000000
R10: ffff8100cff93528 R11: 00000000000000d8 R12: ffff81022f449ce8
R13: 0000000000000001 R14: 0000000000000004 R15: ffff81022f449878
FS:  0000000000000000(0000) GS:ffff8101fef36640(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00000000f7f59000 CR3: 000000022f590000 CR4: 00000000000006e0
Process scsi_eh_2 (pid: 284, threadinfo ffff81022fbf4000, task ffff81022fa32180)
Stack:  ffff81022fbf5d90 ffffffff80375eaa ffff81022fbf5dc0 ffffffff803ee1bc
 ffff8100cff93528 ffff81022f449ce8 ffff81022f449800 ffff81022f449d40
 ffff81022fbf5e00 ffffffff803f175f ffff81022fbf5de0 ffffffff80371529
Call Trace:
 [<ffffffff80375eaa>] __const_udelay+0x2a/0x30
 [<ffffffff803ee1bc>] ips_send_wait+0xbc/0xe0
 [<ffffffff803f175f>] __ips_eh_reset+0x11f/0x3f0
 [<ffffffff803f1a53>] ips_eh_reset+0x23/0x40
 [<ffffffff803e5034>] scsi_try_host_reset+0x34/0xb0
 [<ffffffff803e5eb6>] scsi_error_handler+0x476/0x6d0
 [<ffffffff80241bfb>] kthread+0xdb/0x120
 [<ffffffff8020ab1c>] child_rip+0xa/0x12

Code: 0f 31 29 c8 48 39 f8 72 f5 c9 c3 66 66 66 90 66 66 66 90 66
console shuts up ...
 NMI Watchdog detected LOCKUP on CPU 0
CPU 0
Modules linked in: sg eeprom i2c_i801
Pid: 15, comm: kblockd/0 Not tainted 2.6.18.1 #1
RIP: 0010:[<ffffffff804aca3b>]  [<ffffffff804aca3b>] .text.lock.spinlock+0x2/0x97
RSP: 0000:ffff81022fbbfd70  EFLAGS: 00000086
RAX: ffff81022fa22228 RBX: ffff8100a46be4a8 RCX: 0000000000000000
RDX: ffff8100a46be7d8 RSI: ffff8100a46be4a8 RDI: ffff81022f449850
RBP: ffff81022fbbfd70 R08: ffff81022fbbe000 R09: 0000000000000003
R10: 0000000000000002 R11: 0000000000000000 R12: ffff81022fae6800
R13: ffff81022f449800 R14: ffff81022fa22048 R15: ffff8101f304e980
FS:  0000000000000000(0000) GS:ffffffff80683000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 000000000805bc2c CR3: 000000022b911000 CR4: 00000000000006e0
Process kblockd/0 (pid: 15, threadinfo ffff81022fbbe000, task ffff81022faeaf00)
Stack:  ffff81022fbbfdc0 ffffffff803e791f ffff81022fae6848 ffff81022fae6848
 ffff81022fae68e8 ffff81022fa22048 ffff81022fa22170 ffff8101fef362c0
 ffff81022fa22048 0000000000000282 ffff81022fbbfde0 ffffffff803632f5
Call Trace:
Inexact backtrace:
 [<ffffffff803e791f>] scsi_request_fn+0x19f/0x350
 [<ffffffff803632f5>] __generic_unplug_device+0x25/0x30
 [<ffffffff80363320>] generic_unplug_device+0x20/0x40
 [<ffffffff8036336d>] blk_unplug_work+0xd/0x10
 [<ffffffff8023e415>] run_workqueue+0xb5/0x110
 [<ffffffff80363360>] blk_unplug_work+0x0/0x10
 [<ffffffff8023e5a1>] worker_thread+0x131/0x170
 [<ffffffff80227660>] default_wake_function+0x0/0x10
 [<ffffffff80227660>] default_wake_function+0x0/0x10
 [<ffffffff8023e470>] worker_thread+0x0/0x170
 [<ffffffff80241bfb>] kthread+0xdb/0x120
 [<ffffffff8020ab1c>] child_rip+0xa/0x12
 [<ffffffff80241b20>] kthread+0x0/0x120
 [<ffffffff8020ab12>] child_rip+0x0/0x12


Code: 83 3f 00 7e f9 e9 af fc ff ff f3 90 83 3f 00 7e f9 e9 d6 fc
console shuts up ...



The server is running 2.6.18.1
# uname -a
Linux st1.surf-town.net 2.6.18.1 #1 SMP Wed Oct 18 12:45:37 CEST 2006 x86_64 GNU/Linux

The kernel is 64bit but userspace is 32bit.

# scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux st1.surf-town.net 2.6.18.1 #1 SMP Wed Oct 18 12:45:37 CEST 2006 x86_64 GNU/Linux

Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre1
e2fsprogs              1.37
xfsprogs               2.6.28
quota-tools            3.12.
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   056
Modules Loaded         sg eeprom i2c_i801

# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      :                   Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 3
cpu MHz         : 3200.193
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall nx lm constant_tsc pni monitor ds_cpl cid cx16 xtpr
bogomips        : 6413.18
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      :                   Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 3
cpu MHz         : 3200.193
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall nx lm constant_tsc pni monitor ds_cpl cid cx16 xtpr
bogomips        : 6400.68
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:

# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi0 Channel: 02 Id: 08 Lun: 00
  Vendor: IBM      Model: 39M6750a S320  0 Rev: 1
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 03 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 01 Id: 15 Lun: 00
  Vendor: IBM      Model: EXP400   S320    Rev: D110
  Type:   Processor                        ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 03 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 04 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 05 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 15 Lun: 00
  Vendor: IBM      Model: SERVERAID        Rev: 1.00
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi2 Channel: 01 Id: 15 Lun: 00
  Vendor: IBM      Model: EXP400   S320    Rev: D110
  Type:   Processor                        ANSI SCSI revision: 03



-- 
Kind regards,
Jesper Juhl <jesper.juhl@gmail.com>

