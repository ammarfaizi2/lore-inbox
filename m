Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263455AbTFJQZp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 12:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263458AbTFJQZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 12:25:45 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:51146 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263455AbTFJQZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 12:25:35 -0400
Date: Tue, 10 Jun 2003 09:28:08 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 796] New: Kernel Oops with nfsd
Message-ID: <92550000.1055262488@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=796

           Summary: Kernel Oops with nfsd.
    Kernel Version: 2.5.70
            Status: NEW
          Severity: normal
             Owner: trond.myklebust@fys.uio.no
         Submitter: robbiew@us.ibm.com


Distribution: SuSE 8.0

Hardware Environment:
 ------
| Server|
 ------
# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 1
cpu MHz         : 702.199
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 1384.44

# cat /proc/meminfo
MemTotal:      4325580 kB
MemFree:       3239332 kB
Buffers:        615592 kB
Cached:         316972 kB
SwapCached:          0 kB
Active:          95640 kB
Inactive:       852508 kB
HighTotal:     3465188 kB
HighFree:      3129856 kB
LowTotal:       860392 kB
LowFree:        109476 kB
SwapTotal:     2097136 kB
SwapFree:      2097136 kB
Dirty:            1868 kB
Writeback:           0 kB
Mapped:          21368 kB
Slab:            59364 kB
Committed_AS:    31852 kB
PageTables:        452 kB
VmallocTotal:   114680 kB
VmallocUsed:      2240 kB
VmallocChunk:   112440 kB

# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/sda3              25G  4.5G   19G  19% /
/dev/sda1              23M   11M   10M  50% /boot
/dev/sdb1              33G  642M   31G   2% /nfsserver/ext3
/dev/sdc1              34G   96M   33G   1% /nfsserver/jfs
/dev/sdd1              34G  245M   33G   1% /nfsserver/reiserfs

# ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 00:06:29:F6:3D:E6
          inet addr:9.3.192.6  Bcast:9.3.192.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:201340 errors:0 dropped:0 overruns:0 frame:0
          TX packets:6874 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:135857677 (129.5 Mb)  TX bytes:639480 (624.4 Kb)
          Interrupt:11 Base address:0x2200

 -------
| Client1|
 -------
# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 864.111
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 1708.03

# cat /proc/meminfo
MemTotal:       252752 kB
MemFree:          3384 kB
Buffers:         20132 kB
Cached:         200284 kB
SwapCached:          0 kB
Active:         101644 kB
Inactive:       123984 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       252752 kB
LowFree:          3384 kB
SwapTotal:      530104 kB
SwapFree:       530100 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:           8904 kB
Slab:            21400 kB
Committed_AS:    19764 kB
PageTables:        284 kB
VmallocTotal:   778168 kB
VmallocUsed:       928 kB
VmallocChunk:   777240 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB

# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/hda2              27G  3.7G   22G  15% /

# ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 00:02:55:2A:F2:CC
          inet addr:9.3.192.48  Bcast:9.3.192.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:204155 errors:0 dropped:0 overruns:0 frame:0
          TX packets:5563 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:136761161 (130.4 Mb)  TX bytes:429949 (419.8 Kb)
          Interrupt:20 Base address:0x74c0 Memory:febff000-febff038

 -------
| Client2|
 -------
# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 864.111
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 1708.03

# cat /proc/meminfo
MemTotal:       252744 kB
MemFree:        179880 kB
Buffers:          3244 kB
Cached:          54900 kB
SwapCached:          0 kB
Active:          21116 kB
Inactive:        41748 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       252744 kB
LowFree:        179880 kB
SwapTotal:      530136 kB
SwapFree:       530136 kB
Dirty:              16 kB
Writeback:           0 kB
Mapped:           8324 kB
Slab:             7592 kB
Committed_AS:    19188 kB
PageTables:        260 kB
VmallocTotal:   778204 kB
VmallocUsed:      1264 kB
VmallocChunk:   776940 kB

# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/hda2             3.8G  3.0G  702M  82% /
/dev/hda1              99M  8.5M   85M  10% /boot

# ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 00:02:55:2A:F9:21
          inet addr:9.3.192.50  Bcast:9.3.192.255  Mask:255.255.255.0
          UP BROADCAST NOTRAILERS RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:10439 errors:0 dropped:0 overruns:0 frame:0
          TX packets:2117 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:7628067 (7.2 Mb)  TX bytes:188451 (184.0 Kb)
          Interrupt:5 Base address:0x78c0 Memory:febff000-febff038



Software Environment:
 ------
| Server|
 ------
Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
module-init-tools      2.4.12
e2fsprogs              1.26
jfsutils               1.0.15
xfsprogs               2.0.0
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        x    1 root     root      1394238 Mar 23  
2002 /lib/libc.so.6
Dynamic linker (ldd)   2.2.5
Procps                 3.1.5
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
No Modules Loaded

 -------
| Client1|
 -------
Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11z
mount                  2.11z
module-init-tools      2.4.12
e2fsprogs              1.26
jfsutils               1.0.15
xfsprogs               2.0.0
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        x    1 root     root      1394238 Mar 23  
2002 /lib/libc.so.6
Dynamic linker (ldd)   2.2.5
Procps                 3.1.5
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
No Modules Loaded

 -------
| Client2|
 -------
Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
module-init-tools      2.4.12
e2fsprogs              1.26
jfsutils               1.0.15
xfsprogs               2.0.0
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        x    1 root     root      1394238 Mar 23  
2002 /lib/libc.so.6
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
No Modules Loaded


Problem Description: 

While running an intensive NFS test (see http://ltp.sf.net/nfs) I was able to 
create the following kernel oops on the server:
------------------------------------
Code:  Bad EIP value.
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 36d49001
Oops: 0000 [#55]
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010202
EIP is at 0x0
eax: 00000000   ebx: ebc6c628   ecx: 00000000   edx: f7d4fc8c
esi: f747b98c   edi: 00007734   ebp: f383fc28   esp: f383fc14
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 1709, threadinfo=f383e000 task=f38530c0)
Stack: c01d2bc2 ebc6c628 00000001 f383fea4 f747b98c f383fc3c c01d2c2e f747b98c
       00030060 00007734 f383fe80 c01d1ddf f747b98c f389d158 00000001 f383fea4
       11270000 f383fd8c 00000000 c03ff704 f383fe4c 00000000 00000247 c0574728
Call Trace:
 [<c01d2bc2>] export_iget+0x3e/0x94
 [<c01d2c2e>] get_object+0x16/0x1c
 [<c01d1ddf>] find_exported_dentry+0x3f/0xc90
 [<c03ff704>] ip_generic_getfrag+0x0/0x8c
 [<c041f290>] udp_sendmsg+0xaa8/0xb48
 [<c03e7183>] sock_alloc_send_skb+0x1b/0x24
 [<c03ffa23>] ip_append_data+0x293/0x660
 [<c041f136>] udp_sendmsg+0x94e/0xb48
 [<c03ff704>] ip_generic_getfrag+0x0/0x8c
 [<c041f290>] udp_sendmsg+0xaa8/0xb48
 [<c04272e8>] inet_sendmsg+0x40/0x48
 [<c03e41e6>] sock_sendmsg+0x86/0xa4
 [<c04272e8>] inet_sendmsg+0x40/0x48
 [<c011591d>] kmap+0x2d/0x34
 [<c03e7551>] sock_no_sendpage+0x71/0x90
 [<c03e7562>] sock_no_sendpage+0x82/0x90
 [<c01d9d18>] exp_find_key+0x4c/0x5c
 [<c01d2e0e>] export_decode_fh+0x66/0x6f
 [<c01d4f30>] nfsd_acceptable+0x0/0x1ac
 [<c01d5426>] fh_verify+0x34a/0x4f0
 [<c01d4f30>] nfsd_acceptable+0x0/0x1ac
 [<c01d6874>] nfsd_access+0x28/0xf4
 [<c01dd489>] nfsd3_proc_access+0xc1/0xd0
 [<c01d3532>] nfsd_dispatch+0xde/0x19c
 [<c044a79d>] svc_process+0x3d9/0x66c
 [<c01d321e>] nfsd+0x24e/0x484
 [<c01d2fd0>] nfsd+0x0/0x484
 [<c0108c51>] kernel_thread_helper+0x5/0xc
------------------------------------

Steps to reproduce: See test plan located at http://ltp.sf.net/nfs

