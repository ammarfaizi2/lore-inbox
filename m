Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287630AbSAUSGE>; Mon, 21 Jan 2002 13:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287645AbSAUSFy>; Mon, 21 Jan 2002 13:05:54 -0500
Received: from web13802.mail.yahoo.com ([216.136.175.12]:31237 "HELO
	web13802.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S287630AbSAUSFs>; Mon, 21 Jan 2002 13:05:48 -0500
Message-ID: <20020121180544.47743.qmail@web13802.mail.yahoo.com>
Date: Mon, 21 Jan 2002 10:05:44 -0800 (PST)
From: Vasu Vuppala <vasu_vuppala@yahoo.com>
Subject: random oops crashes
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1713791435-1011636344=:47621"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1713791435-1011636344=:47621
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Our firewall has been crashing a lot recently; it had
been working fine for months. We replaced it with another
machine but the problem remains. So it is definitely not a hardware
issue. The crashes are very random. The machine would run
for weeks without any crash but then will crash 10-15
times in a day. 

ksymoops indicates that the crash always occurs at
the same function (_free_pages) and instruction 
(lock decl 0x14(%ecx)). ksymoops output is attached.

The machine has minimal software on it. It only runs:
sshd, crond, klogd, mingetty, syslogd, apart from kernel 
daemons and init. It uses iptables for NAT.

Info about the machine:
  Distribution: Red Hat 7.1
  Kernel: 2.4.2-2smp

 The two PCs that were used: Dell Dimension L667r, and DigiLink.
  Processor: Pentium III
  Memory: 128MB

Can anyone tell us what the problem is.
Plese let me know if you need more information.

Thank you.
  
- vasu

__________________________________________________
Do You Yahoo!?
Send FREE video emails in Yahoo! Mail!
http://promo.yahoo.com/videomail/
--0-1713791435-1011636344=:47621
Content-Type: text/plain; name="k4.txt"
Content-Description: k4.txt
Content-Disposition: inline; filename="k4.txt"

ksymoops 2.4.0 on i686 2.4.2-2smp.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2-2smp/ (default)
     -m /boot/System.map-2.4.2-2smp (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01bba60, System.map says c015d2a0.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says c882ec60, /lib/modules/2.4.2-2smp/kernel/drivers/usb/usbcore.o says c882e780.  Ignoring /lib/modules/2.4.2-2smp/kernel/drivers/usb/usbcore.o entry
Unable to handle kernel paging request at virtual address d70f589b
c0133c32
Oops: 0002
CPU:    0
EIP:    0010:[<c0133c32>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: d70f5887   ebx: 00000001   ecx: d70f5887   edx: 00000000
esi: c1397bc0   edi: c4d36980   ebp: c4d36880   esp: c0293ccc
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0293000)
Stack: c01c49fe c4d36980 c1397bc0 c01c5025 c1397bc0 00000060 c1397bc0 c425fc00
       00000000 c7dffc20 c01c8738 c1397bc0 00000002 0000003c c1397bc0 c7dffc20
       c01cc696 c0292000 0000003c c1397bc0 c7dffc20 c01cc716 c1397bc0 c425fc00
Call Trace: [<c01c49fe>] [<c01c5025>] [<c01c8738>] [<c01cc696>] [<c01cc716>] [<c
01dce20>] [<c01cea2e>]
       [<c01dcecb>] [<c01dce20>] [<c01ced33>] [<c01dce20>] [<c01ced6a>] [<c01da3
       [<c8845740>] [<c01da427>] [<c01ced6a>] [<c01da348>] [<c01da3b0>] [<c01d94
       [<c01d9350>] [<c01ced6a>] [<c01f62f4>] [<c01c8a2c>] [<c01d9196>] [<c01d93
       [<c01c8ebb>] [<c010aa1e>] [<c011d51b>] [<c010ac65>] [<c0107290>] [<c01072
       [<c0107290>] [<c01072bc>] [<c0107342>] [<c0105000>] [<c01001cf>]
Code: f0 ff 49 14 0f 94 c0 84 c0 74 07 89 c8 e9 9c f5 ff ff c3 8d

>>EIP; c0133c32 <__free_pages+2/20>   <=====
Trace; c01c49fe <skb_release_data+4e/80>
Trace; c01c5025 <skb_linearize+c5/130>
Trace; c01c8738 <dev_queue_xmit+a8/2b0>
Trace; c01cc696 <neigh_resolve_output+f6/1f0>
Trace; c01cc716 <neigh_resolve_output+176/1f0>
Code;  c0133c32 <__free_pages+2/20>
00000000 <_EIP>:
Code;  c0133c32 <__free_pages+2/20>   <=====
   0:   f0 ff 49 14               lock decl 0x14(%ecx)   <=====
Code;  c0133c36 <__free_pages+6/20>
   4:   0f 94 c0                  sete   %al
Code;  c0133c39 <__free_pages+9/20>
   7:   84 c0                     test   %al,%al
Code;  c0133c3b <__free_pages+b/20>
   9:   74 07                     je     12 <_EIP+0x12> c0133c44 <__free_pages+14/20>
Code;  c0133c3d <__free_pages+d/20>
   b:   89 c8                     mov    %ecx,%eax
Code;  c0133c3f <__free_pages+f/20>
   d:   e9 9c f5 ff ff            jmp    fffff5ae <_EIP+0xfffff5ae> c01331e0 <__free_pages_ok+0/380>
Code;  c0133c44 <__free_pages+14/20>
  12:   c3                        ret    
Code;  c0133c45 <__free_pages+15/20>
  13:   8d 00                     lea    (%eax),%eax

Kernel panic: Aiee, killing interrupt handler!

4 warnings issued.  Results may not be reliable.

--0-1713791435-1011636344=:47621--
