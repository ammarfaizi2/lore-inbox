Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273170AbRIJClN>; Sun, 9 Sep 2001 22:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273166AbRIJClD>; Sun, 9 Sep 2001 22:41:03 -0400
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:12017 "HELO
	devbox.kroptech.com") by vger.kernel.org with SMTP
	id <S273168AbRIJCku>; Sun, 9 Sep 2001 22:40:50 -0400
Content-Type: text/plain; charset=US-ASCII
From: Adam Kropelin <akropel1@rochester.rr.com>
Reply-To: akropel1@rochester.rr.com
Organization: KropTech
To: linux-kernel@vger.kernel.org
Subject: scsi_io_completion oops on 2.4.10-pre5
Date: Sun, 9 Sep 2001 22:41:04 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01090922410400.01439@devbox>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The below oops is easily reproducable for me under 2.4.10-pre5. About 60 
seconds of heavy disk activity brings it about reliably. I've run almost 
every -ac kernel up to and including 2.4.9-ac4 with no problem. This is the 
first Linus kernel in 2.4 I've tried. After the oops, 
the machine is totally dead, no NUMLOCK response, no pings, etc. Reset button 
is the only way out. No modules were loaded when the below oops was recorded.

Interesting bits of my config:
CONFIG_M686
CONFIG_SMP
CONFIG_X86_IO_APIC
CONFIG_X86_LOCAL_APIC
CONFIG_BLK_CPQ_CISS_DA
CONFIG_SCSI
CONFIG_SCSI_AIC7XXX
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000

Let me know if I can provide any other info. I can try earlier Linus kernels 
if necessary but would appreciate guidance as to where to start since I've 
not run any of them.

--Adam

ksymoops 2.4.2 on i686 2.4.10-pre5.  Options used
     -v /usr/src/linux-2.4.10-pre5/vmlinux (specified)
     -k /proc/ksyms (default)
     -L (specified)
     -O (specified)
     -m /boot/System.map-2.4.10-pre5 (specified)

Unable to handle kernel paging request at virtual address 46454c22
c020c444
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c020c444>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 47494c41   ebx: c9ff5a00   ecx: 11d25310   edx: c0344008
esi: 46454c22   edi: 560a2254   ebp: c0344000   esp: c664fef4
ds: 0018   es: 0018   ss: 0018
Process dnetc (pid: 1210, stackpage=c664f000)
Stack: 00000001 c9ff5a00 00000010 c9ff5a00 c0344004 c0344008 00000000 
c1359818 
       00000010 00000000 c0229922 c9ff5a00 00000010 00000001 c1359800 
00000000 
       00000020 c0206b69 c9ff5a00 c9ff5a00 00000000 00000020 c037f4a0 
c0206a26 
Call Trace: [<c0229922>] [<c0206b69>] [<c0206a26>] [<c0119e70>] [<c0119d4a>] 
   [<c0119ad3>] [<c0108785>] [<c0106e2c>] 
Code: f3 a5 a8 02 74 02 66 a5 a8 01 74 01 a4 8b 54 24 14 8b 02 50 

>>EIP; c020c444 <scsi_io_completion+88/370>   <=====
Trace; c0229922 <rw_intr+152/15c>
Trace; c0206b68 <scsi_finish_command+a4/b0>
Trace; c0206a26 <scsi_bottom_half_handler+ce/e4>
Trace; c0119e70 <bh_action+4c/8c>
Trace; c0119d4a <tasklet_hi_action+6e/9c>
Trace; c0119ad2 <do_softirq+82/e0>
Trace; c0108784 <do_IRQ+d4/e4>
Trace; c0106e2c <ret_from_intr+0/6>
Code;  c020c444 <scsi_io_completion+88/370>
00000000 <_EIP>:
Code;  c020c444 <scsi_io_completion+88/370>   <=====
   0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)   <=====
Code;  c020c446 <scsi_io_completion+8a/370>
   2:   a8 02                     test   $0x2,%al
Code;  c020c448 <scsi_io_completion+8c/370>
   4:   74 02                     je     8 <_EIP+0x8> c020c44c 
<scsi_io_completion+90/370>
Code;  c020c44a <scsi_io_completion+8e/370>
   6:   66 a5                     movsw  %ds:(%esi),%es:(%edi)
Code;  c020c44c <scsi_io_completion+90/370>
   8:   a8 01                     test   $0x1,%al
Code;  c020c44e <scsi_io_completion+92/370>
   a:   74 01                     je     d <_EIP+0xd> c020c450 
<scsi_io_completion+94/370>
Code;  c020c450 <scsi_io_completion+94/370>
   c:   a4                        movsb  %ds:(%esi),%es:(%edi)
Code;  c020c450 <scsi_io_completion+94/370>
   d:   8b 54 24 14               mov    0x14(%esp,1),%edx
Code;  c020c454 <scsi_io_completion+98/370>
  11:   8b 02                     mov    (%edx),%eax
Code;  c020c456 <scsi_io_completion+9a/370>
  13:   50                        push   %eax

Kernel panic: Aiee, killing interrupt handler!
