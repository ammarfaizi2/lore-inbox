Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264411AbTCXVaH>; Mon, 24 Mar 2003 16:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264431AbTCXVaH>; Mon, 24 Mar 2003 16:30:07 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:31371 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S264411AbTCXVaD>;
	Mon, 24 Mar 2003 16:30:03 -0500
To: <linux-kernel@vger.kernel.org>
Subject: ifconfig crashes kernel 2.5.65 with X.25 compiled in
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 24 Mar 2003 22:34:18 +0100
Message-ID: <m3n0jkcuud.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Linux 2.5.65 (gcc 3.2 20020903 - Red Hat 8), AMD K6-2 500 MHz, 64 MB RAM,
diskless (a test machine with serial console, only lo net device).

Typing 'ifconfig' crashes the kernel if X.25 is compiled in:

(none):/# ip link
1: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue 
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00

(none):/# ifconfig 
lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

and no, I didn't feed it with a stream of "kkkkkkkkkkkkk..." :-)

Unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
c018aec2
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c018aec2>]    Not tainted
EFLAGS: 00010202
EIP is at __release_sock+0x22/0x60
eax: 6b6b6b6b   ebx: c3d06000   ecx: 00000000   edx: c3cf2bac
esi: c10ff190   edi: c10ff190   ebp: c3d07f04   esp: c3d07efc
ds: 007b   es: 007b   ss: 0068
Process ifconfig (pid: 35, threadinfo=c3d06000 task=c3ce0060)
Stack: c3d06000 c10ff1d4 c3d07f1c c01ca13a c10ff190 c10ff190 c3cef200 c10b6488 
       c3d07f44 c01ca618 c10ff190 c10ff190 00000000 00000000 00000000 c10b6488 
       c3d1d224 c10b64ac c3d07f54 c01884d1 c10b6488 c10b64ac c3d07f64 c0188b03 
Call Trace:
 [<c01ca13a>] x25_destroy_socket+0x1da/0x200
 [<c01ca618>] x25_release+0x38/0xa0
 [<c01884d1>] sock_release+0x51/0x60
 [<c0188b03>] sock_close+0x23/0x40
 [<c013a884>] __fput+0xa4/0xc0
 [<c013933b>] filp_close+0x3b/0x60
 [<c01393a7>] sys_close+0x47/0x60
 [<c010ac37>] syscall_call+0x7/0xb

Code: 8b 18 c7 00 00 00 00 00 50 56 ff 96 18 01 00 00 85 db 5a 89 
 <0>Kernel panic: Aiee, killing interrupt handler!

In interrupt handler - not syncing

intrepid:/usr/src/linux-2.5$ grep ^C .config
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_X86_PC=y
CONFIG_MK6=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_NOHIGHMEM=y
CONFIG_PCI=y
CONFIG_PCI_GODIRECT=y
CONFIG_PCI_DIRECT=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_NET=y
CONFIG_INET=y
CONFIG_IPV6_SCTP__=y
CONFIG_X25=y
CONFIG_NETDEVICES=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_EXT2_FS=y
CONFIG_PROC_FS=y
CONFIG_RAMFS=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_KALLSYMS=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_BIOS_REBOOT=y
-- 
Krzysztof Halasa
Network Administrator
