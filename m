Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277629AbRKFCo5>; Mon, 5 Nov 2001 21:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277612AbRKFCor>; Mon, 5 Nov 2001 21:44:47 -0500
Received: from cmailg2.svr.pol.co.uk ([195.92.195.172]:22032 "EHLO
	cmailg2.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S277629AbRKFCoh>; Mon, 5 Nov 2001 21:44:37 -0500
Date: Tue, 6 Nov 2001 02:44:31 +0000
From: Berkan Eskikaya <berkan@runtime-collective.com>
To: linux-kernel@vger.kernel.org
Cc: berkan@runtime-collective.com
Subject: sym53c8xx problem
Message-ID: <20011106024430.A7893@cogs.susx.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Hardware and driver details are at the end; first, the problem:

I've been getting messages like these in the kernel logs on one of our
colocated servers:

sym53c875E-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
sym53c875E-0:0: ERROR (81:0) (8-0-0) (10/9d) @ (script 38:f31c0004).
sym53c875E-0: script cmd = e21c0004            
sym53c875E-0: regdump: da 00 00 9d 47 10 00 07 04 08 80 00 80 00 0f 02 63 00 00 00 02 ff ff ff. 
sym53c875E-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)              
scsi : aborting command due to timeout : pid 7737, scsi0, channel 0, id 0, lun 0 Read (10) 00 00 00 3c 80 00 00 80 00 
sym53c8xx_abort: pid=7737 serial_number=7752 serial_number_at_timeout=7752                  
SCSI host 0 abort (pid 7737) timed out - resetting                                
SCSI bus is being reset for host 0 channel 0.                                     
sym53c8xx_reset: pid=7737 reset_flags=2 serial_number=7752 serial_number_at_timeout=7752      


I thought this might be due to a bad card / cable so yesterday the ISP
replaced the SCSI card and cable with another pair. This morning I've 
got these in the logs:


sym53c875E-0: interrupted SCRIPT address not found.
sym53c875E-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
sym53c875E-0: interrupted SCRIPT address not found.
sym53c875E-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
sym53c875E-0:0: ERROR (81:0) (8-0-0) (10/9d) @ (script 38:f31c0004).
sym53c875E-0: script cmd = e21c0004
sym53c875E-0: regdump: da 00 00 9d 47 10 00 0f 00 08 80 00 80 00 07 02 63 00 00 00 02 ff ff ff.
sym53c875E-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
sym53c875E-0: interrupted SCRIPT address not found.
sym53c875E-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)


I'd really appreciate if somebody could shed some light on this and
recommend a solution. This has already caused a filesystem corruption
and a forced reboot.

I'm not on the list, so please Cc to berkan@runtime-collective.com
if you reply.

Cheers,

Berkan


Kernel: Linux 2.2.20pre11 for Intel x86

SCSI hardware and driver: 

[relevant bits from boot messages]

sym53c8xx: at PCI bus 0, device 11, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c875E detected with Tekram NVRAM
sym53c875E-0: rev 0x26 on pci bus 0 device 11 function 0 irq 10
sym53c875E-0: Tekram format NVRAM, ID 7, Fast-20, Parity Checking
scsi0 : sym53c8xx-1.7.1-20000726
scsi : 1 host.
  Vendor: IBM       Model: DDYS-T09170N      Rev: S80D
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
scsi : detected 1 SCSI disk total.
sym53c875E-0-<0,*>: FAST-20 WIDE SCSI 40.0 MB/s (50 ns, offset 16)
SCSI device sda: hdwr sector= 512 bytes. Sectors= 17916240 [8748 MB] [8.7 GB]

[from lspci -v]

00:0b.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c875 (rev 26)
        Subsystem: Symbios Logic Inc. (formerly NCR): Unknown device 1000
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at b800
        Memory at da800000 (32-bit, non-prefetchable)
        Memory at da000000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 1


