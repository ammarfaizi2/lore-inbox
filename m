Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129555AbQJ2VRz>; Sun, 29 Oct 2000 16:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129556AbQJ2VRp>; Sun, 29 Oct 2000 16:17:45 -0500
Received: from db0bm.automation.fh-aachen.de ([193.175.144.197]:46089 "EHLO
	db0bm.ampr.org") by vger.kernel.org with ESMTP id <S129555AbQJ2VRh>;
	Sun, 29 Oct 2000 16:17:37 -0500
Date: Sun, 29 Oct 2000 22:17:28 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200010292117.WAA02364@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.4.0-test10-pre6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This oops is not a new one .. I've it for quite a long time.
It always happens when starting a hamradio program called 'ulistd'.
There is not any problem at all with this program and the 2.2.17 or 2.2.18prex
The system is frozen. I can access the 'magic keys'.


My configuration is Pentium 200MMX / 64Mb SDRAM with :
------------------------------------------------------
Linux debian-f5ibh 2.4.0-test10 #1 ven oct 27 14:11:33 CEST 2000 i586 unknown
Kernel modules         2.3.19
Gnu C                  2.95.2
Binutils               2.9.5.0.41
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.11
Procps                 2.0.6
Mount                  2.10o
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         parport_pc lp parport mousedev usb-uhci hid usbcore input autofs4 rtc serial isa-pnp unix


This is the raw oops :
----------------------
Unable to handle kernel paging request at virtual address fffffffc
 printing eip:
c0113f83
*pde = 00001063
Oops: 0000
CPU: 0
EIP: 0010:[<c0113f83>]
EFLAGS: 00010013
eax: fffffff8 ebx: c133acc0 ecx: c0dd8f68 edx: 00000001
esi: c3e6b760 edi: 00000000 ebp: c01e3f40 esp: c01e3f20
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 0, stackpage = c01e3000)
Stack: c133acc0 c3e6b760 c02136dc c0dd8f6c 00000246 00000000 00000001 00000021
       c01e3fa4 c017be75 c133acc0 c017b75f c133acc0 00000000 c017c2e3 c3e6b760
	Call Trace: [<c017be75>] [<c017b75f>] [<c017c2e3>] [<c017de13>] [<c0119650>] [<c010a161> [<c0107120>]
                    [<ffffe000>] [<c0108e40>] [<c0107120>] [<ffffe000>] [<c0107148>] [<c01071a7>] [<00105000>] [<c0100192>]
Code: 8b 48 04 8b 3f 8b 11 89 d0 24 df 85 45 fc 74 e4 8b 5d fc 21
Aiee, killing interrupt handler.
Kernel panic: Attempted to kill the idle task!
In interrupt handler - not syncing.


And this is the oops processed by ksymoops :
--------------------------------------------
ksymoops 2.3.4 on i586 2.4.0-test10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test10/ (default)
     -m /boot/System.map-2.4.0-test10 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address fffffffc
c0113f83
*pde = 00001063
Oops: 0000
CPU: 0
EIP: 0010:[<c0113f83>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010013
eax: fffffff8 ebx: c133acc0 ecx: c0dd8f68 edx: 00000001
esi: c3e6b760 edi: 00000000 ebp: c01e3f40 esp: c01e3f20
ds: 0018 es: 0018 ss: 0018
Stack: c133acc0 c3e6b760 c02136dc c0dd8f6c 00000246 00000000 00000001 00000021
       c01e3fa4 c017be75 c133acc0 c017b75f c133acc0 00000000 c017c2e3 c3e6b760
        Call Trace: [<c017be75>] [<c017b75f>] [<c017c2e3>] [<c017de13>] [<c0119650>] [<c010a161> [<c0107120>]
                    [<ffffe000>] [<c0108e40>] [<c0107120>] [<ffffe000>] [<c0107148>] [<c01071a7>] [<00105000>] [<c0100192>]
Code: 8b 48 04 8b 3f 8b 11 89 d0 24 df 85 45 fc 74 e4 8b 5d fc 21

>>EIP; c0113f83 <__wake_up+57/130>   <=====
Trace; c017be75 <sock_def_write_space+2d/74>
Trace; c017b75f <sock_wfree+17/30>
Trace; c017c2e3 <__kfree_skb+7f/114>
Trace; c017de13 <net_tx_action+4f/b0>
Trace; c0119650 <do_softirq+40/64>
Trace; c010a161 <do_IRQ+a1/b0>
Trace; c0107120 <default_idle+0/28>
Trace; ffffe000 <END_OF_CODE+3b79d901/????>
Trace; c0108e40 <ret_from_intr+0/20>
Trace; c0107120 <default_idle+0/28>
Trace; ffffe000 <END_OF_CODE+3b79d901/????>
Trace; c0107148 <poll_idle+0/20>
Trace; c01071a7 <cpu_idle+3f/54>
Trace; 00105000 Before first symbol
Trace; c0100192 <L6+0/2>
Code;  c0113f83 <__wake_up+57/130>
00000000 <_EIP>:
Code;  c0113f83 <__wake_up+57/130>   <=====
   0:   8b 48 04                  mov    0x4(%eax),%ecx   <=====
Code;  c0113f86 <__wake_up+5a/130>
   3:   8b 3f                     mov    (%edi),%edi
Code;  c0113f88 <__wake_up+5c/130>
   5:   8b 11                     mov    (%ecx),%edx
Code;  c0113f8a <__wake_up+5e/130>
   7:   89 d0                     mov    %edx,%eax
Code;  c0113f8c <__wake_up+60/130>
   9:   24 df                     and    $0xdf,%al
Code;  c0113f8e <__wake_up+62/130>
   b:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c0113f91 <__wake_up+65/130>
   e:   74 e4                     je     fffffff4 <_EIP+0xfffffff4> c0113f77 <__wake_up+4b/130>
Code;  c0113f93 <__wake_up+67/130>
  10:   8b 5d fc                  mov    0xfffffffc(%ebp),%ebx
Code;  c0113f96 <__wake_up+6a/130>
  13:   21 00                     and    %eax,(%eax)

Aiee, killing interrupt handler.
Kernel panic: Attempted to kill the idle task!

1 warning issued.  Results may not be reliable.

---
Regards
		jean-luc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
