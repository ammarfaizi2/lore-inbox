Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262943AbVHEJxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262943AbVHEJxL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 05:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262944AbVHEJw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 05:52:59 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:26347 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S262943AbVHEJv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 05:51:56 -0400
Message-ID: <42F336CF.7020001@uni-hd.de>
Date: Fri, 05 Aug 2005 11:52:15 +0200
From: Martin Braun <mbraun@uni-hd.de>
Reply-To: mbraun@uni-hd.de
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: oops with 2.6.13-rc5 on webserver with raid
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been trying to upgrade kernel to 2.6.13-rc5. The server boots
normally w/o errors, but after while (from 5 minutes up to 2 hours) the
Kernel hangs (no keyboard input possible). As I am a newbie I cannot
figure out who will be concerned with this error.


Here ist the ksymoops output (done while running  2.6.11.12 #1 SMP, hope
that's OK)

ksymoops -V -K -L -O -m /boot/System.map-2.6.13-rc5 < oops.txt
ksymoops 2.4.9 on i686 2.6.11.12.  Options used
     -V (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map-2.6.13-rc5 (specified)

kernel BUG at <bad filename>:27369!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0324afd>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010297   (2.6.13-rc5)
eax: 00000005   ebx: f51c3880   ecx: 00000007   edx: ebfa6c00
esi: f51c3880   edi: 00000000   ebp: 00000006   esp: c03ebda4
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 f51c3880 00000006 ebfa6c00 9daf2f89 c0324de0 ebfa6c00
ebfa6c00
       f51c3880 0000000c ebfa6c00 00000006 00000002 ebfa6c00 ebfa6c00
00000100
       f5bca034 c0324f45 ebfa6c00 000005b4 00000001 c02f4391 4740b79d
4740b79d
Call Trace:
 [<c0324de0>]
 [<c0324f45>]
 [<c02f4391>]
 [<c0321eea>]
 [<c032b60a>]
 [<c032bea1>]
 [<c0310390>]
 [<c0306cce>]
 [<c030fc5b>]
 [<c0310390>]
 [<c03102b4>]
 [<c03105a0>]
 [<c02fa2a8>]
 [<c02fa389>]
 [<c02fa4d7>]
 [<c011fa12>]
 [<c011fac5>]
 [<c010542e>]
 [<c0103726>]
 [<c0100ce5>]
 [<c0100b19>]
 [<c03ec9d5>]
 [<c03ec3b0>]
Code: 24 8b 5c 24 04 8b 74 24 08 8b 7c 24 0c 8b 6c 24 10 83 c4 14 c3 c7
04 24 0
Error (Oops_code_values): invalid value 0x0 in Code line, must be 2, 4,
8 or 16 digits, value ignored


>>EIP; c0324afd <tcp_tso_should_defer+fd/110>   <=====

>>ebx; f51c3880 <pg0+34d56880/3fb91400>
>>edx; ebfa6c00 <pg0+2bb39c00/3fb91400>
>>esi; f51c3880 <pg0+34d56880/3fb91400>
>>esp; c03ebda4 <init_thread_union+1da4/2000>

Trace; c0324de0 <tcp_write_xmit+2d0/400>
Trace; c0324f45 <__tcp_push_pending_frames+35/d0>
Trace; c02f4391 <kfree_skbmem+21/30>
Trace; c0321eea <tcp_rcv_established+39a/920>
Trace; c032b60a <tcp_v4_do_rcv+12a/150>
Trace; c032bea1 <tcp_v4_rcv+871/940>
Trace; c0310390 <ip_local_deliver_finish+0/210>
Trace; c0306cce <nf_hook_slow+6e/130>
Trace; c030fc5b <ip_local_deliver+eb/270>
Trace; c0310390 <ip_local_deliver_finish+0/210>
Trace; c03102b4 <ip_rcv+4d4/5b0>
Trace; c03105a0 <ip_rcv_finish+0/320>
Trace; c02fa2a8 <netif_receive_skb+168/1b0>
Trace; c02fa389 <process_backlog+99/130>
Trace; c02fa4d7 <net_rx_action+b7/120>
Trace; c011fa12 <__do_softirq+82/100>
Trace; c011fac5 <do_softirq+35/40>
Trace; c010542e <do_IRQ+1e/30>
Trace; c0103726 <common_interrupt+1a/20>
Trace; c0100ce5 <mwait_idle+25/50>
Trace; c0100b19 <cpu_idle+69/80>
Trace; c03ec9d5 <start_kernel+175/1a0>
Trace; c03ec3b0 <unknown_bootoption+0/1e0>

Code;  c0324afd <tcp_tso_should_defer+fd/110>
00000000 <_EIP>:
Code;  c0324afd <tcp_tso_should_defer+fd/110>   <=====
   0:   24 8b                     and    $0x8b,%al   <=====
Code;  c0324aff <tcp_tso_should_defer+ff/110>
   2:   5c                        pop    %esp
Code;  c0324b00 <tcp_tso_should_defer+100/110>
   3:   24 04                     and    $0x4,%al
Code;  c0324b02 <tcp_tso_should_defer+102/110>
   5:   8b 74 24 08               mov    0x8(%esp),%esi
Code;  c0324b06 <tcp_tso_should_defer+106/110>
   9:   8b 7c 24 0c               mov    0xc(%esp),%edi
Code;  c0324b0a <tcp_tso_should_defer+10a/110>
   d:   8b 6c 24 10               mov    0x10(%esp),%ebp
Code;  c0324b0e <tcp_tso_should_defer+10e/110>
  11:   83 c4 14                  add    $0x14,%esp
Code;  c0324b11 <tcp_write_xmit+1/400>
  14:   c3                        ret
Code;  c0324b12 <tcp_write_xmit+2/400>
  15:   c7 04 24 00 00 00 00      movl   $0x0,(%esp)

 <0>Kernel panic - not syncing: Fatal exception in interrupt

1 error issued.  Results may not be reliable.

=====
lspci
=====
0000:00:00.0 Host bridge: Intel Corp. E7320 Memory Controller Hub (rev 0c)
0000:00:00.1 Class ff00: Intel Corp. E7320 Error Reporting Registers
(rev 0c)
0000:00:02.0 PCI bridge: Intel Corp. E7525/E7520/E7320 PCI Express Port
A (rev 0c)
0000:00:03.0 PCI bridge: Intel Corp. E7525/E7520/E7320 PCI Express Port
A1 (rev 0c)
0000:00:1c.0 PCI bridge: Intel Corp. 6300ESB 64-bit PCI-X Bridge (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 6300ESB USB Universal Host
Controller (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 6300ESB USB Universal Host
Controller (rev 02)
0000:00:1d.4 System peripheral: Intel Corp. 6300ESB Watchdog Timer (rev 02)
0000:00:1d.5 PIC: Intel Corp. 6300ESB I/O Advanced Programmable
Interrupt Controller (rev 02)
0000:00:1d.7 USB Controller: Intel Corp. 6300ESB USB2 Enhanced Host
Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 0a)
0000:00:1f.0 ISA bridge: Intel Corp. 6300ESB LPC Interface Controller
(rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 6300ESB PATA Storage Controller
(rev 02)
0000:00:1f.3 SMBus: Intel Corp. 6300ESB SMBus Controller (rev 02)
0000:04:02.0 VGA compatible controller: ATI Technologies Inc Rage XL
(rev 27)
0000:04:03.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit
Ethernet Controller (rev 05)
0000:04:05.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)

=================
cat /proc/cpuinfo  (first cpu-output)
=================
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 2.80GHz
stepping        : 1
cpu MHz         : 2794.772
cache size      : 1024 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm
pni monitor ds_cpl cid cx16 xtpr
bogomips        : 5521.40

===================
cat /proc/scsi/scsi
===================
Attached devices:
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: easyRAID Model:  F6P             Rev: 0001
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: HP       Model: DLT VS80         Rev: 5C3F
  Type:   Sequential-Access                ANSI SCSI revision: 02


The Server is used as Webserver w/ Apache2/Tomcat/PHP/Samba.

thx.
martin


