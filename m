Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285060AbSCFXGe>; Wed, 6 Mar 2002 18:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284732AbSCFXGZ>; Wed, 6 Mar 2002 18:06:25 -0500
Received: from web9904.mail.yahoo.com ([216.136.129.247]:30983 "HELO
	web9904.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S284264AbSCFXGR>; Wed, 6 Mar 2002 18:06:17 -0500
Message-ID: <20020306230616.45503.qmail@web9904.mail.yahoo.com>
Date: Wed, 6 Mar 2002 15:06:16 -0800 (PST)
From: Beef Arrowny <tanfhltu@yahoo.com>
Subject: Kernel Oops in 2.4.18 (ide.c)
To: linux-kernel@vger.kernel.org
Cc: tanfhltu@yahoo.com, axboe@suse.de, andre@suse.com, andre@linux-ide.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I've got all the right info, but here goes:

I'm trying to get my RICOH MP6200A CD-RW to work on
this new machine I just built.  I've gotten it to work
in the past, but it's always been blind luck.  This is
the first time I've gotten an oops however.

When I boot up, I get the following relevant messages:
.
.
.
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
PCI_IDE: unknown IDE controller on PCI bus 00 device
39, VID=1022, DID=7441
PCI_IDE: chipset revision 4
PCI_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings:
hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings:
hdc:DMA, hdd:DMA
hda: MAXTOR 6L020J1, ATA DISK drive
hdc: ATAPI CD-ROM DRIVE 36X MAXIMUM, ATAPI CD/DVD-ROM
drive
hdd:
, ATAPI cdrom or floppy?, assuming FLOPPY drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
.
.
.
 I'm used to seeing the ATAPI cdrom or floppy? message
in the past... later in the boot process, the ide-scsi
module detects it properly.  here's where it kicks in:
.
.
.
scsi0 : SCSI host adapter emulation for IDE ATAPI
devices
ide1: unexpected interrupt, status=0x58, count=1
  Vendor: RICOH     Model: MP6200A           Rev: 2.20
  Type:   CD-ROM                             ANSI SCSI
revision: 00
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0,
lun 0
sr0: scsi-1 drive
..
.

The unexpected interrupt message is new.. I've never
seen that before.  When I login, i type 'eject sr0'
and i get the following:

nable to handle kernel NULL pointer dereference at
virtual address 00000000
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c01d80c6>]    Not tainted
EFLAGS: 00010002
eax: 00003400   ebx: c0389a34   ecx: 00006868   edx:
00000170
esi: 00000000   edi: 00000000   ebp: c0389a34   esp:
dffe1ec0
ds: 0018   es: 0018   ss: 0018
Process swapper Cpid: 0, stackpage=dffe1000)
Stack: 0000d0d1 c0389a34 00000000 c0389a34 c01d817e
c0389a34 00000000 00003434
       c1846140 dfef3500 0000d0d0 e08286ab c0389a34
00000000 0000d0d0 c0389a34
       c186bcc0 00000292 c03898d0 d0000002 c0389a58
c01d9bf1 c0389a34 dffe9880
Call Trace: [<c01d817e>] [<e08286ab>] [<c01d9bf1>]
[<c08284c0>] [<c0108961>]
   [<c0108ba6>] [<c0105400>] [<c0105400>] [<c010ae78>]
[<c0105400>] [<c0105400>]
   [<c010542c>] [<c01054a2>] [<c0118baf>] [<c0118abf>]
Code: f3 66 6f 5b 5e 5f 5d c3 89 f6 57 56 53 8b 7c 24
10 8b 87 c8
  <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

Then it locks up hard.  After resetting, I get the
same messages as before, except for when the ide-scsi
module loads, which displays this:

scsi0 : SCSI host adapter emulation for IDE ATAPI
devices
ide-scsi: CoD != 0 in idescsi_pc_intr
ide1: unexpected interrupt, status=0x00, count=1
hdd: ATAPI reset complete
ide-scsi: CoD != 0 in idescsi_pc_intr
hdd: ATAPI reset complete
scsi: unknown type 18
  Vendor:           Model:                   Rev:
  Type:   Unknown                            ANSI SCSI
revision: 00
Attached scsi generic sg0 at scsi0, channel 0, id 0,
lun 0,  type 18
resize_dma_pool: unknown device type 18
.
.
.

So now it doesn't know it's a RICOH anymore...
however, if i totally power down the machine, wait a
few minutes, and boot back up, it'll see it again.

Here's the output of ksymoops on the oops message:

ksymoops 2.4.4 on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /usr/src/linux/System.map (default)
Warning: You did not tell me where to find symbol
information.  I will
assume that the log matches the kernel and modules
that are running
right now and I'll use the default options above for
symbol resolution.
If the current kernel and/or modules do not match the
log, you can get
more accurate output by telling me the kernel version
and where to find
map, modules, ksyms etc.  ksymoops -h explains the
options.
Warning (compare_maps): ksyms_base symbol
destroy_8023_client_R__ver_destroy_802
3_client not found in System.map.  Ignoring ksyms_base
entry
Warning (compare_maps): ksyms_base symbol
destroy_EII_client_R__ver_destroy_EII_
client not found in System.map.  Ignoring ksyms_base
entry
Warning (compare_maps): ksyms_base symbol
hotplug_path_R__ver_hotplug_path not f
ound in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
ltalk_setup_R__ver_ltalk_setup not fou
nd in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
make_8023_client_R__ver_make_8023_client not found in
System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
make_EII_client_R__ver_make_EII_client
 not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
netlink_attach_R__ver_netlink_attach n
ot found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
netlink_detach_R__ver_netlink_detach n
ot found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
netlink_post_R__ver_netlink_post not f
ound in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
pci_add_new_bus_R__ver_pci_add_new_bus
 not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
pci_announce_device_to_drivers_R__ver_
pci_announce_device_to_drivers not found in
System.map.  Ignoring ksyms_base ent
ry
Warning (compare_maps): ksyms_base symbol
pci_do_scan_bus_R__ver_pci_do_scan_bus
 not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
pci_insert_device_R__ver_pci_insert_de
vice not found in System.map.  Ignoring ksyms_base
entry
Warning (compare_maps): ksyms_base symbol
pci_proc_attach_bus_R__ver_pci_proc_at
tach_bus not found in System.map.  Ignoring ksyms_base
entry
Warning (compare_maps): ksyms_base symbol
pci_proc_attach_device_R__ver_pci_proc
_attach_device not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
pci_proc_detach_bus_R__ver_pci_proc_detach_bus not
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
pci_proc_detach_device_R__ver_pci_proc
_detach_device not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): ksyms_base symbol
pci_remove_device_R__ver_pci_remove_de
vice not found in System.map.  Ignoring ksyms_base
entry
Warning (compare_maps): ksyms_base symbol
pci_scan_slot_R__ver_pci_scan_slot not
 found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
pci_setup_device_R__ver_pci_setup_devi
ce not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
pcmcia_lookup_bus_R__ver_pcmcia_lookup
_bus not found in System.map.  Ignoring ksyms_base
entry
Warning (compare_maps): ksyms_base symbol
scsi_logging_level_R__ver_scsi_logging
_level not found in System.map.  Ignoring ksyms_base
entry
Warning (compare_maps): ksyms_base symbol
sk_chk_filter_R__ver_sk_chk_filter not
 found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol
sk_run_filter_R__ver_sk_run_filter not
 found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at
virtual address 00000000
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c01d80c6>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00003400   ebx: c0389a34   ecx: 00006868   edx:
00000170
esi: 00000000   edi: 00000000   ebp: c0389a34   esp:
dffe1ec0
ds: 0018   es: 0018   ss: 0018
Process swapper Cpid: 0, stackpage=dffe1000)
Stack: 0000d0d1 c0389a34 00000000 c0389a34 c01d817e
c0389a34 00000000 00003434
       c1846140 dfef3500 0000d0d0 e08286ab c0389a34
00000000 0000d0d0 c0389a34
       c186bcc0 00000292 c03898d0 d0000002 c0389a58
c01d9bf1 c0389a34 dffe9880
Call Trace: [<c01d817e>] [<e08286ab>] [<c01d9bf1>]
[<c08284c0>] [<c0108961>]
   [<c0108ba6>] [<c0105400>] [<c0105400>] [<c010ae78>]
[<c0105400>] [<c0105400>]
   [<c010542c>] [<c01054a2>] [<c0118baf>] [<c0118abf>]
Code: f3 66 6f 5b 5e 5f 5d c3 89 f6 57 56 53 8b 7c 24
10 8b 87 c8
>>EIP; c01d80c6 <ide_output_data+a6/b0>   <=====
Trace; c01d817e <atapi_output_bytes+3e/70>
Trace; e08286ab <[ide-scsi]idescsi_pc_intr+1eb/240>
Trace; c01d9bf1 <ide_intr+121/190>
Trace; c08284c0 <_end+48d6dc/2048221c>
Trace; c0108961 <handle_IRQ_event+1/80>
Trace; c0108ba6 <do_IRQ+a6/f0>
Trace; c0105400 <default_idle+0/40>
Trace; c0105400 <default_idle+0/40>
Trace; c010ae78 <call_do_IRQ+5/d>
Trace; c0105400 <default_idle+0/40>
Trace; c0105400 <default_idle+0/40>
Trace; c010542c <default_idle+2c/40>
Trace; c01054a2 <cpu_idle+42/60>
Trace; c0118baf <release_console_sem+8f/a0>
Trace; c0118abf <printk+11f/140>
Code;  c01d80c6 <ide_output_data+a6/b0>
00000000 <_EIP>:
Code;  c01d80c6 <ide_output_data+a6/b0>   <=====
   0:   f3 66 6f                  repz outsw
%ds:(%esi),(%dx)   <=====
Code;  c01d80c9 <ide_output_data+a9/b0>
   3:   5b                        popl   %ebx
Code;  c01d80ca <ide_output_data+aa/b0>
   4:   5e                        popl   %esi
Code;  c01d80cb <ide_output_data+ab/b0>
   5:   5f                        popl   %edi
Code;  c01d80cc <ide_output_data+ac/b0>
   6:   5d                        popl   %ebp
Code;  c01d80cd <ide_output_data+ad/b0>
   7:   c3                        ret
Code;  c01d80ce <ide_output_data+ae/b0>
   8:   89 f6                     movl   %esi,%esi
Code;  c01d80d0 <atapi_input_bytes+0/70>
   a:   57                        pushl  %edi
Code;  c01d80d1 <atapi_input_bytes+1/70>
   b:   56                        pushl  %esi
Code;  c01d80d2 <atapi_input_bytes+2/70>
   c:   53                        pushl  %ebx
Code;  c01d80d3 <atapi_input_bytes+3/70>
   d:   8b 7c 24 10               movl  
0x10(%esp,1),%edi
Code;  c01d80d7 <atapi_input_bytes+7/70>
  11:   8b 87 c8 00 00 00         movl  
0xc8(%edi),%eax
  <0>Kernel panic: Aiee, killing interrupt handler!
25 warnings issued.  Results may not be reliable.
.
.
.

I hope I've provided enough information.  I tried to
follow the oops-tracing.txt file, but couldn't follow
it well :/  If anything more is needed, let me know
and I will provide it.

Please CC me on responses as I don't subscribe to this
list anymore.

Regards,
Toby


__________________________________________________
Do You Yahoo!?
Try FREE Yahoo! Mail - the world's greatest free email!
http://mail.yahoo.com/
