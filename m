Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263662AbTH0RWl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 13:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263685AbTH0RWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 13:22:41 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:702 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263662AbTH0RWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 13:22:37 -0400
Date: Wed, 27 Aug 2003 10:11:53 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1156] New: Loose IRQ or fail SCSI Commands under heavy I/O 
Message-ID: <75720000.1062004313@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1156

           Summary: Loose IRQ or fail SCSI Commands under heavy I/O
    Kernel Version: 2.6.0-test2 and test 3
            Status: NEW
          Severity: high
             Owner: bzolnier@elka.pw.edu.pl
         Submitter: dan@nerp.net


Distribution:  Debian Testing

Hardware Environment: PIII 1 Gz on Intel 815ae2 mainboard
Software Environment: cdrecord or standard GNU commands
Problem Description:  Under heavy I/O performance lags and one of the devices 
(it changes every time) will loose it's IRQ.  Sometimes the operation will 
continue, sometimes it will seg fault and every once in a while it will lock 
the PC, hard.  When using SCSI emulation to a cd-rw drive cdrecord simply seg 
faults.  When I reboot to 2.4.21 SCSI emulation works perfect.  I have swapped 
out burners and tested on an Asus A7N8X based system with the same results.

Steps to reproduce:

Compile 2.6.0-test2 or 3 w/ SCSI emulation and appropriate support for hardware.
Copy large amounts of data, 1 GB or more, from one drive to another, wait for 
IRQ to drop and lock-up the system or stop the transfer.  Or merely attempt to 
burn a CD, it fails 2 out of 3 when burning CDs.  Both problems are very 
consistent.


Device seems to be: Generic mmc CD-RW.
Current: 0x0002
Profile: 0x000A
Profile: 0x0009
Profile: 0x0008
Profile: 0x0002 (current)
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE FORCESPEED
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R
FIFO size      : 4194304 = 4096 KB
Track 01: data   404 MB
Total size:      464 MB (46:00.98) = 207074 sectors
Lout start:      464 MB (46:02/74) = 207074 sectors
cdrecord: Input/output error. test unit ready: scsi sendcmd: no error
Segmentation Fault


I cannot post a copy of the IRQ failure becuase it's lock-up every time now.


