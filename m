Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264847AbSJaLB4>; Thu, 31 Oct 2002 06:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264849AbSJaLB4>; Thu, 31 Oct 2002 06:01:56 -0500
Received: from ulima.unil.ch ([130.223.144.143]:50309 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S264847AbSJaLBv>;
	Thu, 31 Oct 2002 06:01:51 -0500
Date: Thu, 31 Oct 2002 12:08:16 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: 2.5.45 : kernel BUG at kernel/workqueue.c:69! (ISDN?)
Message-ID: <20021031110816.GE16875@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got this:

serio: i8042 KBD port at 0x60,0x64 irq 1
ISDN subsystem initialized
PPP BSD Compression module registered
HiSax: Linux Driver for passive ISDN cards
HiSax: Version 3.5 (kernel)
HiSax: Layer1 Revision 2.41.6.5
HiSax: Layer2 Revision 2.25.6.4
HiSax: TeiMgr Revision 2.17.6.3
HiSax: Layer3 Revision 2.17.6.5
HiSax: LinkLayer Revision 2.51.6.6
HiSax: Approval certification failed because of
HiSax: unauthorized source code changes
get_drv 0: 0 -> 1
HiSax: Card 1 Protocol NONE Id=HiSax (0)
HiSax: AVM PCI driver Rev. 1.22.6.6
FritzPnP: no ISA PnP present 
AVM PCI: stat 0x2020a
AVM PCI: Class A Rev 2
HiSax: AVM Fritz!PCI config irq:16 base:0xB800  
AVM PCI: ISAC version (0): 2086/2186 V1.1
AVM Fritz PnP/PCI: IRQ 16 count 0
get_drv 0: 1 -> 2
put_drv 0: 2 -> 1
get_drv 0: 1 -> 2
put_drv 0: 2 -> 1
get_drv 0: 1 -> 2
put_drv 0: 2 -> 1
get_drv 0: 1 -> 2
put_drv 0: 2 -> 1
get_drv 0: 1 -> 2
put_drv 0: 2 -> 1
------------[ cut here ]------------
kernel BUG at kernel/workqueue.c:69!
invalid operand: 0000

CPU:    0
EIP:    0060:[<c0129775>]    Not tainted
EFLAGS: 00010213
eax: 00000000   ebx: dff8e000   ecx: c03c90d4   edx: c17e3958
esi: c17e3958   edi: c17e395c   ebp: dffa2280   esp: dff8febc
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 1, threadinfo=dff8e000 task=dff8c080)
Stack: 00000004 c17e3000 dff8e000 00000000 c0413bfa c17e3000 00000002 00000052
       c17e3000 00000003 c02e7018 c17e3000 00000003 c17e30be c17e3000 c04127ff
       c17e3000 000000f2 00000000 c03ad64b c17e3000 c17e3000 dff8ff92 c17e30be
Call Trace: [<c02e7018>]  [<c011ba65>]  [<c010506f>]  [<c0105032>]  [<c01055a1>]
Code: 0f 0b 45 00 32 32 38 c0 eb 8b 90 83 ec 10 89 7c 24 08 89 1c
 <0>Kernel panic: Attempted to kill init!
Debug: sleeping function called from illegal context at include/linux/rwsem.h:43
Call Trace: [<c016339a>]  [<c01633d9>]  [<c0147985>]  [<c011afec>]  [<c011ece0>]  [<c0108506>]  [<c01083c5>]  [<c010856d>]  [<c0129775>]  [<c02d7e54>]  [<c021cc3b>]  [<c0107e59>]  [<c02d0068>]  [<c0129775>]  [<c02e7018>]  [<c011ba65>]  [<c010506f>]  [<c0105032>]  [<c01055a1>]

which gives with ksymoops -m /usr/src/linux-2.5/System.map -v /usr/src/linux-2.5/vmlinux -K -L -O:

ksymoops 2.4.5 on i686 2.4.20-pre10.  Options used
     -v /usr/src/linux-2.5/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /usr/src/linux-2.5/System.map (specified)

kernel BUG at kernel/workqueue.c:69!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c0129775>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010213
eax: 00000000   ebx: dff8e000   ecx: c03c90d4   edx: c17e3958
esi: c17e3958   edi: c17e395c   ebp: dffa2280   esp: dff8febc
ds: 0068   es: 0068   ss: 0068
Stack: 00000004 c17e3000 dff8e000 00000000 c0413bfa c17e3000 00000002 00000052 
       c17e3000 00000003 c02e7018 c17e3000 00000003 c17e30be c17e3000 c04127ff 
       c17e3000 000000f2 00000000 c03ad64b c17e3000 c17e3000 dff8ff92 c17e30be 
Call Trace: [<c02e7018>]  [<c011ba65>]  [<c010506f>]  [<c0105032>]  [<c01055a1>] 
Code: 0f 0b 45 00 32 32 38 c0 eb 8b 90 83 ec 10 89 7c 24 08 89 1c 


>>EIP; c0129775 <queue_work+91/9c>   <=====

>>ebx; dff8e000 <END_OF_CODE+1fadd3ec/????>
>>ecx; c03c90d4 <console_sem+0/10>
>>edx; c17e3958 <END_OF_CODE+1332d44/????>
>>esi; c17e3958 <END_OF_CODE+1332d44/????>
>>edi; c17e395c <END_OF_CODE+1332d48/????>
>>ebp; dffa2280 <END_OF_CODE+1faf166c/????>
>>esp; dff8febc <END_OF_CODE+1fadf2a8/????>

Trace; c02e7018 <AVM_card_msg+6a/d0>
Trace; c011ba65 <release_console_sem+cb/ce>
Trace; c010506f <init+3d/15a>
Trace; c0105032 <init+0/15a>
Trace; c01055a1 <kernel_thread_helper+5/c>

Code;  c0129775 <queue_work+91/9c>
00000000 <_EIP>:
Code;  c0129775 <queue_work+91/9c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0129777 <queue_work+93/9c>
   2:   45                        inc    %ebp
Code;  c0129778 <queue_work+94/9c>
   3:   00 32                     add    %dh,(%edx)
Code;  c012977a <queue_work+96/9c>
   5:   32 38                     xor    (%eax),%bh
Code;  c012977c <queue_work+98/9c>
   7:   c0 eb 8b                  shr    $0x8b,%bl
Code;  c012977f <queue_work+9b/9c>
   a:   90                        nop    
Code;  c0129780 <delayed_work_timer_fn+0/86>
   b:   83 ec 10                  sub    $0x10,%esp
Code;  c0129783 <delayed_work_timer_fn+3/86>
   e:   89 7c 24 08               mov    %edi,0x8(%esp,1)
Code;  c0129787 <delayed_work_timer_fn+7/86>
  12:   89 1c 00                  mov    %ebx,(%eax,%eax,1)

 <0>Kernel panic: Attempted to kill init!
Call Trace: [<c016339a>]  [<c01633d9>]  [<c0147985>]  [<c011afec>]  [<c011ece0>]  [<c0108506>]  [<c01083c5>]  [<c010856d>]  [<c0129775>]  [<c02d7e54>]  [<c021cc3b>]  [<c0107e59>]  [<c02d0068>]  [<c0129775>]  [<c02e7018>]  [<c011ba65>]  [<c010506f>]  [<c0105032>]  [<c01055a1>] 
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c016339a <get_super_to_sync+80/aa>
Trace; c01633d9 <sync_inodes+15/90>
Trace; c0147985 <sys_sync+1b/32>
Trace; c011afec <panic+100/106>
Trace; c011ece0 <complete_and_exit+0/1c>
Trace; c0108506 <do_invalid_op+0/6e>
Trace; c01083c5 <die+87/8e>
Trace; c010856d <do_invalid_op+67/6e>
Trace; c0129775 <queue_work+91/9c>
Trace; c02d7e54 <VHiSax_putstatus+19a/218>
Trace; c021cc3b <vsnprintf+20d/460>
Trace; c0107e59 <error_code+2d/38>
Trace; c02d0068 <ipppd_write+22/1a4>
Trace; c0129775 <queue_work+91/9c>
Trace; c02e7018 <AVM_card_msg+6a/d0>
Trace; c011ba65 <release_console_sem+cb/ce>
Trace; c010506f <init+3d/15a>
Trace; c0105032 <init+0/15a>
Trace; c01055a1 <kernel_thread_helper+5/c>

lspci -v:
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 11)
        Flags: bus master, fast devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [e4] #09 [a104]
        Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 11) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 32
        Bus: primary=00, secondary=01, subordinate=02, sec-latency=32
        Memory behind bridge: dec00000-dfdfffff
        Prefetchable memory behind bridge: da800000-de9fffff

00:1d.0 USB Controller: Intel Corp.: Unknown device 24c2 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Micro-star International Co Ltd: Unknown device 3982
        Flags: bus master, medium devsel, latency 0, IRQ 16
        I/O ports at d800 [size=32]

00:1d.1 USB Controller: Intel Corp.: Unknown device 24c4 (rev 01) (prog-if 00 [UHCI])
        Subsystem: Micro-star International Co Ltd: Unknown device 3982
        Flags: bus master, medium devsel, latency 0, IRQ 19
        I/O ports at dc00 [size=32]

00:1d.7 USB Controller: Intel Corp.: Unknown device 24cd (rev 01) (prog-if 20 [EHCI])
        Subsystem: Micro-star International Co Ltd: Unknown device 3981
        Flags: bus master, medium devsel, latency 0, IRQ 23
        Memory at dfffbc00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 81) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: dfe00000-dfefffff
        Prefetchable memory behind bridge: dea00000-deafffff

00:1f.0 ISA bridge: Intel Corp.: Unknown device 24c0 (rev 01)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: Micro-star International Co Ltd: Unknown device 3982
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at <unassigned> [size=8]
        I/O ports at <unassigned> [size=4]
        I/O ports at <unassigned> [size=8]
        I/O ports at <unassigned> [size=4]
        I/O ports at fc00 [size=16]
        Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp.: Unknown device 24c3 (rev 01)
        Subsystem: Micro-star International Co Ltd: Unknown device 3982
        Flags: medium devsel, IRQ 17
        I/O ports at 0c00 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp.: Unknown device 24c5 (rev 01)
        Subsystem: Micro-star International Co Ltd: Unknown device 3982
        Flags: bus master, medium devsel, latency 0, IRQ 17
        I/O ports at d400 [size=256]
        I/O ports at d000 [size=64]
        Memory at dffffe00 (32-bit, non-prefetchable) [size=512]
        Memory at dffffd00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (rev 01) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G550 Dual Head DDR 32Mb
        Flags: bus master, medium devsel, latency 32, IRQ 16
        Memory at dc000000 (32-bit, prefetchable) [size=32M]
        Memory at dfdfc000 (32-bit, non-prefetchable) [size=16K]
        Memory at df000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at dfdc0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
        Capabilities: [f0] AGP version 2.0

03:00.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH A1 ISDN [Fritz] (rev 02)
        Subsystem: AVM Audiovisuelles MKTG & Computer System GmbH FRITZ!Card ISDN Controller
        Flags: medium devsel, IRQ 16
        Memory at dfefefe0 (32-bit, non-prefetchable) [size=32]
        I/O ports at b800 [size=32]

03:01.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
        Subsystem: Technotrend Systemtechnik GmbH: Unknown device 0000
        Flags: bus master, medium devsel, latency 32, IRQ 17
        Memory at dfefec00 (32-bit, non-prefetchable) [size=512]

03:02.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
        Subsystem: Adaptec 29160LP Low Profile Ultra160 SCSI Controller
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 18
        BIST result: 00
        I/O ports at bc00 [disabled] [size=256]
        Memory at dfeff000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at dfec0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

03:03.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at b400 [disabled] [size=256]
        Memory at dfefd000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at dfee0000 [disabled] [size=64K]

03:04.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
        Subsystem: Technotrend Systemtechnik GmbH: Unknown device 0000
        Flags: bus master, medium devsel, latency 32, IRQ 16
        Memory at dfefea00 (32-bit, non-prefetchable) [size=512]

03:08.0 Ethernet controller: Intel Corp.: Unknown device 103a (rev 81)
        Subsystem: Intel Corp.: Unknown device 1039
        Flags: bus master, medium devsel, latency 32, IRQ 20
        Memory at dfef8000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at b000 [size=64]
        Capabilities: [dc] Power Management version 2

and ver_linux:
Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11w
mount                  2.11w
modutils               2.4.19
e2fsprogs              1.27ea
reiserfsprogs          3.6.3
xfsprogs               2.0.6
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.10
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.2

Should I tell anything else? I know that ISDN isn't working in 2.5 for
some times, (even don't compil...) but as it got some changes I wanted
to try ;-)

Thank you and have a great day,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
