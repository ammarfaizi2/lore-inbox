Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTLPQXf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 11:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbTLPQXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 11:23:35 -0500
Received: from intra.cyclades.com ([64.186.161.6]:46265 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261872AbTLPQXc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 11:23:32 -0500
Date: Tue, 16 Dec 2003 14:12:03 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Jeremy Kusnetz <JKusnetz@nrtc.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Philippe Troin <phil@fifi.org>, <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.23 is freezing my systems hard after 24-48 hours
In-Reply-To: <F7F4B5EA9EBD414D8A0091E80389450569D3D6@exchange.nrtc.coop>
Message-ID: <Pine.LNX.4.44.0312161409000.1533-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Dec 2003, Jeremy Kusnetz wrote:

> > Are you using netfilter? There is a known netfilter hang problem.
> No, I have the netfilter options compiled in as modules, but I'm not actually loading them.
> 
> > What workload you have on the production boxes? (what is running, etc)
> They can get pretty high, they average 1.5-4 and can spike to 15 or even occationally much higher, but I don't think the ones that crashed ever got above 10.  When they did crash they were under relativily low load.  I have 8 nodes in an LVS cluster all doing the same thing, mail (qmail,pop,imap), web(apache,java servlets), ftp, bind.  I actually capture top and ps outputs every minute, so I do have the last capture before the crash if you would like that.
> 
> loop: loaded (max 8 devices)
> Compaq SMART2 Driver (v 2.4.25)
> cpqarray: Device 0x10 has been found at bus 0 dev 1 func 0
> cpqarray: Finding drives on ida0 (Integrated Array)
> cpqarray ida/c0d0: blksz=512 nr_blks=71122560
> cpqarray: Starting firmware's background processing
> blk: queue c046fd40, I/O limit 4095Mb (mask 0xffffffff)
> Partition check:
>  ida/c0d0: p1 p2 p3
> HP CISS Driver (v 2.4.50)
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 1919M
> agpgart: no supported devices found.
> [drm] Initialized tdfx 1.0.0 20010216 on minor 0
> [drm] Initialized radeon 1.7.0 20020828 on minor 1
> [drm:drm_init] *ERROR* Cannot initialize the agpgart module.
> Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> hdc: CD-224E, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hdc: attached ide-cdrom driver.
> hdc: ATAPI 24X CD-ROM drive, 512kB Cache
> Uniform CD-ROM driver Revision: 3.12
> SCSI subsystem driver Revision: 1.00
> kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
> kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
> kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
> Linux Kernel Card Services 3.1.22
>   options:  [pci] [cardbus] [pm]
> usb.c: registered new driver hub
> host/uhci.c: USB Universal Host Controller Interface driver v1.1
> Initializing USB Mass Storage driver...
> usb.c: registered new driver usb-storage
> USB Mass Storage support registered.
> LVM version 1.0.7(28/03/2003)
> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> cpqphp.o: Compaq Hot Plug PCI Controller Driver version: 0.9.7
> Initializing Cryptographic API
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 16384 buckets, 128Kbytes
> TCP: Hash tables configured (established 262144 bind 65536)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> ds: no socket drivers loaded!
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> Freeing unused kernel memory: 112k freed
> Adding Swap: 999592k swap-space (priority -1)
> EXT3 FS 2.4-0.9.19, 19 August 2002 on ida0(72,1), internal journal
> CSLIP: code copyright 1989 Regents of the University of California
> SLIP: version 0.8.4-NET3.019-NEWTTY-MODULAR (dynamic channels, max=256).
> SLIP linefill/keepalive option.
> PPP generic driver version 2.4.2
> PPP BSD Compression module registered
> Intel(R) PRO/100 Network Driver - version 2.3.30-k1
> Copyright (c) 2003 Intel Corporation
> 
> e100: Using specified speed/duplex mode of 4
> e100: selftest OK.
> e100: eth0: Intel(R) PRO/100 Network Connection
>   Hardware receive checksums enabled
>   cpu cycle saver enabled
> 
> e100: Using specified speed/duplex mode of 4
> e100: selftest OK.
> e100: eth1: Intel(R) PRO/100 Network Connection
>   Hardware receive checksums enabled
>   cpu cycle saver enabled

There are no significant changes in e100. 

There are a few cciss modifications but they dont look like being the 
reason for this. 

Please try the NMI oopser. 


