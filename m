Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278081AbRJKDes>; Wed, 10 Oct 2001 23:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278083AbRJKDec>; Wed, 10 Oct 2001 23:34:32 -0400
Received: from enchanter.real-time.com ([208.20.202.11]:49162 "EHLO
	enchanter.real-time.com") by vger.kernel.org with ESMTP
	id <S278081AbRJKDeM>; Wed, 10 Oct 2001 23:34:12 -0400
Date: Wed, 10 Oct 2001 22:34:43 -0500
From: Bob Tanner <tanner@real-time.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: cat /proc/ioports Segmentation faults
Message-ID: <20011010223443.V26659@real-time.com>
Reply-To: tanner@real-time.com
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Url: http://news.cnet.com/news/0-1003-201-7239473-0.html?tag=nbs
X-Gartner-says-dump-IIS: http://www3.gartner.com/DisplayDocument?doc_cd=101034
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    
cat /proc/ioports seg faults

[2.] Full description of the problem/report:
Upgraded from 2.4.10 to 2.4.11, during troubleshooting a usb problem, I was
cat-ing /proc/interrupts and /proc/ioports. The last cat to /proc/ioports seg
faulted and syslog says this:

Oct 10 23:22:51 transmuter kernel: Unable to handle kernel paging request at
virtual address c883a769
Oct 10 23:22:51 transmuter kernel:  printing eip:
Oct 10 23:22:51 transmuter kernel: c021fb5b
Oct 10 23:22:51 transmuter kernel: *pde = 07f9d067
Oct 10 23:22:51 transmuter kernel: *pte = 00000000
Oct 10 23:22:51 transmuter kernel: Oops: 0000
Oct 10 23:22:51 transmuter kernel: CPU:    0
Oct 10 23:22:51 transmuter kernel: EIP:    0010:[vsnprintf+523/1056]    Not
tainted
Oct 10 23:22:51 transmuter kernel: EFLAGS: 00010297
Oct 10 23:22:51 transmuter kernel: eax: c883a769   ebx: c4e29297   ecx: c883a769
edx: fffffffe
Oct 10 23:22:51 transmuter kernel: esi: ffffffff   edi: c71bfec8   ebp: ffffffff
esp: c71bfe70
Oct 10 23:22:51 transmuter kernel: ds: 0018   es: 0018   ss: 0018
Oct 10 23:22:51 transmuter kernel: Process cat (pid: 1353, stackpage=c71bf000)
Oct 10 23:22:51 transmuter kernel: Stack: 00000000 ffffffff 0000000a c1204e80
c4e29289 00000006 c4e2a000 c021fda6 
Oct 10 23:22:51 transmuter kernel:        c4e29289 3b1d6d77 c022bc46 c71bfebc
c021fdc4 c4e29289 c022bc35 c71bfebc 
Oct 10 23:22:51 transmuter kernel:        c011a43b c4e29289 c022bc35 0000fcc0
0000fcdf c883a769 c12114c8 c4e29289 
Oct 10 23:22:51 transmuter kernel: Call Trace: [vsprintf+22/32] [sprintf+20/32]
[do_resource_list+75/128] [do_resource_list+107/128] [get_resource_list+49/64] 
Oct 10 23:22:51 transmuter kernel:    [ioports_read_proc+46/96]
[proc_file_read+206/400] [sys_read+150/208] [system_call+51/56] 
Oct 10 23:22:51 transmuter kernel: 
Oct 10 23:22:51 transmuter kernel: Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29
c8 f6 04 24 10 89 c6 

[3.] Keywords (i.e., modules, networking, kernel):
# lsmod
Module                  Size  Used by
3c574_cs                8768   1 
ppp_async               6160   0  (autoclean) (unused)
ppp_generic            17168   0  (autoclean) [ppp_async]
slhc                    4576   0  (autoclean) [ppp_generic]
agpgart                28448   0  (unused)
ymfpci                 40704   0 
uart401                 6096   0  [ymfpci]
sound                  54400   0  [uart401]
soundcore               3568   4  [ymfpci sound]
ac97_codec              9264   0  [ymfpci]

[4.] Kernel version (from /proc/version):
# cat /proc/version 
Linux version 2.4.11 (root@transmuter.real-time.com) (gcc version 2.96 20000731
(Red Hat Linux 7.1 2.96-85)) #1 Wed Oct 10 22:51:43 CDT 2001

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
ksymoops 2.3.4 on i686 2.4.11.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.11/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol _ctype  , ksyms_base says c027ec14,
System.map says c027ebf4.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_fadt_R__ver_acpi_fadt not found
in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_gbl_FADT_R__ver_acpi_gbl_FADT not
found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol arp_broken_ops  , ksyms_base says
c027d1c0, System.map says c027d1a0.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol arp_tbl  , ksyms_base says
c027d1e0,System.map says c027d1c0.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol bm_get_device_context  , ksyms_base
says c0196150, System.map says c0195d50.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol bm_get_device_info  , ksyms_base says
c01960a0, System.map says c0195ca0.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol bm_get_device_power_state  ,
ksyms_base says c0195e40, System.map says c0195a40.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol bm_get_device_status  , ksyms_base
says c0195f90, System.map says c0195b90.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol bm_osl_generate_event  , ksyms_base
says c0195a40, System.map says c01965b0.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol bm_register_driver  , ksyms_base says
c0196220, System.map says c0195e20.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol bm_set_device_power_state  ,
ksyms_base says c0195f00, System.map says c0195b00.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol bm_unregister_driver  , ksyms_base
says c01963c0, System.map says c0195fc0.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol color_table  , ksyms_base says
c0272f1c, System.map says c0272efc.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol dead_socket  , ksyms_base says
c027b5dc, System.map says c027b5bc.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol default_blu  , ksyms_base says
c0272fac, System.map says c0272f8c.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol default_grn  , ksyms_base says
c0272f6c, System.map says c0272f4c.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol default_red  , ksyms_base says
c0272f2c, System.map says c0272f0c.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol dev_base  , ksyms_base says c0279ef4,
System.map says c0279ed4.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol dev_base_lock  , ksyms_base says
c0279ef8, System.map says c0279ed8.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol ide_fops  , ksyms_base says c027a148,
System.map says c027a128.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol if_port_text  , ksyms_base says
c027c1e8, System.map says c027c1c8.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol inet_dgram_ops  , ksyms_base says
c027da80, System.map says c027da60.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol inet_family_ops  , ksyms_base says
c027dac4, System.map says c027daa4.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol inet_stream_ops  , ksyms_base says
c027da20, System.map says c027da00.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol inetdev_lock  , ksyms_base says
c027d618, System.map says c027d5f8.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol io_request_lock  , ksyms_base says
c0278828, System.map says c0278808.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol ipv4_specific  , ksyms_base says
c027cec0, System.map says c027cea0.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol keyboard_tasklet  , ksyms_base says
c027734c, System.map says c027732c.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol loopback_dev  , ksyms_base says
c0279dc0, System.map says c0279da0.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol noop_qdisc  , ksyms_base says
c027c7e0, System.map says c027c7c0.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol pci_devices  , ksyms_base says
c027a3e8, System.map says c027a3c8.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol pci_root_buses  , ksyms_base says
c027a3e0, System.map says c027a3c0.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol proc_pccard  , ksyms_base says
c027b5ec, System.map says c027b5cc.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol qdisc_tree_lock  , ksyms_base says
c027c780, System.map says c027c760.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol rtnl_sem  , ksyms_base says c027c6d0,
System.map says c027c6b0.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol sysctl_ip_default_ttl  , ksyms_base
says c027cdc8, System.map says c027cda8.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol sysctl_local_port_range  , ksyms_base
says c027ce84, System.map says c027ce64.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol sysctl_max_syn_backlog  , ksyms_base
says c027ce90, System.map says c027ce70.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol sysctl_rmem_max  , ksyms_base says
c027bf64, System.map says c027bf44.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol sysctl_tcp_ecn  , ksyms_base says
c027ce28, System.map says c027ce08.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol sysctl_tcp_reordering  , ksyms_base
says c027ce24, System.map says c027ce04.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol sysctl_tcp_rmem  , ksyms_base says
c027cdf8, System.map says c027cdd8.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol sysctl_tcp_tw_recycle  , ksyms_base
says c027cf84, System.map says c027cf64.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol sysctl_tcp_wmem  , ksyms_base says
c027cdec, System.map says c027cdcc.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol sysctl_wmem_max  , ksyms_base says
c027bf60, System.map says c027bf40.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol tcp_port_rover  , ksyms_base says
c027ce8c, System.map says c027ce6c.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol tcp_prot  , ksyms_base says c027cf00,
System.map says c027cee0.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol tq_disk  , ksyms_base says c0278820,
System.map says c0278800.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol udp_hash_lock  , ksyms_base says
c027d0a0, System.map says c027d080.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol udp_prot  , ksyms_base says c027d0c0
System.map says c027d0a0.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol yenta_operations  , ksyms_base says
c027b880, System.map says c027b860.  Ignoring ksyms_base entry
ac97_codec: AC97 Audio codec, id: 0x414b:0x4d02 (Asahi Kasei AK4543)
3c574_cs.c v1.08 9/24/98 Donald Becker/David Hinds, becker@scyld.com.
Unable to handle kernel paging request at virtual address c883a769
c021fb5b
*pde = 07f9d067
Oops: 0000
CPU:    0
EIP:    0010:[<c021fb5b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010297
eax: c883a769   ebx: c4e29297   ecx: c883a769   edx: fffffffe
esi: ffffffff   edi: c71bfec8   ebp: ffffffff   esp: c71bfe70
ds: 0018   es: 0018   ss: 0018
Process cat (pid: 1353, stackpage=c71bf000)
Stack: 00000000 ffffffff 0000000a c1204e80 c4e29289 00000006 c4e2a000 c021fda6 
       c4e29289 3b1d6d77 c022bc46 c71bfebc c021fdc4 c4e29289 c022bc35 c71bfebc 
       c011a43b c4e29289 c022bc35 0000fcc0 0000fcdf c883a769 c12114c8 c4e29289 
Call Trace: [<c021fda6>] [<c021fdc4>] [<c011a43b>] [<c011a45b>] [<c011a4a1>] 
   [<c014d7fe>] [<c014b5be>] [<c0131406>] [<c0106ce7>] 
Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 f6 04 24 10 89 c6 

>>EIP; c021fb5b <vsnprintf+20b/420>   <=====
Trace; c021fda6 <vsprintf+16/20>
Trace; c021fdc4 <sprintf+14/20>
Trace; c011a43b <do_resource_list+4b/80>
Trace; c011a45b <do_resource_list+6b/80>
Trace; c011a4a1 <get_resource_list+31/40>
Trace; c014d7fe <ioports_read_proc+2e/60>
Trace; c014b5be <proc_file_read+ce/190>
Trace; c0131406 <sys_read+96/d0>
Trace; c0106ce7 <system_call+33/38>
Code;  c021fb5b <vsnprintf+20b/420>
00000000 <_EIP>:
Code;  c021fb5b <vsnprintf+20b/420>   <=====
   0:   80 38 00                  cmpb   $0x0,(%eax)   <=====
Code;  c021fb5e <vsnprintf+20e/420>
   3:   74 07                     je     c <_EIP+0xc> c021fb67
<vsnprintf+217/420>
Code;  c021fb60 <vsnprintf+210/420>
   5:   40                        inc    %eax
Code;  c021fb61 <vsnprintf+211/420>
   6:   4a                        dec    %edx
Code;  c021fb62 <vsnprintf+212/420>
00000000 <_EIP>:
Code;  c021fb5b <vsnprintf+20b/420>   <=====
   0:   80 38 00                  cmpb   $0x0,(%eax)   <=====
Code;  c021fb5e <vsnprintf+20e/420>
   3:   74 07                     je     c <_EIP+0xc> c021fb67
<vsnprintf+217/420>
Code;  c021fb60 <vsnprintf+210/420>
   5:   40                        inc    %eax
Code;  c021fb61 <vsnprintf+211/420>
   6:   4a                        dec    %edx
Code;  c021fb62 <vsnprintf+212/420>
   7:   83 fa ff                  cmp    $0xffffffff,%edx
Code;  c021fb65 <vsnprintf+215/420>
   a:   75 f4                     jne    0 <_EIP>
Code;  c021fb67 <vsnprintf+217/420>
   c:   29 c8                     sub    %ecx,%eax
Code;  c021fb69 <vsnprintf+219/420>
   e:   f6 04 24 10               testb  $0x10,(%esp,1)
Code;  c021fb6d <vsnprintf+21d/420>
  12:   89 c6                     mov    %eax,%esi


53 warnings issued.  Results may not be reliable.

[6.] A small shell script or example program which triggers the
     problem (if possible)

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux transmuter.real-time.com 2.4.11 #1 Wed Oct 10 22:51:43 CDT 2001 i686
unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.0.18
util-linux             2.10m
mount                  2.10r
modutils               2.3.21
e2fsprogs              1.18
pcmcia-cs              3.1.20
PPP                    2.4.0
isdn4k-utils           3.1pre1
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         3c574_cs ppp_async ppp_generic slhc agpgart ymfpci
uart401 sound soundcore ac97_codec

[7.2.] Processor information (from /proc/cpuinfo):
# cat /proc/cpuinfo 
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 3
cpu MHz		: 744.475
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat
pse36 mmx fxsr sse
bogomips	: 1484.39

[7.3.] Module information (from /proc/modules):
# cat /proc/modules 
3c574_cs                8768   1
ppp_async               6160   0 (autoclean) (unused)
ppp_generic            17168   0 (autoclean) [ppp_async]
slhc                    4576   0 (autoclean) [ppp_generic]
agpgart                28448   0 (unused)
ymfpci                 40704   0
uart401                 6096   0 [ymfpci]
sound                  54400   0 [uart401]
soundcore               3568   4 [ymfpci sound]
ac97_codec              9264   0 [ymfpci]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

Can't give you /proc/ioports, it seg faults.

# cat /proc/iomem 
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-00224abb : Kernel code
  00224abc-0027ed13 : Kernel data
07ff0000-07fff7ff : ACPI Tables
07fff800-07ffffff : ACPI Non-volatile Storage
10000000-10000fff : Ricoh Co Ltd RL5c478
10001000-10001fff : Ricoh Co Ltd RL5c478 (#2)
10400000-107fffff : PCI CardBus #02
10800000-10bfffff : PCI CardBus #02
10c00000-10ffffff : PCI CardBus #06
11000000-113fffff : PCI CardBus #06
40000000-40ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
a0000000-a0000fff : card services
fc000000-fdffffff : PCI Bus #01
  fc000000-fdffffff : Neomagic Corporation NM2380 [MagicMedia 256XL+]
fe800000-fecfffff : PCI Bus #01
  fe800000-febfffff : Neomagic Corporation NM2380 [MagicMedia 256XL+]
  fec00000-fecfffff : Neomagic Corporation NM2380 [MagicMedia 256XL+]
fede0000-fedeffff : CONEXANT SoftK56 Speakerphone Winmodem
fedf0000-fedf7fff : Yamaha Corporation YMF-744B [DS-1S Audio Controller]
fedff000-fedff7ff : Sony Corporation CXD3222 i.LINK Controller
fedffc00-fedffdff : Sony Corporation CXD3222 i.LINK Controller
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev
03)
        Subsystem: Sony Corporation: Unknown device 806f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at 40000000 (32-bit, prefetchable) [size=16M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fe800000-fecfffff
        Prefetchable memory behind bridge: fc000000-fdffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80
[Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at fcf0 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00
[UHCI])
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin D routed to IRQ 0
        Region 4: I/O ports at fcc0 [disabled] [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:08.0 FireWire (IEEE 1394): Sony Corporation CXD3222 i.LINK Controller (rev
02) (prog-if 10 [OHCI])
        Subsystem: Sony Corporation: Unknown device 8071
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at fedff000 (32-bit, non-prefetchable) [disabled]
[size=2K]
        Region 1: Memory at fedffc00 (32-bit, non-prefetchable) [disabled]
[size=512]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Multimedia audio controller: Yamaha Corporation YMF-744B [DS-1S Audio
Controller] (rev 02)
        Subsystem: Sony Corporation: Unknown device 8072
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 6250ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at fedf0000 (32-bit, non-prefetchable) [size=32K]
        Region 1: I/O ports at fc40 [size=64]
        Region 2: I/O ports at fcec [size=4]
        Capabilities: [50] Power Management version 1
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Communication controller: CONEXANT: Unknown device 2443 (rev 01)
        Subsystem: Sony Corporation: Unknown device 8075
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at fede0000 (32-bit, non-prefetchable) [disabled]
[size=64K]
        Region 1: I/O ports at fce0 [disabled] [size=8]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 CardBus bridge: Ricoh Co Ltd RL5c478 (rev 80)
        Subsystem: Sony Corporation: Unknown device 8073
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

00:0c.1 CardBus bridge: Ricoh Co Ltd RL5c478 (rev 80)
        Subsystem: Sony Corporation: Unknown device 8073
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin B routed to IRQ 9
        Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
        Memory window 0: 10c00000-10fff000 (prefetchable)
        Memory window 1: 11000000-113ff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

01:00.0 VGA compatible controller: Neomagic Corporation: Unknown device 0016
(rev 10) (prog-if 00 [VGA])
        Subsystem: Sony Corporation: Unknown device 8088
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B+
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (4000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at fe800000 (32-bit, non-prefetchable) [size=4M]
        Region 2: Memory at fec00000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [d0] AGP version 1.0
                Status: RQ=7 SBA+ 64bit- FW- Rate=x1
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)

Non SCSI system.

-- 
Bob Tanner <tanner@real-time.com>         | Phone : (952)943-8700
http://www.mn-linux.org, Minnesota, Linux | Fax   : (952)943-8500
Key fingerprint =  6C E9 51 4F D5 3E 4C 66 62 A9 10 E5 35 85 39 D9 

