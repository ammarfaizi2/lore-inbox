Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279644AbRKFP0t>; Tue, 6 Nov 2001 10:26:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279629AbRKFP0b>; Tue, 6 Nov 2001 10:26:31 -0500
Received: from ns1ca.ubisoft.qc.ca ([205.205.27.131]:39173 "EHLO
	ns1ca.ubisoft.qc.ca") by vger.kernel.org with ESMTP
	id <S279596AbRKFP0N>; Tue, 6 Nov 2001 10:26:13 -0500
Message-ID: <9A1957CB9FC45A4FA6F35961093ABB84053F9376@srvmail-mtl.ubisoft.qc.ca>
From: Patrick Allaire <pallaire@gameloft.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Serial Port problems
Date: Tue, 6 Nov 2001 10:24:48 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am currently working on an embedded linux system. I am having a tough time
using /dev/ttyS0 on this device !

Here is what I want to do :
I want to have a console on /dev/ttyS0 ... but not a boot time, so I dont
want to do this by passing parameters to the linux kernel. It as to be
enable by a set of buttons press (I am working on a gaming system). when the
corect sequence is pressed on the game pad, I want to enable a serial
console : /bin/ash > /dev/ttyS0 2> /dev/ttyS0 < /dev/ttyS0

The problems:
The console is working but it is too slow ... its not 9600 ... it take 2
minute to see the prompt ... and if I send a command : ls ... it can take 5
minutes to have the information and a prompt back. To be able the accelerate
the console, I use stty -F /dev/ttyS0 ispeed 115200 ospeed 115200 ... it is
connecting correctly ... but the console goes at the same speed as the
previous setting ! On another hand ... the linux bios boot loader write its
information to the serial console at 115200 ... and it goes really fast
?!?!?!

The system:
The comm port on my system is a standard comm port. Here is the output of
cat /proc/tty/driver/serial
# cat /proc/tty/driver/serial
serinfo:1.0 driver:5.05c revision:2001-07-08
0: uart:16550A port:3F8 irq:4 baud:115200 tx:194 rx:40 RTS|CTS|DTR|DSR
1: uart:unknown port:2F8 irq:3
2: uart:unknown port:3E8 irq:4
3: uart:unknown port:2E8 irq:3

What it this happening ... or what can I take a look at ? thank you

The following is just a cut and paste from the terminal ... to show you the
output of the boot up sequence from my system :

//
//Bios loader (take 2 second to obtain this):
//
---- GBOX Init ---- Mem Fb Shd Opt Pci Gameport:FF,FF Cpy Ldr Ram
Initialize?
before main
GHILinuxBIOS booting...
Finding PCI configuration type.
PCI: Using configuration type 1
handle_superio start, s 00005680 nsuperio 1 s->super 000058d8
handle_superio: Pass 0, Superio STPC Atlas
handle_superio  port 0x0, defaultport 0x2e
handle_superio  Using port 0x2e
handle_superio done
Scanning PCI bus...PCI: pci_scan_bus for bus 0
PCI: 00:58 [104a/020a]
PCI: 00:60 [104a/021b]
PCI: 00:61 [104a/021b]
PCI: pci_scan_bus returning with max=00
done
RAM Bank 0 contains 16MB RAM
RAM Bank 1 contains 0MB RAM
RAM Bank 2 contains 0MB RAM
RAM Bank 3 contains 0MB RAM
totalram: 12M
Initializing CPU #0
Enabling cache...CR0 = 0x00000011
done.
CPU is STPC Consumer-II
done.
CPU #0 Initialized
Allocating PCI resources...COMPUTE_ALLOCATE: do IO
compute_allocate_io: base 0x1000
DEVIO: Bus 0x0, devfn 0x61, reg 0x0: iosize 0x8
-->set base to 0x1000
DEVIO: Bus 0x0, devfn 0x61, reg 0x1: iosize 0x4
-->set base to 0x1010
DEVIO: Bus 0x0, devfn 0x61, reg 0x2: iosize 0x8
-->set base to 0x1020
DEVIO: Bus 0x0, devfn 0x61, reg 0x3: iosize 0x4
-->set base to 0x1030
DEVIO: Bus 0x0, devfn 0x61, reg 0x4: iosize 0x10
-->set base to 0x1040
BUS 0: set iolimit to 0x1fff
COMPUTE_ALLOCATE: do MEM
compute_allocate_mem: base 0x80000000
BUS 0: set memlimit to 0x7fffffff
COMPUTE_ALLOCATE: do PREFMEM
Compute_allocate_prefmem: base 0x80000000
BUS 0: set prefmemlimit to 0x7fffffff
ASSIGN RESOURCES, bus 0
Bus 0x0 devfn 0x61 reg 0x0 base to 0x1001
Bus 0x0 devfn 0x61 reg 0x1 base to 0x1011
Bus 0x0 devfn 0x61 reg 0x2 base to 0x1021
Bus 0x0 devfn 0x61 reg 0x3 base to 0x1031
Bus 0x0 devfn 0x61 reg 0x4 base to 0x1041
done.
Enabling PCI resourcess...DEV Set command bus 0x0 devfn 0x58 to 0x7
DEV Set command bus 0x0 devfn 0x60 to 0xf
DEV Set command bus 0x0 devfn 0x61 to 0x1
done.
Turning on NVRAM...done.
handle_superio start, s 00005680 nsuperio 1 s->super 000058d8
handle_superio: Pass 1, Superio STPC Atlas
handle_superio  port 0x2e, defaultport 0x2e
handle_superio  Using port 0x2e
handle_superio done
STPC (and similar)...Southbridge fixup done for STPC
handle_superio start, s 00005680 nsuperio 1 s->super 000058d8
handle_superio: Pass 2, Superio STPC Atlas
handle_superio  port 0x2e, defaultport 0x2e
handle_superio  Using port 0x2e
handle_superio done
Jumping to linuxbiosmain()...

Welcome to start32, the open sourced starter.
This space will eventually hold more diagnostic information.

January 2000, James Hendricks, Dale Webster, and Ron Minnich.
Version 0.1

Gunzip setup
output data is 0x00100000
Gunzipping boot code
    75:fill_inbuf() - zkernel_start:0xfff80000  zkernel_mask:0x0000ffff
   102:fill_inbuf() - nvram:0xfff80000  block_count:0
bad gzip magic numbers---- GBOX Init ---- Mem Fb Shd Opt Pci Gameport:FF,FF
Cpy
Ldr Ram Initialize?
before main
GHILinuxBIOS booting...
Finding PCI configuration type.
PCI: Using configuration type 1
handle_superio start, s 00005680 nsuperio 1 s->super 000058d8
handle_superio: Pass 0, Superio STPC Atlas
handle_superio  port 0x0, defaultport 0x2e
handle_superio  Using port 0x2e
handle_superio done
Scanning PCI bus...PCI: pci_scan_bus for bus 0
PCI: 00:58 [104a/020a]
PCI: 00:60 [104a/021b]
PCI: 00:61 [104a/021b]
PCI: pci_scan_bus returning with max=00
done
RAM Bank 0 contains 16MB RAM
RAM Bank 1 contains 0MB RAM
RAM Bank 2 contains 0MB RAM
RAM Bank 3 contains 0MB RAM
totalram: 12M
Initializing CPU #0
Enabling cache...CR0 = 0x00000011
done.
CPU is STPC Consumer-II
done.
CPU #0 Initialized
Allocating PCI resources...COMPUTE_ALLOCATE: do IO
compute_allocate_io: base 0x1000
DEVIO: Bus 0x0, devfn 0x61, reg 0x0: iosize 0x8
-->set base to 0x1000
DEVIO: Bus 0x0, devfn 0x61, reg 0x1: iosize 0x4
-->set base to 0x1010
DEVIO: Bus 0x0, devfn 0x61, reg 0x2: iosize 0x8
-->set base to 0x1020
DEVIO: Bus 0x0, devfn 0x61, reg 0x3: iosize 0x4
-->set base to 0x1030
DEVIO: Bus 0x0, devfn 0x61, reg 0x4: iosize 0x10
-->set base to 0x1040
BUS 0: set iolimit to 0x1fff
COMPUTE_ALLOCATE: do MEM
compute_allocate_mem: base 0x80000000
BUS 0: set memlimit to 0x7fffffff
COMPUTE_ALLOCATE: do PREFMEM
Compute_allocate_prefmem: base 0x80000000
BUS 0: set prefmemlimit to 0x7fffffff
ASSIGN RESOURCES, bus 0
Bus 0x0 devfn 0x61 reg 0x0 base to 0x1001
Bus 0x0 devfn 0x61 reg 0x1 base to 0x1011
Bus 0x0 devfn 0x61 reg 0x2 base to 0x1021
Bus 0x0 devfn 0x61 reg 0x3 base to 0x1031
Bus 0x0 devfn 0x61 reg 0x4 base to 0x1041
done.
Enabling PCI resourcess...DEV Set command bus 0x0 devfn 0x58 to 0x7
DEV Set command bus 0x0 devfn 0x60 to 0xf
DEV Set command bus 0x0 devfn 0x61 to 0x1
done.
Turning on NVRAM...done.
handle_superio start, s 00005680 nsuperio 1 s->super 000058d8
handle_superio: Pass 1, Superio STPC Atlas
handle_superio  port 0x2e, defaultport 0x2e
handle_superio  Using port 0x2e
handle_superio done
STPC (and similar)...Southbridge fixup done for STPC
handle_superio start, s 00005680 nsuperio 1 s->super 000058d8
handle_superio: Pass 2, Superio STPC Atlas
handle_superio  port 0x2e, defaultport 0x2e
handle_superio  Using port 0x2e
handle_superio done
Jumping to linuxbiosmain()...

Welcome to start32, the open sourced starter.
This space will eventually hold more diagnostic information.

January 2000, James Hendricks, Dale Webster, and Ron Minnich.
Version 0.1

Gunzip setup
output data is 0x00100000
Gunzipping boot code
    75:fill_inbuf() - zkernel_start:0xfff80000  zkernel_mask:0x0000ffff
   102:fill_inbuf() - nvram:0xfff80000  block_count:0
flush 0x00100000 count 0x00008000
flush 0x00108000 count 0x00008000
flush 0x00110000 count 0x00008000
flush 0x00118000 count 0x00008000
   102:fill_inbuf() - nvram:0xfff90000  block_count:1
flush 0x00120000 count 0x00008000
flush 0x00128000 count 0x00008000
flush 0x00130000 count 0x00008000
   102:fill_inbuf() - nvram:0xfffa0000  block_count:2
flush 0x00138000 count 0x00008000
flush 0x00140000 count 0x00008000
flush 0x00148000 count 0x00008000
flush 0x00150000 count 0x00008000
   102:fill_inbuf() - nvram:0xfffb0000  block_count:3
flush 0x00158000 count 0x00008000
flush 0x00160000 count 0x00008000
flush 0x00168000 count 0x00008000
   102:fill_inbuf() - nvram:0xfffc0000  block_count:4
flush 0x00170000 count 0x00008000
flush 0x00178000 count 0x00008000
flush 0x00180000 count 0x00008000
flush 0x00188000 count 0x00008000
flush 0x00190000 count 0x00008000
flush 0x00198000 count 0x00008000
   102:fill_inbuf() - nvram:0xfffd0000  block_count:5
flush 0x001a0000 count 0x00005720
<960>
command line - [root=/dev/mtdblock0 mem=12M]
Jumping to boot code
ffffb8fc 0018 0000 ffffd88e ffffc08e ffffe08e ffffe88e 00bf 1020 ffffb800
0007 0
000 05ab 1000 0000 ffffff81


//
//system ... prompt (take 1:30 to get )
//
BusyBox v0.60.1 (2001.11.06-14:05+0000) Built-in shell (ash)
Enter 'help' for a list of built-in commands.

#


Patrick Allaire
mailto:pallaire@gameloft.com
If you can see it, but it's not there, it's virtual. 
If you can't see it, but it is there, it's hidden. 
It you can't see it and it isn't there, it's gone.


