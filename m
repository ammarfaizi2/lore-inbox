Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261822AbSJHKhb>; Tue, 8 Oct 2002 06:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261830AbSJHKhZ>; Tue, 8 Oct 2002 06:37:25 -0400
Received: from CPE-203-51-31-60.nsw.bigpond.net.au ([203.51.31.60]:22775 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S261822AbSJHKhW>; Tue, 8 Oct 2002 06:37:22 -0400
Message-ID: <3DA2B6B1.DB194DD6@eyal.emu.id.au>
Date: Tue, 08 Oct 2002 20:42:57 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "list, linux-kernel" <linux-kernel@vger.kernel.org>
Subject: scsi crash
References: <05256C4C.001A6B46.00@dns.searchsoftware.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting a full system lockup trying to access a SCSI tape drive.

I got it at first using an ASUS SC200 (810 based) on one machine, and
later on a Compaq Proliant 6000, which uses an 875 controller.

The newer driver at sym53c8xx_2 actually dies (full system lockup)
while being loaded without any message shown.

I assume that the tape drive has a significant problem, and consider the
"unexpected disconnect" to be an indication of this, however the
real problem is that after the driver reports this error for about a
minute (once every 3 seconds) the system locks up hard. It is this
lockup that do not expect.

This is the log of the driver being loaded:

Oct  8 13:58:14 ssa28 kernel: SCSI subsystem driver Revision: 1.00
Oct  8 13:58:14 ssa28 kernel: sym53c8xx: at PCI bus 0, device 13,
function 0
Oct  8 13:58:14 ssa28 kernel: sym53c8xx: 53c875 detected
Oct  8 13:58:14 ssa28 kernel: sym53c8xx: at PCI bus 4, device 9,
function 0
Oct  8 13:58:14 ssa28 kernel: sym53c8xx: 53c875 detected
Oct  8 13:58:14 ssa28 kernel: sym53c8xx: at PCI bus 4, device 9,
function 1
Oct  8 13:58:14 ssa28 kernel: sym53c8xx: 53c875 detected
Oct  8 13:58:14 ssa28 kernel: sym53c875-0: rev 0x4 on pci bus 0 device
13 function 0 irq 5
Oct  8 13:58:14 ssa28 kernel: sym53c875-0: ID 7, Fast-20, Parity
Checking
Oct  8 13:58:14 ssa28 kernel: sym53c875-1: rev 0x14 on pci bus 4 device
9 function 0 irq 5
Oct  8 13:58:14 ssa28 kernel: sym53c875-1: ID 7, Fast-20, Parity
Checking
Oct  8 13:58:14 ssa28 kernel: sym53c875-2: rev 0x14 on pci bus 4 device
9 function 1 irq 5
Oct  8 13:58:14 ssa28 kernel: sym53c875-2: ID 7, Fast-20, Parity
Checking
Oct  8 13:58:14 ssa28 kernel: scsi0 : sym53c8xx-1.7.3c-20010512
Oct  8 13:58:14 ssa28 kernel: scsi1 : sym53c8xx-1.7.3c-20010512
Oct  8 13:58:14 ssa28 kernel: scsi2 : sym53c8xx-1.7.3c-20010512
Oct  8 13:58:19 ssa28 kernel:   Vendor: ARCHIVE   Model: Python
28388-XXX  Rev: 4.28
Oct  8 13:58:19 ssa28 kernel:   Type:  
Sequential-Access                  ANSI SCSI revision: 02
Oct  8 13:58:42 ssa28 kernel: st: Version 20020205, bufsize 32768, wrt
30720, max init. bufs 4, s/g segs 16
Oct  8 13:58:42 ssa28 kernel: Attached scsi tape st0 at scsi0, channel
0, id 5, lun 0

and now doing
	mt -f /dev/nst0 status

Oct  8 13:59:42 ssa28 kernel: sym53c875-0: unexpected disconnect
Oct  8 13:59:42 ssa28 kernel: sym53c875-0-<5,0>: COMMAND FAILED (8a
ff)@f711d000.
Oct  8 13:59:42 ssa28 kernel: sym53c875-0: unexpected disconnect
Oct  8 13:59:42 ssa28 kernel: sym53c875-0-<5,0>: COMMAND FAILED (8a
ff)@f711d000.
Oct  8 13:59:42 ssa28 kernel: scsi0 channel 0 : resetting for second
half of retries.
Oct  8 13:59:42 ssa28 kernel: SCSI bus is being reset for host 0 channel
0.
Oct  8 13:59:42 ssa28 kernel: sym53c8xx_reset: pid=91 reset_flags=1
serial_number=0 serial_number_at_timeout=0
Oct  8 13:59:42 ssa28 kernel: scsi0: device driver called scsi_done()
for a synchronous reset.

This repeats20-30 times before the lockup, no other special message in
the logs.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
