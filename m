Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbTDPX3B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 19:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbTDPX3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 19:29:01 -0400
Received: from pgramoul.net2.nerim.net ([80.65.227.234]:11673 "EHLO
	philou.aspic.com") by vger.kernel.org with ESMTP id S261877AbTDPX26 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 19:28:58 -0400
Date: Thu, 17 Apr 2003 01:40:51 +0200
From: Philippe =?ISO-8859-15?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.67-mm3: Bad: scheduling while atomic with IEEE1394 then
 hard freeze ( lockup on CPU0)
Message-Id: <20030417014051.60f6b9b3.philippe.gramoulle@mmania.com>
In-Reply-To: <Pine.LNX.4.44.0304160951160.912-100000@cherise>
References: <20030416055402.GC15860@kroah.com>
	<Pine.LNX.4.44.0304160951160.912-100000@cherise>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.8.11claws87 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

On Wed, 16 Apr 2003 09:58:36 -0700 (PDT)
Patrick Mochel <mochel@osdl.org> wrote:

  | In short, I think we can remove the locks entirely. We can at least see 
  | what happens.. 

Reverting Andrew's patch and applying yours resulted in not being able to boot:

Captured through the serial console:

Linux version 2.5.67-mm3 (root@test) (gcc version 3.2.3 20030407 (Debian prerelease)) #6 SMP Thu Apr 17 01:26:22 CEST 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map: 
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff77000 (usable)
 BIOS-e820: 000000001ff77000 - 000000001ff79000 (ACPI NVS)
 BIOS-e820: 000000001ff79000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
511MB LOWMEM available.         
found SMP MP-table at 000fe710  
hm, page 000fe000 reserved twice.
hm, page 000ff000 reserved twice.
hm, page 000f0000 reserved twice.
On node 0 totalpages: 130935    
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126839 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: DELL     Product ID: WS 530       APIC at: 0xFEE00000
Processor #0 15:1 APIC version 20
Processor #1 15:1 APIC version 20
I/O APIC #2 Version 32 at 0xFEC00000.
Enabling APIC mode:  Cluster.  Using 1 I/O APICs
Processors: 2                   
Building zonelist for node : 0  
Kernel command line: root=/dev/sda2 console=tty1 console=ttyS1,9600n8 elevator=as nmi_watchdog=1
Initializing CPU#0              
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1495.331 MHz processor.
Console: colour VGA+ 80x25      
Calibrating delay loop... 2949.12 BogoMIPS
Memory: 513740k/523740k available (2622k kernel code, 9232k reserved, 768k data, 348k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
bad: scheduling while atomic!
Call Trace:
 [<c011cccb>] schedule+0x53b/0x540
 [<c02535f6>] poke_blanked_console+0x56/0x70
 [<c02528c4>] vt_console_print+0x214/0x300
 [<c02369ac>] rwsem_down_write_failed+0xac/0x160
 [<c0105000>] _stext+0x0/0x70
 [<c023611a>] .text.lock.kobject+0x26/0x6c
 [<c0235ea7>] kset_init+0x17/0x30
 [<c023600c>] subsystem_register+0x1c/0x30
 [<c01737ae>] register_filesystem+0xae/0xd0
 [<c0462b35>] sysfs_init+0x15/0x60
 [<c04621bb>] fs_subsys_init+0xb/0x40
 [<c0105000>] _stext+0x0/0x70
 [<c0462440>] mnt_init+0xe0/0x110
 [<c0461fb6>] vfs_caches_init+0xa6/0xd0
 [<c01579a0>] filp_ctor+0x0/0x50
 [<c01579f0>] filp_dtor+0x0/0x40
 [<c0452918>] start_kernel+0x148/0x1d0
 [<c0452500>] unknown_bootoption+0x0/0x110

bad: scheduling while atomic!
Call Trace:
 [<c011cccb>] schedule+0x53b/0x540
 [<c02528c4>] vt_console_print+0x214/0x300
 [<c02369ac>] rwsem_down_write_failed+0xac/0x160
 [<c0105000>] _stext+0x0/0x70
 [<c023611a>] .text.lock.kobject+0x26/0x6c
 [<c0235ea7>] kset_init+0x17/0x30
 [<c023600c>] subsystem_register+0x1c/0x30
 [<c01737ae>] register_filesystem+0xae/0xd0
 [<c0462b35>] sysfs_init+0x15/0x60
 [<c04621bb>] fs_subsys_init+0xb/0x40
 [<c0105000>] _stext+0x0/0x70
 [<c0462440>] mnt_init+0xe0/0x110
 [<c0461fb6>] vfs_caches_init+0xa6/0xd0
 [<c01579a0>] filp_ctor+0x0/0x50
 [<c01579f0>] filp_dtor+0x0/0x40
 [<c0452918>] start_kernel+0x148/0x1d0
 [<c0452500>] unknown_bootoption+0x0/0x110

Unable to handle kernel paging request at virtual address f000ad96
 printing eip:
c011c944
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c011c944>]    Not tainted VLI
EFLAGS: 00010046
EIP is at schedule+0x1b4/0x540
eax: 00000000   ebx: 00000001   ecx: 00000000   edx: f000ad1e
esi: ffffffe0   edi: c044df40   ebp: c0451efc   esp: c0451ec4
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c0450000 task=c03f2c60)
Stack: c03a2aa0 00000001 00000001 c04d0fc0 c03f2ae0 c0451f08 c02528c4 00000000 
       c00bb5c0 0000003a c03f2c60 00000040 c03f2c60 00000002 c0451f2c c02369ac 
       0000003b c0451f28 00000048 00000048 d0001174 c03f2c60 00000002 c03fa7b4 
Call Trace:
 [<c02528c4>] vt_console_print+0x214/0x300
 [<c02369ac>] rwsem_down_write_failed+0xac/0x160
 [<c0105000>] _stext+0x0/0x70
 [<c023611a>] .text.lock.kobject+0x26/0x6c
 [<c0235ea7>] kset_init+0x17/0x30
 [<c023600c>] subsystem_register+0x1c/0x30
 [<c01737ae>] register_filesystem+0xae/0xd0
 [<c0462b35>] sysfs_init+0x15/0x60
 [<c04621bb>] fs_subsys_init+0xb/0x40
 [<c0105000>] _stext+0x0/0x70
 [<c0462440>] mnt_init+0xe0/0x110
 [<c0461fb6>] vfs_caches_init+0xa6/0xd0
 [<c01579a0>] filp_ctor+0x0/0x50
 [<c01579f0>] filp_dtor+0x0/0x40
 [<c0452918>] start_kernel+0x148/0x1d0
 [<c0452500>] unknown_bootoption+0x0/0x110

Code: e0 39 55 d8 8b 48 10 0f 84 05 02 00 00 8b 45 d8 f0 0f b3 48 78 bb 01 00 00 00 89 c8 c1 e0 05 89 98 04 da 44 c0 89 90 00 da 44 c0 <f0> 0f ab 4a 78 8b 42 10 05 00 00 00 40 0f 22 d8 8b 5d d8 8b 82 

I'm back to 2.5.67-mm3 with original patch for now.

Thanks,

Philippe

--

Philippe Gramoullé
philippe.gramoulle@mmania.com
Lycos Europe - NOC France


