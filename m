Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262180AbTCMFqg>; Thu, 13 Mar 2003 00:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262181AbTCMFqg>; Thu, 13 Mar 2003 00:46:36 -0500
Received: from [66.186.193.1] ([66.186.193.1]:1040 "HELO
	unix113.hosting-network.com") by vger.kernel.org with SMTP
	id <S262180AbTCMFqe>; Thu, 13 Mar 2003 00:46:34 -0500
X-Comments: BlackMail headers - Mail to abuse@featureprice.com to report spam.
X-Authenticated-Connect: 63.109.146.2
X-Authenticated-Timestamp: 20:17:51(EST) on March 12, 2003
X-HELO-From: rohan.arnor.net
X-Mail-From: <thoffman@arnor.net>
X-Sender-IP-Address: 63.109.146.2
Subject: Oops in firewire (2.4.21-pre5 with 2.4.21-pre4 firewire driver)
From: Torrey Hoffman <thoffman@arnor.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Mar 2003 17:06:23 -0800
Message-Id: <1047517628.1172.8.camel@rohan.arnor.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I heard that the firewire merge in 2.4.21-pre5 was messed up, so I
replaced the -pre5 drivers/ieee1394 with the one from -pre4.

I got an oops while loading the driver.  I will continue to experiment
with recent kernels, and try to find a bitkeeper snapshot with the
latest firewire fixes.  Any suggestions are welcome.

(I am experimenting with recent kernels because these modules cause oops
and hangs with the latest Red Hat kernel as well.  However, the hardware
works fine with older Red Hat kernels.)

Anyway, the oops is decoded below.  System is an up to date Red Hat 8,
except for the kernel.

ohci1394_0: Unexpected PCI resource length of 1000!
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[9]  MMIO=[e9000000-e90007ff]  Max Packet=[2048]
ieee1394: SelfID completion called outside of bus reset!
ieee1394: Device added: Node[00:1023]  GUID[0004830000002cb3]  [Oxford  ]
ieee1394: Host added: Node[01:1023]  GUID[0030dd8000505e29]  [Linux OHCI-1394]
Unable to handle kernel NULL pointer dereference at virtual address 0000002c
 printing eip:
c016e639
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c016e639>]    Not tainted
EFLAGS: 00013246
eax: 00000000   ebx: d1e518c0   ecx: d1eaf550   edx: d1eaf550
esi: 00000000   edi: 00000000   ebp: 00000000   esp: d2547e60
ds: 0018   es: 0018   ss: 0018
Process kjournald (pid: 157, stackpage=d2547000)
Stack: c9656b00 d273f380 d1eaf550 d1e4dc60 c016c92d d1eaf550 c9656b00 00000004
       000006e4 00000000 d273f3f4 00000000 000003dc c95ebc24 00000000 d1e4dc60
       d1eaf3d0 000006e4 ce8ed480 c9656a40 ce8ed5a0 ce8ed540 ce8ed4e0 ce8ed480
Call Trace:    [<c016c92d>] [<c01176fc>] [<c016f62a>] [<c016f4c0>] [<c010744e>]
  [<c016f4e0>]

Code: 3b 5e 2c 74 29 89 34 24 89 5c 24 04 e8 56 01 00 00 8b 5c 24
 <6>ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
scsi1 : IEEE-1394 SBP-2 protocol driver (host: ohci1394)
$Rev: 707 $ James Goodwin <jamesg@filanet.com>
SBP-2 module load options:
- Max speed supported: S400
- Max sectors per I/O supported: 255
- Max outstanding commands supported: 8
- Max outstanding commands per lun supported: 1
- Serialized I/O (debug): no
- Exclusive login: yes
  Vendor: WDC WD12  Model: 00JB-00CRA1       Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 06
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
 sda: sda1

>>EIP; c016e639 <__journal_remove_checkpoint+39/90>   <=====

>>ebx; d1e518c0 <_end+11ae7e88/144df628>
>>ecx; d1eaf550 <_end+11b45b18/144df628>
>>edx; d1eaf550 <_end+11b45b18/144df628>
>>esp; d2547e60 <_end+121de428/144df628>

Trace; c016c92d <journal_commit_transaction+6dd/1180>
Trace; c01176fc <schedule+21c/360>
Trace; c016f62a <kjournald+14a/1d0>
Trace; c016f4c0 <commit_timeout+0/10>
Trace; c010744e <kernel_thread+2e/40>
Trace; c016f4e0 <kjournald+0/1d0>

Code;  c016e639 <__journal_remove_checkpoint+39/90>
00000000 <_EIP>:
Code;  c016e639 <__journal_remove_checkpoint+39/90>   <=====
   0:   3b 5e 2c                  cmp    0x2c(%esi),%ebx   <=====
Code;  c016e63c <__journal_remove_checkpoint+3c/90>
   3:   74 29                     je     2e <_EIP+0x2e>
Code;  c016e63e <__journal_remove_checkpoint+3e/90>
   5:   89 34 24                  mov    %esi,(%esp,1)
Code;  c016e641 <__journal_remove_checkpoint+41/90>
   8:   89 5c 24 04               mov    %ebx,0x4(%esp,1)
Code;  c016e645 <__journal_remove_checkpoint+45/90>
   c:   e8 56 01 00 00            call   167 <_EIP+0x167>
Code;  c016e64a <__journal_remove_checkpoint+4a/90>
  11:   8b 5c 24 00               mov    0x0(%esp,1),%ebx


Torrey Hoffman
thoffman@arnor.net

