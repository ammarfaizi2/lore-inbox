Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318552AbSHUSRt>; Wed, 21 Aug 2002 14:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318601AbSHUSRt>; Wed, 21 Aug 2002 14:17:49 -0400
Received: from dsl-213-023-006-207.arcor-ip.net ([213.23.6.207]:36362 "HELO
	is1.blocksberg.com") by vger.kernel.org with SMTP
	id <S318552AbSHUSRs> convert rfc822-to-8bit; Wed, 21 Aug 2002 14:17:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Justin Heesemann <jh@ionium.org>
Organization: ionium Technologies
To: linux-kernel@vger.kernel.org
Subject: Re: shared graphic ram hangs kernel since 2.4.3-ac1
Date: Wed, 21 Aug 2002 20:25:00 +0200
User-Agent: KMail/1.4.2
References: <200208201527.51649.jh@ionium.org> <200208211529.56917.jh@ionium.org> <1029938920.26425.47.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1029938920.26425.47.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208212025.00276.jh@ionium.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 August 2002 16:08, Alan Cox wrote:

> Shared graphic ram shouldnt in theory ever be causing hangs. The BIOS
> E820 memory reporting should be excluding any video reserved memory from
> its reporting. For the i810/845 its fractionally more complex once we go
> into X11 (we allocate from the AGP pool ourselves) but not in console
> mode.

Well.. how ever the problem I have does exist. whether it's because of the 
shared ram or not.
When i add the option mem=512M (which simply ignores the fact of the 1MB 
shared ram), i get this kernel panic with 2.4.19-pre6 (which is booting fine 
with mem=511M):

Linux version 2.4.19-pre6 (root@lux) (gcc version 2.95.3 20010315 (release)) 
#52
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000a0000 - 000000001fef0000 (reserved)
 BIOS-e820: 000000001fef0000 - 000000001fef3000 (ACPI NVS)
 BIOS-e820: 000000001fef3000 - 000000001ff00000 (ACPI data)
On node 0 totalpages: 131072
zone(0): 4096 pages.
zone(1): 126976 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=test ro root=304 mem=512M console=ttyS0,9600
Initializing CPU#0
Detected 2019.980 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4023.91 BogoMIPS
Memory: 516460k/524288k available (1045k kernel code, 7440k reserved, 326k 
data)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 12K, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) 4 CPU 2.00GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfae70, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/24c0] at 00:1f.0
PCI: Found IRQ 10 for device 00:1f.1
PCI: Sharing IRQ 10 with 00:02.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Unable to handle kernel NULL pointer dereference at virtual address 00000003
 printing eip:
c013c543
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c013c543>]    Not tainted
EFLAGS: 00010246
eax: ffffffff   ebx: c1588420   ecx: dffaa9d0   edx: c1588430
esi: 00000002   edi: dfee7060   ebp: dfefdf70   esp: dfefdf18
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=dfefd000)
Stack: c1588420 c0142b08 c1588420 c1588420 dfee7060 c158be00 00000000 c0247d7c
       00000002 0000000c dfefdf60 dfefdf5c 00000002 c15883a0 c1588420 c15884a0
       c020faec 00000006 d66fc523 c020faf3 00000008 7ee58900 00000000 c013092f
Call Trace: [<c0142b08>] [<c013092f>] [<c01309e5>] [<c0130b59>] [<c010502f>]
   [<c0106ef8>]

Code: 89 50 04 89 43 10 89 4a 04 89 11 5b c3 55 57 56 53 8b 6c 24
 <0>Kernel panic: Attempted to kill init!




And since the problem definitivly seems to be in 
2.4.19-pre7/arch/i386/kernel/setup.c (pre6 one's working, well.. not with 
mem=512M but with mem=511M) do you have any idea of what I could try to do 
next ?  Could this be caused by bad hardware ? (Since everything seems to run 
so fine with 2.4.19-pre6 I don't want to believe that.. but this would make 
things a lot easier..contact the hardware vendor.. get new one :)


