Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbTJXOyR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 10:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbTJXOyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 10:54:17 -0400
Received: from mail0.lsil.com ([147.145.40.20]:46822 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262240AbTJXOyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 10:54:12 -0400
Message-Id: <0E3FA95632D6D047BA649F95DAB60E57035A944F@exa-atlanta.se.lsil.com>
From: "Moore, Eric Dean" <emoore@lsil.com>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH]  2.4.23-pre8 driver udpate for MPT Fusion (2.05.10)
Date: Fri, 24 Oct 2003 10:53:59 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch for 2.4.23-pre8 kernel for MPT Fusion driver, coming from LSI
Logic.

This patch is large, so I have placed it on the LSI ftp site at:
ftp://ftp.lsil.com/HostAdapterDrivers/linux/Fusion-MPT/2.05.10/mptlinux-2.05
.10.patch

A new email address is setup for directing any MPT Fusion questions:
mpt_linux_developer@lsil.com

----------------------------------------------------------------------------
---------------------

Here is a list of the changes that have occured since the last release
of 2.05.05 made to Kernel.org last April.


(1)	Check SCSI Port Page 2 DV bits to either
disable DV or limit DV to Inquiry only checks.

(2)	Added sequence to allow the ID of a SAF-TE 
device to be stored in IOC Page 4. 

(3)	The driver now checks NVRAM data and performs Level 1 Domain 
Validation only if requested.  This limitation can be set on a 
per-device basis via the LSI Configuration Utility.

(4) 	The IOC Page 4 read is now done after the SCSI Port Settings
and the SCSI Device Page Headers are obtained.

(5)	The return code from pci_map_sg is checked and a FAILED 
status is returned if the return code indicates that a failure 
occurred, as Scatter/Gather entries are being obtained.

(6)	If IOCStatus of MPI_IOCSTATUS_STATUS_RESIDUAL_MISMATCH 
is received, an error status is returned to the SCSI layer.  
This status is received when the Fibre Channel firmware detects
a CRC error during a data transfer.

(7)	If the SCSI layer request an abort or bus reset for an 
IO that is not currently running, an error status is returned 
and the scsi_done call is not performed.  This prevents problems 
when the IO has completed before the abort or bus reset is received.

(8)	In a mixed device configuration (Ultra 320 and Non-Ultra 
320 devices are present on an HBA channel), code was fixed to prevent
 negotiating for QAS on all Ultra 320 devices on that channel.  
This keeps the Ultra 320 devices from dominating the SCSI bus, 
preventing Non-Ultra 320 IO's from executing.

(9)	The SenseBufferLength field is properly set when an IOCTL 
IO is processed.  This allows sense data to be obtained and returned 
to the application if a Check Condition occurs on the IO.

(10)	Zero out unused CDB field on SCSI IO commands.



Eric Moore
Staff Engineer
> Standard Storage Products Division
> LSI Logic Corporation
> 4420 Arrowswest Drive
> Colorado Springs, CO 80907
> Email: emoore@lsil.com
> Web: http://www.lsilogic.com/
> 
> 
> 
> 
