Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262933AbUDBEZV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 23:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263142AbUDBEZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 23:25:21 -0500
Received: from lakemtao02.cox.net ([68.1.17.243]:24567 "EHLO
	lakemtao02.cox.net") by vger.kernel.org with ESMTP id S262933AbUDBEXf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 23:23:35 -0500
Date: Thu, 1 Apr 2004 18:27:34 -0500
From: Chris Shoemaker <chris.shoemaker@cox.net>
To: linux-kernel@vger.kernel.org
Subject: [2.6.4] Bad swap file entry, then kernel BUG at mm/shmem.c:475
Message-ID: <20040401232734.GB8061@cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Description: 
Content-Disposition: inline; filename="report.txt"

[2.6.4] Bad swap file entry, then kernel BUG at mm/shmem.c:475
And, occasional oopses with 2.6.4, and 2.4.24-1.

    I installed Debian (sarge) a few weeks ago, and it came with
kernel 2.4.24-1.  It was my first time with Debian, so I was mostly
poking around with the Debian-specific management tools.  The kernel
oopsed a few times, but since I don't have any baseline of what to
expect from Debian binary kernels, I decided to get a vanilla 2.6.4
for myself.

    It's been a couple of weeks ago now since I compiled 2.6.4, and
I've had probably had oopses or BUGs every day or so since then.
Twice, it oopsed during bootup, but usually I'm running X, and the
symptom is simply a hard lockup.

    I've been pulling the oopses out of the logs and looking for
patterns, but every oops seems so different.  With so much variety of
oopses, (plus the fact that 2.4.24-1 had oopsed), I began to suspect
bad RAM, even though the machine has served me well for several years,
and I haven't found evidence of off-by-bit errors.  However, 2 days
running memtest86 with all tests, gave no errors.  (BTW, does anyone
have a suggestion of a more rigorous general hardware stress-test for
detecting flakiness?)  If my hardware is bad it's pretty intermittent
(I can go days with no problem) and doesn't seem to be as stressed by
other OSes.  I'd be reassured in my investigation if someone could
tell me that at least one of my oopses is definitely _not_ bad
hardware.

    I don't see the common trait among the oopses, but I'm pretty new
to this type of search, so I thought I would post (down below) just a
couple of them (just ask if you want more) and see if anyone can point
me in the right direction.  I realize that if it's not my hardware,
then the oopses from 2.4.24-1 and 2.6.4 are probably unrelated and
don't belong in the same post, but just in case...

    I also realize 2.6.4 isn't the bleeding edge newest, but I didn't
see any csets since then that looked like they'd fix my problems.  I'm
willing to test patches, and I can provide any additional info
requested.

    Sorry for the long post, and thanks for reading.  It's all
cut-n-pastes from here on, with a few interspersed observations.
Please cc me; I'm not subscribed.

Thanks,
Chris Shoemaker


    Ok, for starters here's one I call:
[2.6.4] Bad swap file entry, then kernel BUG at mm/shmem.c:475

<snipped a dozen or so more of these swap_free: Bad swap file entry>

 swap_free: Bad swap file entry 3c000000
 swap_free: Bad swap file entry 100026be
 ------------[ cut here ]------------
 kernel BUG at mm/shmem.c:475!
 invalid operand: 0000 [#1]
 PREEMPT DEBUG_PAGEALLOC
 CPU:    0
 EIP:    0060:[shmem_truncate+1225/1904]    Not tainted
 EFLAGS: 00013282
 EIP is at shmem_truncate+0x4c9/0x770
 eax: 0000002e   ebx: c10757d8   ecx: 06797000   edx: fffffff7
 esi: 00000000   edi: cb3c0000   ebp: c67c5e54   esp: c67c5e00
 ds: 007b   es: 007b   ss: 0068
 Process XFree86 (pid: 1107, threadinfo=c67c4000 task=c67df9e0)
 Stack: c67c5ebc c02bb587 00013540 c67c5ec8 00003286 c2d66d4c 00000000 c67c4000 
        00000000 00000000 00000000 00080000 00000037 00000000 cb3cddc8 cb3cde3c 
        406356f9 18145460 cbff99a0 cb3cde3c cb3cddc8 c67c5e84 c01706d0 00000000 
 Call Trace:
  [sock_sendmsg+199/208] sock_sendmsg+0xc7/0xd0
  [shmem_delete_inode+688/848] shmem_delete_inode+0x2b0/0x350
  [shmem_delete_inode+0/848] shmem_delete_inode+0x0/0x350
  [generic_delete_inode+244/816] generic_delete_inode+0xf4/0x330
  [filp_dtor+0/400] filp_dtor+0x0/0x190
  [iput+86/112] iput+0x56/0x70
  [dput+503/1824] dput+0x1f7/0x720
  [__fput+186/288] __fput+0xba/0x120
  [__fput+194/288] __fput+0xc2/0x120
  [unmap_vma+117/128] unmap_vma+0x75/0x80
  [unmap_vma_list+26/48] unmap_vma_list+0x1a/0x30
  [do_munmap+461/688] do_munmap+0x1cd/0x2b0
  [rcu_process_callbacks+405/592] rcu_process_callbacks+0x195/0x250
  [timer_interrupt+378/1008] timer_interrupt+0x17a/0x3f0
  [sys_shmdt+193/336] sys_shmdt+0xc1/0x150
  [tasklet_action+67/112] tasklet_action+0x43/0x70
  [sys_ipc+672/736] sys_ipc+0x2a0/0x2e0
  [__fput+194/288] __fput+0xc2/0x120
  [profile_hook+28/48] profile_hook+0x1c/0x30
  [syscall_call+7/11] syscall_call+0x7/0xb
 
 Code: 0f 0b db 01 06 45 34 c0 e9 16 fd ff ff 8b 55 e4 8b 42 5c e8 
  <6>note: XFree86[1107] exited with preempt_count 1
 Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
 in_atomic():1, irqs_disabled():0
 Call Trace:
  [__might_sleep+172/224] __might_sleep+0xac/0xe0
  [profile_exit_task+35/96] profile_exit_task+0x23/0x60
  [do_exit+117/2480] do_exit+0x75/0x9b0
  [die+594/608] die+0x252/0x260
  [search_exception_tables+37/48] search_exception_tables+0x25/0x30
  [do_invalid_op+0/160] do_invalid_op+0x0/0xa0
  [do_invalid_op+154/160] do_invalid_op+0x9a/0xa0
  [shmem_truncate+1225/1904] shmem_truncate+0x4c9/0x770
  [swap_free+39/80] swap_free+0x27/0x50
  [error_code+45/56] error_code+0x2d/0x38
  [release_pages+555/928] release_pages+0x22b/0x3a0
  [shmem_truncate+1225/1904] shmem_truncate+0x4c9/0x770
  [sock_sendmsg+199/208] sock_sendmsg+0xc7/0xd0
  [shmem_delete_inode+688/848] shmem_delete_inode+0x2b0/0x350
  [shmem_delete_inode+0/848] shmem_delete_inode+0x0/0x350
  [generic_delete_inode+244/816] generic_delete_inode+0xf4/0x330
  [filp_dtor+0/400] filp_dtor+0x0/0x190
  [iput+86/112] iput+0x56/0x70
  [dput+503/1824] dput+0x1f7/0x720
  [__fput+186/288] __fput+0xba/0x120
  [__fput+194/288] __fput+0xc2/0x120
  [unmap_vma+117/128] unmap_vma+0x75/0x80
  [unmap_vma_list+26/48] unmap_vma_list+0x1a/0x30
  [do_munmap+461/688] do_munmap+0x1cd/0x2b0
  [rcu_process_callbacks+405/592] rcu_process_callbacks+0x195/0x250
  [timer_interrupt+378/1008] timer_interrupt+0x17a/0x3f0
  [sys_shmdt+193/336] sys_shmdt+0xc1/0x150
  [tasklet_action+67/112] tasklet_action+0x43/0x70
  [sys_ipc+672/736] sys_ipc+0x2a0/0x2e0
  [__fput+194/288] __fput+0xc2/0x120
  [profile_hook+28/48] profile_hook+0x1c/0x30
  [syscall_call+7/11] syscall_call+0x7/0xb
 
 bad: scheduling while atomic!
 Call Trace:
  [schedule+2311/2320] schedule+0x907/0x910
  [rwsem_down_read_failed+300/592] rwsem_down_read_failed+0x12c/0x250
  [syscall_call+7/11] syscall_call+0x7/0xb
  [dump_stack+23/32] dump_stack+0x17/0x20
  [.text.lock.exit+107/215] .text.lock.exit+0x6b/0xd7
  [die+594/608] die+0x252/0x260
  [search_exception_tables+37/48] search_exception_tables+0x25/0x30
  [do_invalid_op+0/160] do_invalid_op+0x0/0xa0
  [do_invalid_op+154/160] do_invalid_op+0x9a/0xa0
  [shmem_truncate+1225/1904] shmem_truncate+0x4c9/0x770
  [swap_free+39/80] swap_free+0x27/0x50
  [error_code+45/56] error_code+0x2d/0x38
  [release_pages+555/928] release_pages+0x22b/0x3a0
  [shmem_truncate+1225/1904] shmem_truncate+0x4c9/0x770
  [sock_sendmsg+199/208] sock_sendmsg+0xc7/0xd0
  [shmem_delete_inode+688/848] shmem_delete_inode+0x2b0/0x350
  [shmem_delete_inode+0/848] shmem_delete_inode+0x0/0x350
  [generic_delete_inode+244/816] generic_delete_inode+0xf4/0x330
  [filp_dtor+0/400] filp_dtor+0x0/0x190
  [iput+86/112] iput+0x56/0x70
  [dput+503/1824] dput+0x1f7/0x720
  [__fput+186/288] __fput+0xba/0x120
  [__fput+194/288] __fput+0xc2/0x120
  [unmap_vma+117/128] unmap_vma+0x75/0x80
  [unmap_vma_list+26/48] unmap_vma_list+0x1a/0x30
  [do_munmap+461/688] do_munmap+0x1cd/0x2b0
  [rcu_process_callbacks+405/592] rcu_process_callbacks+0x195/0x250
  [timer_interrupt+378/1008] timer_interrupt+0x17a/0x3f0
  [sys_shmdt+193/336] sys_shmdt+0xc1/0x150
  [tasklet_action+67/112] tasklet_action+0x43/0x70
  [sys_ipc+672/736] sys_ipc+0x2a0/0x2e0
  [__fput+194/288] __fput+0xc2/0x120
  [profile_hook+28/48] profile_hook+0x1c/0x30
  [syscall_call+7/11] syscall_call+0x7/0xb
 
 swap_free: Bad swap file entry 34000000
 swap_free: Bad swap file entry 1800269e


<snipped another BUG at mm/shmem.c:475! immediately following and not
so different from above>


[And here's one from Debian's 2.4.24-1:]

 Unable to handle kernel paging request at virtual address cc046080
  printing eip:
 c012af63
 *pde = 00000000
 Oops: 0002
 CPU:    0
 EIP:    0010:[kmem_cache_free_one+48/145]    Not tainted
 EFLAGS: 00010046
 eax: 20ffffff   ebx: cbffcdc4   ecx: c3e46000   edx: 00000000
 esi: 0208001a   edi: c3e46a80   ebp: c10a5b1c   esp: cbc77f10
 ds: 0018   es: 0018   ss: 0018
 Process kswapd (pid: 4, stackpage=cbc77000)
 Stack: 00000202 c3e46a80 c3e46a80 c012aa00 cbffcdc4 c3e46a80 c3e46a80 c0133b65 
        cbffcdc4 c3e46a80 c01356da c3e46a80 c3e46a80 00000000 c10a5b1c 0000001b 
        000001d0 c012b4ba c10a5b1c 000001d0 00000c80 00001cd0 c023c978 00000020 
 Call Trace:    
[kmem_cache_free+17/23] [__put_unused_buffer_head+41/85]
 [try_to_free_buffers+94/207] [shrink_cache+450/780] [shrink_caches+46/55]
   [try_to_free_pages_zone+67/193] [kswapd_balance_pgdat+74/145]
 [kswapd_balance+20/40] [kswapd+148/173] [rest_init+0/39]
 [arch_kernel_thread+35/45] [kswapd+0/173]
 
 Code: 89 44 b1 18 8b 51 10 8d 42 ff 85 c0 89 71 14 89 41 10 75 23 


  <1>Unable to handle kernel paging request at virtual address cc046018
  printing eip:
 c012af63
 *pde = 00000000
 Oops: 0002
 CPU:    0
 EIP:    0010:[kmem_cache_free_one+48/145]    Not tainted
 EFLAGS: 00013046
 eax: 20ffffff   ebx: cbffcdc4   ecx: c3e46000   edx: 00000000
 esi: 02080000   edi: c3e460c0   ebp: c1096d68   esp: c91addf0
 ds: 0018   es: 0018   ss: 0018
 Process XFree86 (pid: 990, stackpage=c91ad000)
 Stack: 00003202 c3e460c0 c3e460c0 c012aa00 cbffcdc4 c3e460c0 c3e460c0 c0133b65 
        cbffcdc4 c3e460c0 c01356da c3e460c0 c3e460c0 00000000 c1096d68 00000004 
        000001d2 c012b4ba c1096d68 000001d2 00000c80 00001cfd c023c978 00000020 
 Call Trace:    [kmem_cache_free+17/23] [__put_unused_buffer_head+41/85]
 [try_to_free_buffers+94/207] [shrink_cache+450/780] [shrink_caches+46/55]
   [try_to_free_pages_zone+67/193] [balance_classzone+65/446]
 [__alloc_pages+321/504] [do_anonymous_page+64/214]
 [handle_mm_fault+82/183] [do_page_fault+311/1018]
   [af_packet:__insmod_af_packet_O/lib/modules/2.4.24-1-386/kernel/net/pa+-1114493/96][restore_sigcontext+268/293] [sys_sigreturn+155/194]
 [do_page_fault+0/1018] [error_code+52/60]
 
 Code: 89 44 b1 18 8b 51 10 8d 42 ff 85 c0 89 71 14 89 41 10 75 23 
  


  Again, just ask if you want more, they're all special in their own way! :)



Just for completeness, and in case it's relevent, I have also attached
a file containing the following, from the 2.6.4 configuration.  Some
stuff (like the module info) would obviously be slightly different in
the 2.4.24-1 configuration (ask if you want that, too):

[7.1.] Software (add the output of the ver_linux script here)
[7.2.] Processor information (from /proc/cpuinfo):
[7.3.] Module information (from /proc/modules):
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
[7.5.] PCI information ('lspci -vvv' as root)
[7.6.] SCSI information (from /proc/scsi/scsi)
[7.7.] My .config



--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Description: environment.txt
Content-Disposition: attachment; filename="environment.txt"


[7.1.] Software (add the output of the ver_linux script here)

Gnu C                  3.3.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre10
e2fsprogs              1.35
pcmcia-cs              3.2.5
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.0
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         apm md5 ipv6 ipt_REJECT iptable_filter af_packet uhci_hcd usbcore 3c59x agpgart 8250 serial_core parport_pc lp parport nls_iso8859_1 nls_cp437 vfat fat nls_base evdev psmouse ide_cd sr_mod cdrom ip_tables sd_mod aic7xxx scsi_mod rtc unix


[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Celeron (Coppermine)
stepping        : 10
cpu MHz         : 1002.440
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1982.46


[7.3.] Module information (from /proc/modules):
apm 23136 1 - Live 0xcc9d7000
md5 4480 1 - Live 0xcc94e000
ipv6 277632 8 - Live 0xcc962000
ipt_REJECT 7040 2 - Live 0xcc94b000
iptable_filter 3200 1 - Live 0xcc868000
af_packet 28936 2 - Live 0xcc940000
uhci_hcd 47116 0 - Live 0xcc933000
usbcore 134108 3 uhci_hcd, Live 0xcc911000
3c59x 41768 0 - Live 0xcc956000
agpgart 32320 0 - Live 0xcc900000
8250 41824 0 - Live 0xcc8f4000
serial_core 31232 1 8250, Live 0xcc8eb000
parport_pc 40768 1 - Live 0xcc8d3000
lp 13192 0 - Live 0xcc8ce000
parport 48840 2 parport_pc,lp, Live 0xcc8c1000
nls_iso8859_1 4480 4 - Live 0xcc8b7000
nls_cp437 6144 4 - Live 0xcc8b4000
vfat 18560 4 - Live 0xcc8ae000
fat 53152 1 vfat, Live 0xcc8a0000
nls_base 9600 4 nls_iso8859_1,nls_cp437,vfat,fat, Live 0xcc8bd000
evdev 10112 0 - Live 0xcc879000
psmouse 19080 0 - Live 0xcc89a000
ide_cd 41860 0 - Live 0xcc8df000
sr_mod 18596 0 - Live 0xcc90b000
cdrom 39072 2 ide_cd,sr_mod, Live 0xcc885000
ip_tables 22400 2 ipt_REJECT,iptable_filter, Live 0xcc872000
sd_mod 16800 2 - Live 0xcc86c000
aic7xxx 227840 1 - Live 0xcca2d000
scsi_mod 134200 3 sr_mod,sd_mod,aic7xxx, Live 0xcc846000
rtc 23260 0 - Live 0xcc87e000
unix 33200 280 - Live 0xcc890000


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0213-0213 : ISAPnP
0290-0297 : pnp 00:0f
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
b800-b83f : 0000:00:0c.0
  b800-b83f : 0000:00:0c.0
d000-d0ff : 0000:00:0a.0
d400-d41f : 0000:00:04.2
  d400-d41f : uhci_hcd
d800-d80f : 0000:00:04.1
  d800-d807 : ide0
e400-e43f : pnp 00:0f
e800-e83f : pnp 00:0f

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c8000-000cdfff : Extension ROM
000f0000-000fffff : System ROM
00100000-0bffcfff : System RAM
  00100000-00325cd3 : Kernel code
  00325cd4-003f257f : Kernel data
0bffd000-0bffefff : ACPI Tables
0bfff000-0bffffff : ACPI Non-volatile Storage
df000000-df000fff : 0000:00:0a.0
  df000000-df000fff : aic7xxx
df800000-e0efffff : PCI Bus #01
  df800000-dfffffff : 0000:01:00.0
  e0000000-e0003fff : 0000:01:00.0
e1000000-e1ffffff : 0000:00:0b.0
e2f00000-e3ffffff : PCI Bus #01
  e3000000-e3ffffff : 0000:01:00.0
e4000000-e7ffffff : 0000:00:00.0
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
 
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000e000-0000dfff
        Memory behind bridge: df800000-e0efffff
        Prefetchable memory behind bridge: e2f00000-e3ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+
 
00:04.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
 
00:04.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d800 [size=16]
 
00:04.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at d400 [size=32]
 
00:04.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
 
00:0a.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 2000ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 4
        Region 0: I/O ports at d000 [disabled] [size=256]
        Region 1: Memory at df000000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
 
00:0b.0 Multimedia video controller: 3Dfx Interactive, Inc. Voodoo (rev 02)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at e1000000 (32-bit, prefetchable) [size=16M]
 
00:0c.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 15
        Region 0: I/O ports at b800 [size=64]
        Expansion ROM at <unassigned> [disabled] [size=64K]
 
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2164W [Millennium II] AGP (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc.: Unknown device 1000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 15
        Region 0: Memory at e3000000 (32-bit, prefetchable) [size=16M]
        Region 1: Memory at e0000000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at df800000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at e2ff0000 [disabled] [size=64K]
        Capabilities: [f0] AGP version 1.0
                Status: RQ=1 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=<none>
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>


[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SEAGATE  Model: ST32550N         Rev: 0016
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: YAMAHA   Model: CRW4260          Rev: 1.0q
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: PIONEER  Model: DVD-ROM DVD-U02  Rev: 1.06
  Type:   CD-ROM                           ANSI SCSI revision: 02


[7.7.] Other information that might be relevant to the problem
#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_HOTPLUG=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_EMBEDDED=y
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMII=y
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
# CONFIG_HPET_EMULATE_RTC is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
# CONFIG_X86_MCE is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_MATH_EMULATION=y
CONFIG_MTRR=y
CONFIG_EFI=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_BOOT_IOREMAP=y
CONFIG_REGPARM=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_DISK=y
CONFIG_PM_DISK_PARTITION=""

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_ASUS=m
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=m
CONFIG_APM_IGNORE_USER_SUSPEND=y
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y
CONFIG_APM_ALLOW_INTS=y
CONFIG_APM_REAL_MODE_POWER_OFF=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_USE_VECTOR=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_FW_LOADER=m
CONFIG_DEBUG_DRIVER=y

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_OTHER=y
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
CONFIG_PNP=y
CONFIG_PNP_DEBUG=y

#
# Protocols
#
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
CONFIG_PNPBIOS_PROC_FS=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDEDISK_STROKE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPNP=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_IDEDMA_ONLYDISK=y
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_IVB=y
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=m
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_CHR_DEV_OSST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_REPORT_LUNS=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
CONFIG_AIC7XXX_DEBUG_ENABLE=y
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=m
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Macintosh device drivers
#

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_UNIX=m
CONFIG_NET_KEY=m
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_ARPD=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m

#
# IP: Virtual Server Configuration
#
CONFIG_IP_VS=m
CONFIG_IP_VS_DEBUG=y
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_TUNNEL=m
CONFIG_DECNET=m
CONFIG_DECNET_SIOCGIFCONF=y
CONFIG_DECNET_ROUTER=y
CONFIG_DECNET_ROUTE_FWMARK=y
CONFIG_BRIDGE=m
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_BRIDGE_NETFILTER=y

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_PHYSDEV=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_COMPAT_IPFWADM=m

#
# IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_TARGET_MARK=m

#
# DECnet: Netfilter Configuration
#
CONFIG_DECNET_NF_GRABULATOR=m

#
# Bridge: Netfilter Configuration
#
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_XFRM=y
CONFIG_XFRM_USER=m

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=m
CONFIG_IP_SCTP=m
CONFIG_SCTP_DBG_MSG=y
CONFIG_SCTP_DBG_OBJCNT=y
CONFIG_SCTP_HMAC_NONE=y
# CONFIG_SCTP_HMAC_SHA1 is not set
# CONFIG_SCTP_HMAC_MD5 is not set
# CONFIG_ATM is not set
CONFIG_VLAN_8021Q=m
CONFIG_LLC=m
CONFIG_LLC2=m
CONFIG_IPX=m
CONFIG_IPX_INTERN=y
CONFIG_ATALK=m
CONFIG_DEV_APPLETALK=y
CONFIG_LTPC=m
CONFIG_COPS=m
CONFIG_COPS_DAYNA=y
CONFIG_COPS_TANGENT=y
CONFIG_IPDDP=m
CONFIG_IPDDP_ENCAP=y
CONFIG_IPDDP_DECAP=y
CONFIG_X25=m
CONFIG_LAPB=m
CONFIG_NET_DIVERT=y
CONFIG_ECONET=m
CONFIG_ECONET_AUNUDP=y
CONFIG_ECONET_NATIVE=y
CONFIG_WAN_ROUTER=m
CONFIG_NET_FASTROUTE=y
CONFIG_NET_HW_FLOWCONTROL=y

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
CONFIG_EL3=m
# CONFIG_3C515 is not set
CONFIG_VORTEX=m
# CONFIG_TYPHOON is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_TULIP=m
CONFIG_TULIP_MWI=y
CONFIG_TULIP_MMIO=y
CONFIG_TULIP_NAPI=y
CONFIG_TULIP_NAPI_HW_MITIGATION=y
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input I/O drivers
#
CONFIG_GAMEPORT=m
CONFIG_SOUND_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_VORTEX is not set
# CONFIG_GAMEPORT_FM801 is not set
# CONFIG_GAMEPORT_CS461x is not set
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_UINPUT=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=m
CONFIG_SERIAL_8250_ACPI=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_DETECT_IRQ=y
CONFIG_SERIAL_8250_MULTIPORT=y
CONFIG_SERIAL_8250_RSA=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=m
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=m
# CONFIG_TIPAR is not set

#
# Mice
#
CONFIG_BUSMOUSE=m
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_HW_RANDOM=m
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_GEN_RTC=m
CONFIG_GEN_RTC_X=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
CONFIG_AGP_ALI=m
CONFIG_AGP_ATI=m
CONFIG_AGP_AMD=m
CONFIG_AGP_AMD64=m
CONFIG_AGP_INTEL=m
CONFIG_AGP_NVIDIA=m
CONFIG_AGP_SIS=m
CONFIG_AGP_SWORKS=m
CONFIG_AGP_VIA=m
CONFIG_AGP_EFFICEON=m
CONFIG_DRM=y
CONFIG_DRM_TDFX=m
CONFIG_DRM_GAMMA=m
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
CONFIG_DRM_I810=m
CONFIG_DRM_I830=m
CONFIG_DRM_MGA=m
CONFIG_DRM_SIS=m
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HANGCHECK_TIMER=m

#
# I2C support
#
CONFIG_I2C=y
# CONFIG_I2C_CHARDEV is not set

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
# CONFIG_I2C_ALGOPCF is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_ELEKTOR is not set
# CONFIG_I2C_ELV is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_ISA is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PHILIPSPAR is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VELLEMAN is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set

#
# I2C Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=y

#
# Video For Linux
#

#
# Video Adapters
#
# CONFIG_VIDEO_BT848 is not set
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5246A is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_SAA7134 is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DPC is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_CX88 is not set

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_SF16FMR2 is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
CONFIG_FB_VGA16=m
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
CONFIG_FB_I810=m
CONFIG_FB_I810_GTF=y
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_MILLENIUM=y
CONFIG_FB_MATROX_MYSTIQUE=y
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_MAVEN=m
CONFIG_FB_MATROX_MULTIHEAD=y
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
CONFIG_FB_VIRTUAL=m

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_MDA_CONSOLE=m
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=m
CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_FONT_6x11=y
CONFIG_FONT_PEARL_8x8=y
CONFIG_FONT_ACORN_8x8=y
CONFIG_FONT_MINI_4x6=y
CONFIG_FONT_SUN8x16=y
CONFIG_FONT_SUN12x22=y

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_MEMORY=y
CONFIG_SND_DEBUG_DETECT=y

#
# Generic devices
#
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m

#
# ISA devices
#
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES968 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
CONFIG_SND_SBAWE=m
CONFIG_SND_SB16_CSP=y
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_DT019X is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=m
CONFIG_USB_DEBUG=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=m

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=m
# CONFIG_USB_BLUETOOTH_TTY is not set
CONFIG_USB_MIDI=m
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_VICAM is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_KONICAWC is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_STV680 is not set
# CONFIG_USB_W9968CF is not set

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_TEST is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
CONFIG_REISERFS_CHECK=y
CONFIG_REISERFS_PROC_INFO=y
CONFIG_JFS_FS=m
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_DEBUG=y
CONFIG_JFS_STATISTICS=y
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=m
CONFIG_XFS_RT=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_SECURITY=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_MINIX_FS=m
CONFIG_ROMFS_FS=m
CONFIG_QUOTA=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=m
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_NTFS_FS=m
CONFIG_NTFS_DEBUG=y
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_CIFS=m
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
CONFIG_AFS_FS=m
CONFIG_RXRPC=m

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_LDM_PARTITION=y
CONFIG_LDM_DEBUG=y
# CONFIG_NEC98_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Native Language Support
#
CONFIG_NLS=m
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Profiling support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=m

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_EARLY_PRINTK is not set
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=m
CONFIG_SECURITY_ROOTPLUG=m
# CONFIG_SECURITY_SELINUX is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_TEST=m

#
# Library routines
#
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
CONFIG_X86_BIOS_REBOOT=y

--CUfgB8w4ZwR/yMy5--
