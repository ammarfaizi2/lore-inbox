Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272232AbRIKEzR>; Tue, 11 Sep 2001 00:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272272AbRIKEzI>; Tue, 11 Sep 2001 00:55:08 -0400
Received: from [61.11.16.47] ([61.11.16.47]:53032 "HELO enigma")
	by vger.kernel.org with SMTP id <S272232AbRIKEyz>;
	Tue, 11 Sep 2001 00:54:55 -0400
Date: Tue, 11 Sep 2001 04:53:26 +0530
From: Manas Garg <mls@chakpak.net>
To: linux-kernel@vger.kernel.org
Subject: Kernel Panic Report
Message-ID: <20010911045326.A274@cygsoft.com>
Mail-Followup-To: Manas Garg <mls@chakpak.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Cygnet Software Ltd.
X-Editor: Vim
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am sending this report to the list rather than to a module maintainer because
I am not sure which module this problem belongs to. Though it seems that the
problem is related with sound modules or i810_audio.c, but I am not sure.

I am sending a python script that causes instant kernel panic because it
derefrences a NULL pointer. The problem is reproducible. The script was run
like this:
	On one machine: ./voice.py -d -p 5555
	On another machine: ./voice.py -h <ip_of_first_machine> -p 5555

Both the machines have exactly same hardware and both are running 2.4.* series
of kernel. C equivalent of the attached python code also causes the panic. If
you want to damn me for skipping some crucial information, please send a direct
email as I am not on the list.

enigma:~# lsmod
Module                  Size  Used by
unix                   14976  12
3c59x                  25120   1
vfat                    8880   0  (unused)
fat                    31072   0  [vfat]
ntfs                   50384   0  (unused)
smbfs                  33872   0  (unused)
ncpfs                  37664   0  (unused)
coda                   47104   0  (unused)

Following is the output of dmesg on the first machine (I don't have access to
the other machine as of now but it's running RedHat Linux 7.1 with default
kernel which is 2.4 series only):

enigma:~# dmesg
Linux version 2.4.7 (root@enigma) (gcc version 2.95.3 20010315 (Debian release)) #1 Sun Jul 29 18:58:24 IST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007eae000 (usable)
 BIOS-e820: 0000000007eae000 - 0000000008000000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
On node 0 totalpages: 32430
zone(0): 4096 pages.
zone(1): 28334 pages.
zone(2): 0 pages.
Kernel command line: mem=129720K
Initializing CPU#0
Detected 730.981 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1458.17 BogoMIPS
Memory: 125028k/129720k available (1234k kernel code, 4304k reserved, 458k data, 204k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfc0ce, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/2410] at 00:1f.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.4.0 initialized
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: queued sectors max/low 83018kB/27672kB, 256 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 2
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 31024H1, ATA DISK drive
hdc: Lite-On LTN483S 48x Max, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 19531250 sectors (10000 MB) w/2048KiB Cache, CHS=1215/255/63, UDMA(66)
hdc: ATAPI 48X CD-ROM drive, 120kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 hda4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 93M
agpgart: Detected an Intel i810 E Chipset.
agpgart: detected 4MB dedicated video ram.
agpgart: AGP aperture is 64M @ 0xf8000000
[drm] AGP 0.99 on Intel i810 @ 0xf8000000 64MB
[drm] Initialized i810 1.1.0 20000928 on minor 63
Intel 810 + AC97 Audio, version 0.02, 19:00:31 Jul 29 2001
PCI: Found IRQ 10 for device 00:1f.5
PCI: Sharing IRQ 10 with 00:1f.3
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH 82801AA found at IO 0xdc80 and 0xd800, IRQ 10
ac97_codec: AC97 Audio codec, id: 0x4144:0x5340 (Analog Devices AD1881)
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
Linux IP multicast router 0.06 plus PIM-SM
ds: no socket drivers loaded!
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 204k freed
Adding Swap: 128484k swap-space (priority -1)
Coda Kernel/Venus communications, v5.3.14, coda@cs.cmu.edu
NTFS version 1.1.15
PCI: Found IRQ 5 for device 01:0c.0
3c59x.c:LK1.1.15 6 June 2001  Donald Becker and others. http://www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
01:0c.0: 3Com PCI 3c905C Tornado at 0xec80,  00:b0:d0:6f:5d:5d, IRQ 5
  product code 0000 rev 00.14 date 07-16-104
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 782d.
  Enabling bus-master transmits and whole-frame receives.
01:0c.0: scatter/gather enabled. h/w checksums enabled
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
eth0: using NWAY device table, not 8


And following is the python script that can be used to reproduce the problem
at least on the same hardware (I am sending this inline because I am not sure
whether attachments are allowed on this list):

#!/usr/bin/env python

import sys
import string
import getopt
import thread
import time
import socket

daemon, rhost, port = None, None, 5543
rdev, wdev, connsock = None, None, None

def usage():
    print """
    Usage: pvchat -d -p <port>  Waits for connections from remote host
           pvchat -h <host> -p <port>   Connects to a remote host
           pvchat -H        Prints this message
    """

def start_server():
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.bind('', int(port))
    sock.listen(1)

    return sock


def accept_connection(sock):
    csock, addr = sock.accept()

    return csock


def connect_remote():
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.connect(rhost, int(port))
    return sock


def get_connected_socket():
    if daemon:
        sock = start_server()
        csock = accept_connection(sock)
    else:
        csock = connect_remote()

    return csock


def write_to_rhost():
    while 1:
        try:
            buf = rdev.read(1024)
            connsock.send(buf)
        except Exception:
            print "Some error occurred\n"
	    sys.exit()


def write_to_dev():
    while 1:
        try:
            buf = connsock.recv(1024)
            wdev.write(buf)
        except Exception:
            print "Some error occurred\n"
	    sys.exit()


try:
    opts, args = getopt.getopt(sys.argv[1:], "dHh:p:", 
			    ["daemon", "help", "host", "port"])
except getopt.error:
    usage()
    sys.exit(1)

for o, a in opts:
    if o in ("-H", "--help"):
	usage()
	sys.exit()
    if o in ("-d", "--daemon"):
	if not rhost:
	    daemon = 1
	else:
	    usage()
	    sys.exit(1)
    if o in ("-p", "--port"):
	port = a
    if o in ("-h", "--host"):
	if not daemon:
	    rhost = a
	else:
	    usage()
	    sys.exit(1)

if not daemon and not rhost:
    usage()
    sys.exit()

print "Getting connected socket\n"
connsock = get_connected_socket()
while 1:
    try:
	rdev = open ("/dev/dsp", "r")
	wdev = open ("/dev/dsp", "w")
	break;
    except Exception:
	print "It seems that a process has already opened the sound file\n"
	print "Quit that process and hit Enter to try again (^C to exit)"
	stdin.readline()

thread.start_new_thread(write_to_rhost, ())
thread.start_new_thread(write_to_dev, ())

# Need to replace it with thread_join() soon
while 1:
    time.sleep(500)
