Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129227AbRBNQOq>; Wed, 14 Feb 2001 11:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129093AbRBNQOa>; Wed, 14 Feb 2001 11:14:30 -0500
Received: from chiark.greenend.org.uk ([195.224.76.132]:25353 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id <S129639AbRBNQOM>; Wed, 14 Feb 2001 11:14:12 -0500
From: Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14986.44753.3533.519003@chiark.greenend.org.uk>
Date: Wed, 14 Feb 2001 16:14:09 +0000 (GMT)
To: linux-kernel@vger.kernel.org
Subject: 2.2.19pre10 panic: skput: over: cD158117:3872 put:3872 dev:10
X-Mailer: VM 6.75 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently tried out 2.2.19pre10 because of the VM problems with
2.2.18.  The system lasted about 10 hours and then paniced.  On the
console was:

 chiark login: kernel panic: skput: over: cD158117:3872 put:3872 dev:10
 S13  Transmit timed out, bad line quality?
 S13  Transmit timed out, bad line quality?
 S13  Transmit timed out, bad line quality?
 S13  Transmit timed out, bad line quality?
 S13  Transmit timed out, bad line quality?
 S13  Transmit timed out, bad line quality?
 S13  Transmit timed out, bad line quality?
 S13  Transmit timed out, bad line quality?
 S13  Transmit timed out, bad line quality?
 S10  Transmit timed out, bad line quality?
 S10  Transmit timed out, bad line quality?
 S10  Transmit timed out, bad line quality?
 S10  Transmit timed out, bad line quality?
 S10  Transmit timed out, bad line quality?
 S10  Transmit timed out, bad line quality?
 S10  Transmit timed out, bad line quality?
 S10  Transmit timed out, bad line quality?
 S10  Transmit timed out, bad line quality?

(This was reported to me by my colo's staff, and was probably
transcribed with pencil and paper.)

I have a no-name NE2K network card.

There were no kernel log messages recorded on disk.

Some time after the panic, when I noticed that there was something
wrong, the machine was still responding to pings and could still
answer new TCP connections, but didn't show any evidence of running
any userland code.

-chiark:linux-2.2.19pre10-chiark> sh scripts/ver_linux
-- Versions installed: (if some fields are empty or looks
-- unusual then possibly you have very old versions)
Linux chiark 2.2.18 #2 Wed Feb 14 10:56:04 GMT 2001 i586 unknown
Kernel modules         found
Gnu C                  2.95.2
Binutils               2.9.5.0.37
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.11
Procps                 2.0.6
Mount                  2.10f
Net-tools              2.05
Kbd                    0.99
Sh-utils               2.0
cat: /proc/modules: No such file or directory
Modules Loaded
-chiark:linux-2.2.19pre10-chiark>

This kernel was 2.2.18 + Alan's 19pre10 + a few tuning patches of my
own, which are attached below.  Also attached, all the kernel messages
from the run in question, and my .config.

I also have gcc272 installed, and it looks like the kernel was compiled with that.

-chiark:linux-2.2.19pre10-chiark> gcc272 --version
2.7.2.3
-chiark:linux-2.2.19pre10-chiark> dpkg -l gcc272
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Installed/Config-files/Unpacked/Failed-config/Half-installed
|/ Err?=(none)/Hold/Reinst-required/X=both-problems (Status,Err: uppercase=bad)
||/ Name           Version        Description
+++-==============-==============-============================================
ii  gcc272         2.7.2.3-15     The GNU C compiler.
-chiark:linux-2.2.19pre10-chiark>

The process accounting logs show this immediately before the crash:
begin date and time command          user     group    tty dev    FSDX sigexit
2001-02-14 00:20:23 adnshost         mail     mail     00000000              6
2001-02-14 00:20:23 adnshost         mail     mail     00000000              3
2001-02-14 00:20:23 adnshost         mail     mail     00000000              6
2001-02-14 00:20:23 adnshost         mail     mail     00000000              6
2001-02-14 00:20:22 adnshost         mail     mail     00000000              0
2001-02-14 00:20:22 adnshost         mail     mail     00000000              6
2001-02-14 00:20:22 adnshost         mail     mail     00000000              0
2001-02-14 00:20:22 adnshost         mail     mail     00000000              0
2001-02-14 00:20:22 adnshost         mail     mail     00000000              0
2001-02-14 00:08:06 proftpd          root     nogroup  00000000   FS         0
2001-02-14 00:20:17 adnshost         mail     mail     00000000              6
2001-02-14 00:20:14 identd           identd   identd   00000000    S         0
2001-02-14 00:20:14 identd           identd   identd   00000000   F          0
2001-02-14 00:20:14 identd           identd   identd   00000000   F          0
2001-02-14 00:20:14 identd           identd   identd   00000000   F          0
2001-02-14 00:20:14 identd           identd   identd   00000000   F          0
2001-02-14 00:20:14 identd           identd   identd   00000000   F          0
2001-02-14 00:20:14 identd           identd   identd   00000000   F          0
2001-02-14 00:20:12 grep             markc    markc    pts/31                0
2001-02-14 00:20:12 mesg             markc    markc    pts/31                0
2001-02-14 00:20:12 mesg             markc    markc    pts/31                0
2001-02-14 00:20:10 exim             mail     mail     00000000    S         0
2001-02-14 00:20:10 exim             dh219    mail     00000000   FS         0
2001-02-14 00:20:09 sendmail         mail     mail     00000000    S         0
2001-02-14 00:20:09 adnshost         mail     mail     00000000              0

adnshost is mainly called by my receiver-SMTP (SAUCE), whose logs
immediately before the crash show:

2001-02-14 00:20:23 GMT: debug: chiark.greenend.org.uk-209.116.70.71:1719 >> 250 <XXXXXXXXXX@chiark.greenend.org.uk> verified
2001-02-14 00:20:23 GMT: debug: chiark.greenend.org.uk-209.116.70.71:1719 << DATA
2001-02-14 00:20:23 GMT: debug: chiark.greenend.org.uk-209.116.70.71:1719 >> 354 Send text

and nothing really unusual.

-chiark:linux-2.2.19pre10-chiark> cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0300-031f : NE2000
03c0-03df : vga+
e000-e07f : sym53c8xx
e400-e47f : sym53c8xx
-chiark:linux-2.2.19pre10-chiark> cat /proc/interrupts
           CPU0
  0:    1716599          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
 10:    1454028          XT-PIC  NE2000
 11:     682441          XT-PIC  sym53c8xx
 12:     288498          XT-PIC  sym53c8xx
 13:          1          XT-PIC  fpu
NMI:          0
-chiark:linux-2.2.19pre10-chiark> cat /proc/bus/pci/devices
0000    10b91541        0       e0000000        00000000        00000000       00000000 00000000        00000000        00000000
0008    10b95243        0       00000000        00000000        00000000       00000000 00000000        00000000        00000000
0038    10b91533        0       00000000        00000000        00000000       00000000 00000000        00000000        00000000
0040    1000000f        b       0000e001        e6004000        e6000000       00000000 00000000        00000000        e4000000
0048    1000000c        c       0000e401        e6002000        e6003000       00000000 00000000        00000000        e5000000
0078    10b95229        0       000001f1        000003f5        00000171       00000375 0000f001        00000000        00000000
-chiark:linux-2.2.19pre10-chiark>

diff -ru linux-2.0-dist/Makefile linux-2.0-mine/Makefile
--- linux-2.0-dist/Makefile	Fri Jun  7 09:55:00 1996
+++ linux-2.0-mine/Makefile	Sat Jun 22 16:54:45 1996
@@ -66,7 +66,7 @@
 # the default of FLOPPY is used by 'build'.
 #
 
-ROOT_DEV = CURRENT
+ROOT_DEV = FLOPPY
 
 #
 # INSTALL_PATH specifies where to place the updated kernel and system map
diff -ru linux-2.0-dist/drivers/scsi/st.c linux-2.0-mine/drivers/scsi/st.c
--- linux-2.0-dist/drivers/scsi/st.c	Sat May 18 11:25:09 1996
+++ linux-2.0-mine/drivers/scsi/st.c	Sat Jun 22 16:54:45 1996
@@ -32,7 +32,7 @@
 
 /* The driver prints some debugging information on the console if DEBUG
    is defined and non-zero. */
-#define DEBUG 0
+#define DEBUG 1
 
 /* The message level for the debug messages is currently set to KERN_NOTICE
    so that people can easily see the messages. Later when the debugging messages


--- linux-2.2.18pre17+VM-global-2.2.18pre17-7/include/linux/tasks.h~	Wed Oct 25 14:16:50 2000
+++ linux-2.2.18pre17+VM-global-2.2.18pre17-7/include/linux/tasks.h	Wed Oct 25 14:17:43 2000
@@ -11,7 +11,7 @@
 #define NR_CPUS 1
 #endif
 
-#define NR_TASKS	512	/* On x86 Max about 4000 */
+#define NR_TASKS	2048	/* On x86 Max about 4000 */
 
 #define MAX_TASKS_PER_USER (NR_TASKS/2)
 #define MIN_TASKS_LEFT_FOR_ROOT 4



Feb 13 14:38:30 chiark kernel: klogd 1.3-3#33.1, log source = /proc/kmsg started.
Feb 13 14:38:30 chiark kernel: Inspecting /boot/System.map
Feb 13 14:38:30 chiark kernel: Loaded 4290 symbols from /boot/System.map.
Feb 13 14:38:30 chiark kernel: Symbols match kernel version 2.2.19.
Feb 13 14:38:30 chiark kernel: No module symbols loaded - kernel modules not enabled. 
Feb 13 14:38:30 chiark kernel: Linux version 2.2.19pre10 (ian@chiark) (gcc version 2.7.2.3) #1 Tue Feb 13 14:08:22 GMT 2001
Feb 13 14:38:30 chiark kernel: USER-provided physical RAM map:
Feb 13 14:38:30 chiark kernel:  USER: 0009f000 @ 00000000 (usable)
Feb 13 14:38:30 chiark kernel:  USER: 0ff00000 @ 00100000 (usable)
Feb 13 14:38:30 chiark kernel: Detected 350808 kHz processor.
Feb 13 14:38:30 chiark kernel: Console: colour VGA+ 80x25
Feb 13 14:38:30 chiark kernel: Calibrating delay loop... 699.59 BogoMIPS
Feb 13 14:38:30 chiark kernel: Memory: 258068k/262144k available (772k kernel code, 416k reserved, 2832k data, 56k init)
Feb 13 14:38:30 chiark kernel: Dentry hash table entries: 32768 (order 6, 256k)
Feb 13 14:38:30 chiark kernel: Buffer cache hash table entries: 262144 (order 8, 1024k)
Feb 13 14:38:30 chiark kernel: Page cache hash table entries: 65536 (order 6, 256k)
Feb 13 14:38:30 chiark kernel: CPU: L1 I Cache: 32K  L1 D Cache: 32K
Feb 13 14:38:30 chiark kernel: CPU: AMD-K6(tm) 3D processor stepping 00
Feb 13 14:38:30 chiark kernel: Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Feb 13 14:38:30 chiark kernel: Checking 'hlt' instruction... OK.
Feb 13 14:38:30 chiark kernel: POSIX conformance testing by UNIFIX
Feb 13 14:38:30 chiark kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb530
Feb 13 14:38:30 chiark kernel: PCI: Using configuration type 1
Feb 13 14:38:30 chiark kernel: PCI: Probing PCI hardware
Feb 13 14:38:30 chiark kernel: Linux NET4.0 for Linux 2.2
Feb 13 14:38:30 chiark kernel: Based upon Swansea University Computer Society NET3.039
Feb 13 14:38:30 chiark kernel: NET4: Unix domain sockets 1.0 for Linux NET4.0.
Feb 13 14:38:30 chiark kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Feb 13 14:38:30 chiark kernel: IP Protocols: ICMP, UDP, TCP
Feb 13 14:38:30 chiark kernel: TCP: Hash tables configured (ehash 262144 bhash 65536)
Feb 13 14:38:30 chiark kernel: Initializing RT netlink socket
Feb 13 14:38:30 chiark kernel: Starting kswapd v 1.5 
Feb 13 14:38:30 chiark kernel: pty: 1024 Unix98 ptys configured
Feb 13 14:38:30 chiark kernel: FDC 0 is a post-1991 82077
Feb 13 14:38:30 chiark kernel: md driver 0.36.6 MAX_MD_DEV=4, MAX_REAL=8
Feb 13 14:38:30 chiark kernel: raid0 personality registered
Feb 13 14:38:30 chiark kernel: sym53c8xx: at PCI bus 0, device 8, function 0
Feb 13 14:38:30 chiark kernel: sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
Feb 13 14:38:30 chiark kernel: sym53c8xx: 53c875 detected with Tekram NVRAM
Feb 13 14:38:30 chiark kernel: sym53c8xx: at PCI bus 0, device 9, function 0
Feb 13 14:38:30 chiark kernel: sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
Feb 13 14:38:30 chiark kernel: sym53c8xx: 53c895 detected with Tekram NVRAM
Feb 13 14:38:30 chiark kernel: sym53c875-0: rev 0x3 on pci bus 0 device 8 function 0 irq 11
Feb 13 14:38:30 chiark kernel: sym53c875-0: Tekram format NVRAM, ID 7, Fast-20, Parity Checking
Feb 13 14:38:30 chiark kernel: sym53c895-1: rev 0x1 on pci bus 0 device 9 function 0 irq 12
Feb 13 14:38:30 chiark kernel: sym53c895-1: Tekram format NVRAM, ID 7, Fast-40, Parity Checking
Feb 13 14:38:30 chiark kernel: scsi0 : sym53c8xx-1.7.1-20000726
Feb 13 14:38:30 chiark kernel: scsi1 : sym53c8xx-1.7.1-20000726
Feb 13 14:38:30 chiark kernel: scsi : 2 hosts.
Feb 13 14:38:30 chiark kernel:   Vendor: IBM       Model: DCAS-34330        Rev: S65A
Feb 13 14:38:30 chiark kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Feb 13 14:38:30 chiark kernel: Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
Feb 13 14:38:30 chiark kernel:   Vendor: IBM       Model: DCAS-34330        Rev: S65A
Feb 13 14:38:30 chiark kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Feb 13 14:38:30 chiark kernel: Detected scsi disk sdb at scsi0, channel 0, id 2, lun 0
Feb 13 14:38:30 chiark kernel:   Vendor: HP        Model: T20               Rev: 3.01
Feb 13 14:38:30 chiark kernel:   Type:   Sequential-Access                  ANSI SCSI revision: 02
Feb 13 14:38:30 chiark kernel: Detected scsi tape st0 at scsi0, channel 0, id 4, lun 0
Feb 13 14:38:30 chiark kernel:   Vendor: IBM       Model: DNES-318350W      Rev: SA30
Feb 13 14:38:30 chiark kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Feb 13 14:38:30 chiark kernel: Detected scsi disk sdc at scsi1, channel 0, id 0, lun 0
Feb 13 14:38:30 chiark kernel: scsi : detected 1 SCSI tape 3 SCSI disks total.
Feb 13 14:38:30 chiark kernel: st: Buffer size 32768 bytes, write threshold 30720 bytes.
Feb 13 14:38:30 chiark kernel: st: Allocated tape buffer 0 (32768 bytes, 1 segments, dma: 1, a: c0090000).
Feb 13 14:38:30 chiark kernel: st: segment sizes: first 32768, last 32768 bytes.
Feb 13 14:38:30 chiark kernel: sym53c875-0-<0,*>: FAST-20 SCSI 20.0 MB/s (50 ns, offset 15)
Feb 13 14:38:30 chiark kernel: SCSI device sda: hdwr sector= 512 bytes. Sectors= 8467200 [4134 MB] [4.1 GB]
Feb 13 14:38:30 chiark kernel: sym53c875-0-<2,*>: FAST-20 SCSI 20.0 MB/s (50 ns, offset 15)
Feb 13 14:38:30 chiark kernel: SCSI device sdb: hdwr sector= 512 bytes. Sectors= 8467200 [4134 MB] [4.1 GB]
Feb 13 14:38:30 chiark kernel: sym53c895-1-<0,*>: FAST-40 WIDE SCSI 80.0 MB/s (25 ns, offset 31)
Feb 13 14:38:30 chiark kernel: SCSI device sdc: hdwr sector= 512 bytes. Sectors= 35843670 [17501 MB] [17.5 GB]
Feb 13 14:38:30 chiark kernel: SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
Feb 13 14:38:30 chiark kernel: CSLIP: code copyright 1989 Regents of the University of California.
Feb 13 14:38:30 chiark kernel: ne.c:v1.10 9/23/94 Donald Becker (becker@cesdis.gsfc.nasa.gov)
Feb 13 14:38:30 chiark kernel: NE*000 ethercard probe at 0x300: 00 40 95 a1 70 78
Feb 13 14:38:30 chiark kernel: eth0: NE2000 found at 0x300, using IRQ 10.
Feb 13 14:38:30 chiark kernel: Partition check:
Feb 13 14:38:30 chiark kernel:  sda: sda1 sda2 sda3
Feb 13 14:38:30 chiark kernel:  sdb: sdb1
Feb 13 14:38:30 chiark kernel:  sdc: sdc1 sdc2 sdc3 < sdc5 sdc6 sdc7 >
Feb 13 14:38:30 chiark kernel: VFS: Mounted root (ext2 filesystem) readonly.
Feb 13 14:38:30 chiark kernel: Freeing unused kernel memory: 56k freed
Feb 13 14:38:30 chiark kernel: Adding Swap: 409592k swap-space (priority 10)


#
# Automatically generated by make menuconfig: don't edit
#

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
CONFIG_M586TSC=y
# CONFIG_M686 is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_TSC=y
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_1GB=y
# CONFIG_2GB is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
# CONFIG_SMP is not set

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_OLD_PROC is not set
# CONFIG_MCA is not set
# CONFIG_VISWS is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_PARPORT is not set
# CONFIG_APM is not set
# CONFIG_TOSHIBA is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_IDE is not set
# CONFIG_BLK_DEV_HD_ONLY is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_LINEAR is not set
CONFIG_MD_STRIPED=y
# CONFIG_MD_MIRRORING is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_BOOT is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_PARIDE_PARPORT=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_HD is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK_DEV=y
CONFIG_FIREWALL=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK=y
# CONFIG_IP_MULTIPLE_TABLES is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
# CONFIG_IP_ROUTE_TOS is not set
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_ROUTE_LARGE_TABLES is not set
# CONFIG_IP_PNP is not set
CONFIG_IP_FIREWALL=y
CONFIG_IP_FIREWALL_NETLINK=y
CONFIG_NETLINK_DEV=y
# CONFIG_IP_TRANSPARENT_PROXY is not set
# CONFIG_IP_MASQUERADE is not set
# CONFIG_IP_ROUTER is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
CONFIG_IP_ALIAS=y
CONFIG_SYN_COOKIES=y
# CONFIG_INET_RARP is not set
CONFIG_SKB_LARGE=y
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set

#
# SCSI support
#
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_NCR53C8XX is not set
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=8
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=80
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_SCSI is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
CONFIG_NET_ISA=y
# CONFIG_AT1700 is not set
# CONFIG_E2100 is not set
# CONFIG_DEPCA is not set
# CONFIG_EWRK3 is not set
# CONFIG_EEXPRESS is not set
# CONFIG_EEXPRESS_PRO is not set
# CONFIG_FMV18X is not set
# CONFIG_HPLAN_PLUS is not set
# CONFIG_HPLAN is not set
# CONFIG_HP100 is not set
CONFIG_NE2000=y
# CONFIG_SK_G16 is not set
# CONFIG_NET_EISA is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_PPP is not set
CONFIG_SLIP=y
CONFIG_SLIP_COMPRESSED=y
# CONFIG_SLIP_SMART is not set
# CONFIG_SLIP_MODE_SLIP6 is not set
# CONFIG_NET_RADIO is not set

#
# Token ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set

#
# Wan interfaces
#
# CONFIG_HOSTESS_SV11 is not set
# CONFIG_COSA is not set
# CONFIG_SEALEVEL_4021 is not set
# CONFIG_SYNCLINK_SYNCPPP is not set
# CONFIG_LANMEDIA is not set
# CONFIG_COMX is not set
# CONFIG_DLCI is not set
# CONFIG_WAN_DRIVERS is not set
# CONFIG_XPEED is not set
# CONFIG_SBNI is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
# CONFIG_SERIAL is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=1024
# CONFIG_MOUSE is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_WATCHDOG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_INTEL_RNG is not set

#
# Video For Linux
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DTLK is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Filesystems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_ISO9660_FS is not set
# CONFIG_JOLIET is not set
CONFIG_MINIX_FS=y
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set

#
# Partition Types
#
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MAC_PARTITION is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SMD_DISKLABEL is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_NLS is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# Kernel hacking
#
# CONFIG_MAGIC_SYSRQ is not set
