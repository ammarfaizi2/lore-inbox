Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318877AbSHLXby>; Mon, 12 Aug 2002 19:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318876AbSHLXby>; Mon, 12 Aug 2002 19:31:54 -0400
Received: from [198.70.193.2] ([198.70.193.2]:51040 "EHLO AVEXCH01.qlogic.org")
	by vger.kernel.org with ESMTP id <S318875AbSHLXbs> convert rfc822-to-8bit;
	Mon, 12 Aug 2002 19:31:48 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [ANNOUNCE] QLogic FC Driver for Linux 6.01b4 Released.
Date: Mon, 12 Aug 2002 16:33:35 -0700
Message-ID: <B179AE41C1147041AA1121F44614F0B004F759@AVEXCH02.qlogic.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ANNOUNCE] QLogic FC Driver for Linux 6.01b4 Released.
Thread-Index: AcJCWQaHW0+viavHEda19QCw0FRShg==
From: "Andrew Vasquez" <andrew.vasquez@qlogic.com>
To: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Cc: <coughlan@redhat.com>, <arjanv@redhat.com>, <johnsonm@redhat.com>,
       "Ryan Klein" <ryan.klein@qlogic.com>,
       "Arun Mittal" <arun.mittal@qlogic.com>,
       "Duane Grigsby" <duane.grigsby@qlogic.com>
X-OriginalArrivalTime: 12 Aug 2002 23:33:43.0664 (UTC) FILETIME=[B25AB700:01C24258]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

QLogic is pleased to announce the 6.01b4 release of its qla2xxx driver for
ISP2100/ISP22xx/ISP23xx chips and HBAs.

Major improvements from the 5.3x driver series include:

	o Robust and stable failover implementation
	o Fast-path cleanup
	o Support for the new error-handling routines
	o Report-luns scan
	o ISP2342 support
	o IP via FC support (RFC 2625)
	o ISP2100 support.
	o 64bit DMA addressing
	o Remove virt_to_bus/kmalloc --> pci_* routines
	o Memory mapped I/O support
	o General code-sanitizing
		- locking structures
		- queue structures
		- extraneous NOP *LOCK/UNLOCK macros
		- remove old EH routines
		- remove serial console routines

The 6.xx series driver supports kernels 2.4.x and above ONLY, and contains most
of Arjan van de Ven's (Redhat) changes made to the 5.31 driver.

A side note regarding ISP2100 support: QLogic has formally retired the QLA2100
card and will *not* provide technical support for these chips and HBAs.  The
initial 6.xx series drivers were stripped of ISP2100 card recognition.  The
current ISP2100 support was forward-ported from 5.3x.  From an engineering
standpoint, any patches or fixes for the ISP2100 will be considered.

The driver distribution can be downloaded at:

	http://download.qlogic.com/drivers/5537/qla2x00-v6.1b4-dist.tgz

The distribution contains three main components:

	qla2x00src-vX.YY.tgz	-- The FC/SCSI driver
	qla2xipsrc-vM.NN.tgz	-- The IP network driver
	qlapi-P.QQ-rel.tgz	-- The SNIA API library


Changes since 6.01b2 distribution:
----------------------------------

  QLA2X00:

	- Remove qla_dbg.h and qla_def.h files from driver
	  distribution.
	- Remove all virt_to_* calls in both SCSI/IP driver sources.
	  - 64bit DMA addressing through dma_addr_t.
	- Cleanup structure names/member variables from IP sources.
	- Add QL_DEBUG_LEVEL_12 for IP debugging.
	- Add transmission timeout callback for IP driver.
	- Enable SRAM, Instruction RAM and GP RAM parity checks on
	  ISP2300s.
	- Display all luns recognized by driver in /proc, not just
	  SCSI mid-layer scanned luns.  Luns not scanned by the mid-
	  layer are marked with an asterisk (*).
	  - Add FC_SUPPORT_RPT_LUNS flag to the struct fc_port.flags.
	    Set, if the device supported the report luns command.
	- Increase Inquiry request buffer to 36 rather than 4.  Some
	  target devices have problems with the small transfer.
	- Fix assignment of current_speed during an asyncronous event
	  MBA_LOOP_UP.  Improper connection speed was being reported
	  to EXIOCTs and IP driver.
	- Add ISP2100 support:
	  - QLogic provides no support for the ISP2100.
	  - compiled binary name qla2100.o.
	  - Forward-port chip support from 5.[2|3]x series driver.
	  - Update Makefile.kernel and Config.in.
	  - add new 2100 TP firmware (1.19.24).
	- Fix copy-error in qla2x00_fo_get_params() where the
	  qla_fo_params notification CDB would be zero'd-out.
	- Fix kernel-oops when DEBUG level 5 is enabled and a command
	  is sent to a non-existent lun.
	- Fix in-kernel compilation problem (Veritas).
	- Remove superfluous KMALLOC*/KMFREE/BZERO/BCOPY/
	  BCMP/qla_bcopy defines and functions.
	- Remove unused ql_list_link structures and functions.
	- Consistent use of copy_to/from_user() functions (RH).
	- Consistent use of scsi_qla_host_t instead of
	  several aliases (RH).
	- Remove illegal usage of caddr_t (RH).
	- Remove Target-Mode support from driver.
	- Cleanup qla_fo.c file:
	  - Remove old debugging code.
	  - General sanitizing.
	- Cleanup compiler warnings during debug builds.
	- Add new 2300 IP/TP firmware (3.01.13).

  QLA2XIP:

	- Requires v6.01b4 SCSI driver.
  	- Add completion status to send and receive control buffers.
  	- Add support for specifying the MTU (mtu) and Receive
	  buffers count (buffers) on the modules command line.
	- Add NETIF_F_HIGHDMA to the device feature flags if 64bit
	  DMA addressing possible.
	- Add tx_timeout() implementation.
	- Add display of link connection speed during initialization.
	- Fix race in qla2xip_free_send_cb().
	- Remove all virt_to_* calls in driver sources.
	  - 64bit DMA addressing through dma_addr_t.
	- Use system-defined structures for network/ethernet
	  support.
	  - Use hton/ntoh functions.
	- Cleanup structure names/member variables.

Regards,
Andrew Vasquez
QLogic Corporation
andrew.vasquez@qlogic.com
