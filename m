Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312316AbSCYGCt>; Mon, 25 Mar 2002 01:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312317AbSCYGCj>; Mon, 25 Mar 2002 01:02:39 -0500
Received: from [213.196.40.44] ([213.196.40.44]:47077 "EHLO blackstar.nl")
	by vger.kernel.org with ESMTP id <S312316AbSCYGCW>;
	Mon, 25 Mar 2002 01:02:22 -0500
Date: Sun, 24 Mar 2002 23:33:19 +0100 (CET)
From: <bvermeul@devel.blackstar.nl>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.18: Oops restoring tape to ext3 filesystem
Message-ID: <Pine.LNX.4.33.0203242328170.2544-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya all,

I got an oops while restoring a tape to an ext3 filesystem.
After I rebooted (scsi tape wouldn't answer any more), and mounted
said filesystem ext2, everything seems to be in working order.

Oops:

ksymoops 0.7c on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol netlink_attach_R__ver_netlink_attach not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol netlink_detach_R__ver_netlink_detach not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol netlink_post_R__ver_netlink_post not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c0272a00, System.map says c014fe10.  Ignoring ksyms_base entry
Mar 24 22:26:19 devel kernel: Unable to handle kernel paging request at virtual address 77b8e2c4
Mar 24 22:26:19 devel kernel: c0219f97
Mar 24 22:26:19 devel kernel: *pde = 00000000
Mar 24 22:26:19 devel kernel: Oops: 0000
Mar 24 22:26:19 devel kernel: CPU:    0
Mar 24 22:26:19 devel kernel: EIP:    0010:[scsi_allocate_device+151/576]    Not tainted
Mar 24 22:26:19 devel kernel: EIP:    0010:[<c0219f97>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Mar 24 22:26:19 devel kernel: EFLAGS: 00010086
Mar 24 22:26:19 devel kernel: eax: f7bbc9cc   ebx: f7b8e200   ecx: f7bd38c4   edx: 00000000
Mar 24 22:26:19 devel kernel: esi: f7bd38c4   edi: 00000082   ebp: dad66000   esp: dad67dfc
Mar 24 22:26:19 devel kernel: ds: 0018   es: 0018   ss: 0018
Mar 24 22:26:19 devel kernel: Process restore (pid: 23059, stackpage=dad67000)
Mar 24 22:26:19 devel kernel: Stack: f7bbc9cc f73dd60c f776f2e4 f7619c00 c015c82a f7769ae4 f776f2e4 00000003 
Mar 24 22:26:19 devel kernel:        c6966080 f7770ef4 f7770f48 f7770ef4 f7770f48 c0221950 f7bd38c4 00000000 
Mar 24 22:26:19 devel kernel:        00000000 00000000 f7bbc9cc f7bd38c4 f7770ef4 dad67ec4 c2dbaa0c c0155ee0 
Mar 24 22:26:19 devel kernel: Call Trace: [journal_dirty_metadata+458/496] [scsi_request_fn+320/768] [ext3_reserve_inode_write+48/176] [__scsi_insert_special+100/112] [scsi_insert_special_req+25/32] 
Mar 24 22:26:19 devel kernel: Call Trace: [<c015c82a>] [<c0221950>] [<c0155ee0>] [<c0220f24>] [<c0220f79>] 
Mar 24 22:26:19 devel kernel:    [<c021a755>] [<c022f89b>] [<c022f6e0>] [<c0231184>] [<c0126d80>] [<c02317b0>] 
Mar 24 22:26:19 devel kernel:    [<c0132045>] [<c0106d0b>] 
Mar 24 22:26:19 devel kernel: Code: 8b 83 c4 00 00 00 40 75 f0 85 db 0f 85 b8 00 00 00 8b 4c 24 

>>EIP; c0219f97 <scsi_allocate_device+97/240>   <=====
Trace; c015c82a <journal_dirty_metadata+1ca/1f0>
Trace; c0221950 <scsi_request_fn+140/300>
Trace; c0155ee0 <ext3_reserve_inode_write+30/b0>
Trace; c0220f24 <__scsi_insert_special+64/70>
Trace; c0220f79 <scsi_insert_special_req+19/20>
Trace; c021a755 <scsi_do_req+145/170>
Trace; c022f89b <st_do_scsi+fb/140>
Trace; c022f6e0 <st_sleep_done+0/c0>
Trace; c0231184 <read_tape+104/380>
Trace; c0126d80 <generic_file_write+500/770>
Trace; c02317b0 <st_read+3b0/4d0>
Trace; c0132045 <sys_read+95/100>
Trace; c0106d0b <system_call+33/38>
Code;  c0219f97 <scsi_allocate_device+97/240>
00000000 <_EIP>:
Code;  c0219f97 <scsi_allocate_device+97/240>   <=====
   0:   8b 83 c4 00 00 00         mov    0xc4(%ebx),%eax   <=====
Code;  c0219f9d <scsi_allocate_device+9d/240>
   6:   40                        inc    %eax
Code;  c0219f9e <scsi_allocate_device+9e/240>
   7:   75 f0                     jne    fffffff9 <_EIP+0xfffffff9> c0219f90 <scsi_allocate_device+90/240>
Code;  c0219fa0 <scsi_allocate_device+a0/240>
   9:   85 db                     test   %ebx,%ebx
Code;  c0219fa2 <scsi_allocate_device+a2/240>
   b:   0f 85 b8 00 00 00         jne    c9 <_EIP+0xc9> c021a060 <scsi_allocate_device+160/240>
Code;  c0219fa8 <scsi_allocate_device+a8/240>
  11:   8b 4c 24 00               mov    0x0(%esp,1),%ecx


5 warnings issued.  Results may not be reliable.

System:

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 4
model name	: AMD Athlon(tm) Processor
stepping	: 2
cpu MHz		: 700.050
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 1395.91

Memory:

        total:    used:    free:  shared: buffers:  cached:
Mem:  1317916672 1039151104 278765568        0 12955648 962150400
Swap: 537894912        0 537894912
MemTotal:      1287028 kB
MemFree:        272232 kB
MemShared:           0 kB
Buffers:         12652 kB
Cached:         939600 kB
SwapCached:          0 kB
Active:          39056 kB
Inactive:       929412 kB
HighTotal:      393152 kB
HighFree:         2044 kB
LowTotal:       893876 kB
LowFree:        270188 kB
SwapTotal:      525288 kB
SwapFree:       525288 kB

Scsi info:

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DNES-309170W     Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: QUANTUM  Model: XP34550W         Rev: LYK8
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: QUANTUM  Model: XP34550W         Rev: LYK8
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: QUANTUM  Model: XP34550W         Rev: LYK8
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: ARCHIVE  Model: 4326XX 27871-XXX Rev: 4.BG
  Type:   Sequential-Access                ANSI SCSI revision: 02

SCSI controller is a Symbios Logic 53c876 dual channel card.

Hope this helps,

Bas Vermeulen

-- 
"God, root, what is difference?" 
	-- Pitr, User Friendly

"God is more forgiving." 
	-- Dave Aronson

