Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422647AbWCJAi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422647AbWCJAi2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWCJAhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:37:09 -0500
Received: from mx.pathscale.com ([64.160.42.68]:63117 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752136AbWCJAfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:35:46 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 1 of 20] ipath - core driver header files
X-Mercurial-Node: 2a9e52d59741a1d96d27a72ed0492a857d5f93e4
Message-Id: <2a9e52d59741a1d96d27.1141950931@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1141950930@eng-12.pathscale.com>
Date: Thu,  9 Mar 2006 16:35:31 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r d4136de1a941 -r 2a9e52d59741 drivers/infiniband/hw/ipath/ipath_common.h
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_common.h	Thu Mar  9 16:15:10 2006 -0800
@@ -0,0 +1,582 @@
+/*
+ * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#ifndef _IPATH_COMMON_H
+#define _IPATH_COMMON_H
+
+/*
+ * This file contains defines, structures, etc. that are used
+ * to communicate between kernel and user code.
+ */
+
+/* This is the IEEE-assigned OUI for PathScale, Inc. */
+#define IPATH_SRC_OUI_1 0x00
+#define IPATH_SRC_OUI_2 0x11
+#define IPATH_SRC_OUI_3 0x75
+
+/* version of protocol header (known to chip also). In the long run,
+ * we should be able to generate and accept a range of version numbers;
+ * for now we only accept one, and it's compiled in.
+ */
+#define IPS_PROTO_VERSION 2
+
+/*
+ * These are compile time constants that you may want to enable or disable
+ * if you are trying to debug problems with code or performance.
+ * IPATH_VERBOSE_TRACING define as 1 if you want additional tracing in
+ * fastpath code
+ * IPATH_TRACE_REGWRITES define as 1 if you want register writes to be
+ * traced in faspath code
+ * _IPATH_TRACING define as 0 if you want to remove all tracing in a
+ * compilation unit
+ * _IPATH_DEBUGGING define as 0 if you want to remove debug prints
+ */
+
+/*
+ * The value in the BTH QP field that InfiniPath uses to differentiate
+ * an infinipath protocol IB packet vs standard IB transport
+ */
+#define IPATH_KD_QP 0x656b79
+
+/*
+ * valid states passed to ipath_set_linkstate() user call
+ */
+#define IPATH_IB_LINKDOWN		0
+#define IPATH_IB_LINKARM		1
+#define IPATH_IB_LINKACTIVE		2
+#define IPATH_IB_LINKINIT		3
+#define IPATH_IB_LINKDOWN_SLEEP		4
+#define IPATH_IB_LINKDOWN_DISABLE	5
+
+/*
+ * stats maintained by the driver.  For now, at least, this is global
+ * to all minor devices.
+ */
+struct infinipath_stats {
+	__u64 sps_ints;		/* number of interrupts taken */
+	__u64 sps_errints;	/* number of interrupts for errors */
+	/* number of errors from chip (not including packet errors or CRC) */
+	__u64 sps_errs;
+	/* number of packet errors from chip other than CRC */
+	__u64 sps_pkterrs;
+	/* number of packets with CRC errors (ICRC and VCRC) */
+	__u64 sps_crcerrs;
+	/* number of hardware errors reported (parity, etc.) */
+	__u64 sps_hwerrs;
+	/* number of times IB link changed state unexpectedly */
+	__u64 sps_iblink;
+	__u64 sps_unused3;	/* no longer used; left for compatibility */
+	__u64 sps_port0pkts;	/* number of kernel (port0) packets received */
+	/* number of "ethernet" packets sent by driver */
+	__u64 sps_ether_spkts;
+	/* number of "ethernet" packets received by driver */
+	__u64 sps_ether_rpkts;
+	__u64 sps_sma_spkts;	/* number of SMA packets sent by driver */
+	__u64 sps_sma_rpkts;	/* number of SMA packets received by driver */
+	/* number of times all ports rcvhdrq was full and packet dropped */
+	__u64 sps_hdrqfull;
+	/* number of times all ports egrtid was full and packet dropped */
+	__u64 sps_etidfull;
+	/*
+	 * number of times we tried to send from driver, but no pio
+	 * buffers avail
+	 */
+	__u64 sps_nopiobufs;
+	__u64 sps_ports;	/* number of ports currently open */
+	/* list of pkeys (other than default) accepted (0 means not set) */
+	__u16 sps_pkeys[4];
+	/* lids for up to 4 infinipaths, indexed by infinipath # */
+	__u16 sps_lid[4];
+	/* number of user ports per chip (not IB ports) */
+	__u32 sps_nports;
+	__u32 sps_nullintr;	/* not our interrupt, or already handled */
+	__u32 sps_maxpkts_call;	/* max number of packets handled per receive call */
+	__u32 sps_avgpkts_call;	/* avg number of packets handled per receive call */
+	__u64 sps_pagelocks;	/* total number of pages locked */
+	__u64 sps_pageunlocks;	/* total number of pages unlocked */
+	/*
+	 * Number of packets dropped in kernel other than errors
+	 * (ether packets if ipath not configured, sma/mad, etc.)
+	 */
+	__u64 sps_krdrops;
+	/* mlids for up to 4 infinipaths, indexed by infinipath # */
+	__u16 sps_mlid[4];
+	__u64 __sps_pad[45];	/* pad for future growth */
+};
+
+/*
+ * These are the status bits readable (in ascii form, 64bit value)
+ * from the "status" sysfs file.
+ */
+#define IPATH_STATUS_INITTED       0x1	/* basic driver initialization done */
+#define IPATH_STATUS_DISABLED      0x2	/* hardware disabled */
+#define IPATH_STATUS_UNUSED        0x4	/* available */
+#define IPATH_STATUS_OIB_SMA       0x8	/* ipath_mad kernel SMA running */
+#define IPATH_STATUS_SMA          0x10	/* user SMA running */
+/* Chip has been found and initted */
+#define IPATH_STATUS_CHIP_PRESENT 0x20
+#define IPATH_STATUS_IB_READY     0x40	/* IB link is at ACTIVE, has LID,
+					 * usable for all VL's */
+/* after link up, LID,MTU,etc. has been configured */
+#define IPATH_STATUS_IB_CONF      0x80
+/* no link established, probably no cable */
+#define IPATH_STATUS_IB_NOCABLE  0x100
+/* A Fatal hardware error has occurred. */
+#define IPATH_STATUS_HWERROR     0x200
+
+/* The list of usermode accessible registers.  Also see Reg_* later in file */
+typedef enum _ipath_ureg {
+	ur_rcvhdrtail = 0,	/* (RO)  DMA RcvHdr to be used next. */
+	/* (RW)  RcvHdr entry to be processed next by host. */
+	ur_rcvhdrhead = 1,
+	ur_rcvegrindextail = 2,	/* (RO)  Index of next Eager index to use. */
+	ur_rcvegrindexhead = 3,	/* (RW)  Eager TID to be processed next */
+	/* For internal use only; max register number. */
+	_IPATH_UregMax
+} ipath_ureg;
+
+/* bit values for spi_runtime_flags */
+#define IPATH_RUNTIME_HT	0x1
+#define IPATH_RUNTIME_PCIE	0x2
+#define IPATH_RUNTIME_FORCE_WC_ORDER	0x4
+#define IPATH_RUNTIME_RCVHDR_COPY	0x8
+
+/*
+ * This structure is returned by ipath_userinit() immediately after
+ * open to get implementation-specific info, and info specific to this
+ * instance.
+ *
+ * This struct must have explict pad fields where type sizes
+ * may result in different alignments between 32 and 64 bit
+ * programs, since the 64 bit * bit kernel requires the user code
+ * to have matching offsets
+ */
+struct ipath_base_info {
+	/* version of hardware, for feature checking. */
+	__u32 spi_hw_version;
+	/* version of software, for feature checking. */
+	__u32 spi_sw_version;
+	/* InfiniPath port assigned, goes into sent packets */
+	__u32 spi_port;
+	/*
+	 * IB MTU, packets IB data must be less than this.
+	 * The MTU is in bytes, and will be a multiple of 4 bytes.
+	 */
+	__u32 spi_mtu;
+	/*
+	 * size of a PIO buffer.  Any given packet's total
+	 * size must be less than this (in words).  Included is the
+	 * starting control word, so if 513 is returned, then total
+	 * pkt size is 512 words or less.
+	 */
+	__u32 spi_piosize;
+	/* size of the TID cache in infinipath, in entries */
+	__u32 spi_tidcnt;
+	/* size of the TID Eager list in infinipath, in entries */
+	__u32 spi_tidegrcnt;
+	/* size of a single receive header queue entry. */
+	__u32 spi_rcvhdrent_size;
+	/* Count of receive header queue entries allocated.
+	 * This may be less than the spu_rcvhdrcnt passed in!.
+	 */
+	__u32 spi_rcvhdr_cnt;
+
+	/* per-chip and other runtime features bitmap (IPATH_RUNTIME_*) */
+	__u32 spi_runtime_flags;
+
+	/* address where receive buffer queue is mapped into */
+	__u64 spi_rcvhdr_base;
+
+	/* user program. */
+
+	/* base address of eager TID receive buffers. */
+	__u64 spi_rcv_egrbufs;
+
+	/* Allocated by initialization code, not by protocol. */
+
+	/* size of each TID buffer in host memory,
+	 * starting at spi_rcv_egrbufs.  The buffers are virtually contiguous
+	 */
+	__u32 spi_rcv_egrbufsize;
+	/*
+	 * The special QP (queue pair) value that identifies an infinipath
+	 * protocol packet from standard IB packets.  More, probably much
+	 * more, to be added.
+	 */
+	__u32 spi_qpair;
+
+	/*
+	 * user register base for init code, not to be used directly by
+	 * protocol or applications
+	 */
+	__u64 __spi_uregbase;
+	/*
+	 * maximum buffer size in bytes that can be used in a
+	 * single TID entry (assuming the buffer is aligned to this boundary).
+	 * This is the minimum of what the hardware and software support
+	 * Guaranteed to be a power of 2.
+	 */
+	__u32 spi_tid_maxsize;
+	/*
+	 * alignment of each pio send buffer (byte count
+	 * to add to spi_piobufbase to get to second buffer)
+	 */
+	__u32 spi_pioalign;
+	/*
+	 * the index of the first pio buffer available
+	 * to this process; needed to do lookup in spi_pioavailaddr; not added
+	 * to spi_piobufbase
+	 */
+	__u32 spi_pioindex;
+	__u32 spi_piocnt;	/* number of buffers mapped for this process */
+
+	/*
+	 * base address of writeonly pio buffers for this process.
+	 * Each buffer has spi_piosize words, and is aligned on spi_pioalign
+	 * boundaries.  spi_piocnt buffers are mapped from this address
+	 */
+	__u64 spi_piobufbase;
+
+	/*
+	 * base address of readonly memory copy of the pioavail registers.
+	 * There are 2 bits for each buffer.
+	 */
+	__u64 spi_pioavailaddr;
+
+	/*
+	 * Address where driver updates a copy
+	 * of the interface and driver status (IPATH_STATUS_*) as a 64 bit value
+	 * It's followed by a string indicating hardware error, if there was one
+	 */
+	__u64 spi_status;
+
+	/* number of chip ports available to user processes */
+	__u32 spi_nports;
+	__u32 spi_unit;		/* unit number of chip we are using */
+	__u32 spi_rcv_egrperchunk;	/* num bufs in each contiguous set */
+	/* size in bytes of each contiguous set */
+	__u32 spi_rcv_egrchunksize;
+	/* total size of mmap to cover full rcvegrbuffers */
+	__u32 spi_rcv_egrbuftotlen;
+} __attribute__ ((aligned(8)));
+
+
+/*
+ * This version number is given to the driver by the user code during
+ * initialization in the spu_userversion field of ipath_user_info, so
+ * the driver can check for compatibility with user code.
+ *
+ * The major version changes when data structures
+ * change in an incompatible way.  The driver must be the same or higher
+ * for initialization to succeed.  In some cases, a higher version
+ * driver will not interoperate with older software, and initialization
+ * will return an error.
+ */
+#define IPATH_USER_SWMAJOR 1
+
+/*
+ * Minor version differences are always compatible
+ * a within a major version, however if if user software is larger
+ * than driver software, some new features and/or structure fields
+ * may not be implemented; the user code must deal with this if it
+ * cares, or it must abort after initialization reports the difference
+ */
+#define IPATH_USER_SWMINOR 2
+
+#define IPATH_USER_SWVERSION ((IPATH_USER_SWMAJOR<<16) | IPATH_USER_SWMINOR)
+
+#define IPATH_KERN_TYPE 0
+
+/* Similarly, this is the kernel version going back to the user.  It's slightly
+ * different, in that we want to tell if the driver was built as part of a
+ * PathScale release, or from the driver from OpenIB, kernel.org, or a
+ * standard distribution, for support reasons.  The high bit is 0 for
+ * non-PathScale, and 1 for PathScale-built/supplied.
+ *
+ * It's returned by the driver to the user code during initialization
+ * in the spi_sw_version field of ipath_base_info, so the user code can
+ * in turn check for compatibility with the kernel.
+*/
+#define IPATH_KERN_SWVERSION ((IPATH_KERN_TYPE<<31) | IPATH_USER_SWVERSION)
+
+/*
+ * This structure is passed to ipath_userinit() to tell the driver where
+ * user code buffers are, sizes, etc.   The offsets and sizes of the
+ * fields must remain unchanged, for binary compatibility.  It can
+ * be extended, if userversion is changed so user code can tell, if needed
+ */
+struct ipath_user_info {
+	/*
+	 * version of user software, to detect compatibility issues.
+	 * Should be set to IPATH_USER_SWVERSION.
+	 */
+	__u32 spu_userversion;
+
+	/* desired number of receive header queue entries */
+	__u32 spu_rcvhdrcnt;
+
+	/* size of struct base_info to write to */
+	__u32 spu_base_info_size;
+
+	/*
+	 * number of words in KD protocol header
+	 * This tells InfiniPath how many words to copy to rcvhdrq.  If 0,
+	 * kernel uses a default.  Once set, attempts to set any other value
+	 * are an error (EAGAIN) until driver is reloaded.
+	 */
+	__u32 spu_rcvhdrsize;
+
+	/*
+	 * cache line aligned (64 byte) user address to
+	 * which the rcvhdrtail register will be written by infinipath
+	 * whenever it changes, so that no chip registers are read in
+	 * the performance path.
+	 */
+	__u64 spu_rcvhdraddr;
+
+	/*
+	 * address of struct base_info to write to
+	 */
+	__u64 spu_base_info;
+
+} __attribute__ ((aligned(8)));
+
+/* User commands. */
+
+#define IPATH_CMD_MIN		16
+
+#define IPATH_CMD_USER_INIT	16	/* set up userspace */
+#define IPATH_CMD_PORT_INFO	17	/* find out what resources we got */
+#define IPATH_CMD_RECV_CTRL	18	/* control receipt of packets */
+#define IPATH_CMD_TID_UPDATE	19	/* update expected TID entries */
+#define IPATH_CMD_TID_FREE	20	/* free expected TID entries */
+#define IPATH_CMD_SET_PART_KEY	21	/* add partition key */
+
+#define IPATH_CMD_MAX		21
+
+struct ipath_port_info {
+	__u32 num_active;	/* number of active units */
+	__u32 unit;		/* unit (chip) assigned to caller */
+	__u32 port;		/* port on unit assigned to caller */
+};
+
+struct ipath_tid_info {
+	__u32 tidcnt;
+	__u32 tid__unused;	/* make structure same size in 32 and 64 bit */
+	__u64 tidvaddr;		/* virtual address of first page in transfer */
+	/* pointer (same size 32/64 bit) to __u16 tid array */
+	__u64 tidlist;
+
+	/*
+	 * pointer (same size 32/64 bit) to bitmap of TIDs used
+	 * for this call; checked for being large enough at open
+	 */
+	__u64 tidmap;
+};
+
+struct ipath_cmd {
+	__u32 type;			/* command type */
+	union {
+		struct ipath_tid_info tid_info;
+		struct ipath_user_info user_info;
+		/* address in userspace of struct ipath_port_info to
+		   write result to */
+		__u64 port_info;
+		/* enable/disable receipt of packets */
+		__u32 recv_ctrl;
+		/* partition key to set */
+		__u16 part_key;
+	} cmd;
+};
+
+struct ipath_iovec {
+	/* Pointer to data, but same size 32 and 64 bit */
+	__u64 iov_base;
+
+	/*
+	 * Length of data; don't need 64 bits, but want
+	 * ipath_sendpkt to remain same size as before 32 bit changes, so...
+	 */
+	__u64 iov_len;
+};
+
+/*
+ * Describes a single packet for send.  Each packet can have one or more
+ * buffers, but the total length (exclusive of IB headers) must be less
+ * than the MTU, and if using the PIO method, entire packet length,
+ * including IB headers, must be less than the ipath_piosize value (words).
+ * Use of this necessitates including sys/uio.h
+ */
+struct __ipath_sendpkt {
+	__u32 sps_flags;	/* flags for packet (TBD) */
+	__u32 sps_cnt;		/* number of entries to use in sps_iov */
+	/* array of iov's describing packet. TEMPORARY */
+	struct ipath_iovec sps_iov[4];
+};
+
+/* Passed into SMA special file's ->read and ->write methods. */
+struct ipath_sma_pkt
+{
+	__u32 unit;	/* unit on which to send packet */
+	__u64 data;	/* address of payload in userspace */
+	__u32 len;	/* length of payload */
+};
+
+/*
+ * Data layout in I2C flash (for GUID, etc.)
+ * All fields are little-endian binary unless otherwise stated
+ */
+#define IPATH_FLASH_VERSION 1
+struct ipath_flash {
+	__u8 if_fversion;	/* flash layout version (IPATH_FLASH_VERSION) */
+	__u8 if_csum;		/* checksum protecting if_length bytes */
+	/*
+	 * valid length (in use, protected by if_csum), including if_fversion
+	 * and if_sum themselves)
+	 */
+	__u8 if_length;
+	__u8 if_guid[8];	/* the GUID, in network order */
+	/* number of GUIDs to use, starting from if_guid */
+	__u8 if_numguid;
+	char if_serial[12];	/* the board serial number, in ASCII */
+	char if_mfgdate[8];	/* board mfg date (YYYYMMDD ASCII) */
+	/* last board rework/test date (YYYYMMDD ASCII) */
+	char if_testdate[8];
+	__u8 if_errcntp[4];	/* logging of error counts, TBD */
+	/* powered on hours, updated at driver unload */
+	__u8 if_powerhour[2];
+	char if_comment[32];	/* ASCII free-form comment field */
+	__u8 if_future[50];	/* 78 bytes used, min flash size is 128 bytes */
+};
+
+/*
+ * These are the counters implemented in the chip, and are listed in order.
+ * The InterCaps naming is taken straight from the chip spec.
+ */
+struct infinipath_counters {
+	__u64 LBIntCnt;
+	__u64 LBFlowStallCnt;
+	__u64 Reserved1;
+	__u64 TxUnsupVLErrCnt;
+	__u64 TxDataPktCnt;
+	__u64 TxFlowPktCnt;
+	__u64 TxDwordCnt;
+	__u64 TxLenErrCnt;
+	__u64 TxMaxMinLenErrCnt;
+	__u64 TxUnderrunCnt;
+	__u64 TxFlowStallCnt;
+	__u64 TxDroppedPktCnt;
+	__u64 RxDroppedPktCnt;
+	__u64 RxDataPktCnt;
+	__u64 RxFlowPktCnt;
+	__u64 RxDwordCnt;
+	__u64 RxLenErrCnt;
+	__u64 RxMaxMinLenErrCnt;
+	__u64 RxICRCErrCnt;
+	__u64 RxVCRCErrCnt;
+	__u64 RxFlowCtrlErrCnt;
+	__u64 RxBadFormatCnt;
+	__u64 RxLinkProblemCnt;
+	__u64 RxEBPCnt;
+	__u64 RxLPCRCErrCnt;
+	__u64 RxBufOvflCnt;
+	__u64 RxTIDFullErrCnt;
+	__u64 RxTIDValidErrCnt;
+	__u64 RxPKeyMismatchCnt;
+	__u64 RxP0HdrEgrOvflCnt;
+	__u64 RxP1HdrEgrOvflCnt;
+	__u64 RxP2HdrEgrOvflCnt;
+	__u64 RxP3HdrEgrOvflCnt;
+	__u64 RxP4HdrEgrOvflCnt;
+	__u64 RxP5HdrEgrOvflCnt;
+	__u64 RxP6HdrEgrOvflCnt;
+	__u64 RxP7HdrEgrOvflCnt;
+	__u64 RxP8HdrEgrOvflCnt;
+	__u64 Reserved6;
+	__u64 Reserved7;
+	__u64 IBStatusChangeCnt;
+	__u64 IBLinkErrRecoveryCnt;
+	__u64 IBLinkDownedCnt;
+	__u64 IBSymbolErrCnt;
+};
+
+/*
+ * The next set of defines are for packet headers, and chip register
+ * and memory bits that are visible to and/or used by user-mode software
+ * The other bits that are used only by the driver or diags are in
+ * ipath_registers.h
+ */
+
+/* RcvHdrFlags bits */
+#define INFINIPATH_RHF_LENGTH_MASK 0x7FF
+#define INFINIPATH_RHF_LENGTH_SHIFT 0
+#define INFINIPATH_RHF_RCVTYPE_MASK 0x7
+#define INFINIPATH_RHF_RCVTYPE_SHIFT 11
+#define INFINIPATH_RHF_EGRINDEX_MASK 0x7FF
+#define INFINIPATH_RHF_EGRINDEX_SHIFT 16
+#define INFINIPATH_RHF_H_ICRCERR   0x80000000
+#define INFINIPATH_RHF_H_VCRCERR   0x40000000
+#define INFINIPATH_RHF_H_PARITYERR 0x20000000
+#define INFINIPATH_RHF_H_LENERR    0x10000000
+#define INFINIPATH_RHF_H_MTUERR    0x08000000
+#define INFINIPATH_RHF_H_IHDRERR   0x04000000
+#define INFINIPATH_RHF_H_TIDERR    0x02000000
+#define INFINIPATH_RHF_H_MKERR     0x01000000
+#define INFINIPATH_RHF_H_IBERR     0x00800000
+#define INFINIPATH_RHF_L_SWA       0x00008000
+#define INFINIPATH_RHF_L_SWB       0x00004000
+
+/* infinipath header fields */
+#define INFINIPATH_I_VERS_MASK 0xF
+#define INFINIPATH_I_VERS_SHIFT 28
+#define INFINIPATH_I_PORT_MASK 0xF
+#define INFINIPATH_I_PORT_SHIFT 24
+#define INFINIPATH_I_TID_MASK 0x7FF
+#define INFINIPATH_I_TID_SHIFT 13
+#define INFINIPATH_I_OFFSET_MASK 0x1FFF
+#define INFINIPATH_I_OFFSET_SHIFT 0
+
+/* K_PktFlags bits */
+#define INFINIPATH_KPF_INTR 0x1
+
+/* SendPIO per-buffer control */
+#define INFINIPATH_SP_LENGTHP1_MASK 0x3FF
+#define INFINIPATH_SP_LENGTHP1_SHIFT 0
+#define INFINIPATH_SP_INTR    0x80000000
+#define INFINIPATH_SP_TEST    0x40000000
+#define INFINIPATH_SP_TESTEBP 0x20000000
+
+/* SendPIOAvail bits */
+#define INFINIPATH_SENDPIOAVAIL_BUSY_SHIFT 1
+#define INFINIPATH_SENDPIOAVAIL_CHECK_SHIFT 0
+
+#endif				/* _IPATH_COMMON_H */
diff -r d4136de1a941 -r 2a9e52d59741 drivers/infiniband/hw/ipath/ipath_debug.h
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_debug.h	Thu Mar  9 16:15:10 2006 -0800
@@ -0,0 +1,96 @@
+/*
+ * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#ifndef _IPATH_DEBUG_H
+#define _IPATH_DEBUG_H
+
+#ifndef _IPATH_DEBUGGING	/* debugging enabled or not */
+#define _IPATH_DEBUGGING 1
+#endif
+
+#if _IPATH_DEBUGGING
+
+/*
+ * Mask values for debugging.  The scheme allows us to compile out any
+ * of the debug tracing stuff, and if compiled in, to enable or disable
+ * dynamically.  This can be set at modprobe time also:
+ *      modprobe infinipath.ko infinipath_debug=7
+ */
+
+#define __IPATH_INFO        0x1	/* generic low verbosity stuff */
+#define __IPATH_DBG         0x2	/* generic debug */
+#define __IPATH_TRSAMPLE    0x8	/* generate trace buffer sample entries */
+/* leave some low verbosity spots open */
+#define __IPATH_VERBDBG     0x40	/* very verbose debug */
+#define __IPATH_PKTDBG      0x80	/* print packet data */
+/* print process startup (init)/exit messages */
+#define __IPATH_PROCDBG     0x100
+/* print mmap/nopage stuff, not using VDBG any more */
+#define __IPATH_MMDBG       0x200
+#define __IPATH_USER_SEND   0x1000	/* use user mode send */
+#define __IPATH_KERNEL_SEND 0x2000	/* use kernel mode send */
+#define __IPATH_EPKTDBG     0x4000	/* print ethernet packet data */
+#define __IPATH_SMADBG      0x8000	/* sma packet debug */
+#define __IPATH_IPATHDBG    0x10000	/* Ethernet (IPATH) general debug on */
+#define __IPATH_IPATHWARN   0x20000	/* Ethernet (IPATH) warnings on */
+#define __IPATH_IPATHERR    0x40000	/* Ethernet (IPATH) errors on */
+#define __IPATH_IPATHPD     0x80000	/* Ethernet (IPATH) packet dump on */
+#define __IPATH_IPATHTABLE  0x100000	/* Ethernet (IPATH) table dump on */
+
+#else				/* _IPATH_DEBUGGING */
+
+/*
+ * define all of these even with debugging off, for the few places that do
+ * if(infinipath_debug & _IPATH_xyzzy), but in a way that will make the
+ * compiler eliminate the code
+ */
+
+#define __IPATH_INFO      0x0	/* generic low verbosity stuff */
+#define __IPATH_DBG       0x0	/* generic debug */
+#define __IPATH_TRSAMPLE  0x0	/* generate trace buffer sample entries */
+#define __IPATH_VERBDBG   0x0	/* very verbose debug */
+#define __IPATH_PKTDBG    0x0	/* print packet data */
+#define __IPATH_PROCDBG   0x0	/* print process startup (init)/exit messages */
+/* print mmap/nopage stuff, not using VDBG any more */
+#define __IPATH_MMDBG     0x0
+#define __IPATH_EPKTDBG   0x0	/* print ethernet packet data */
+#define __IPATH_SMADBG    0x0   /* print process startup (init)/exit messages */#define __IPATH_IPATHDBG  0x0	/* Ethernet (IPATH) table dump on */
+#define __IPATH_IPATHWARN 0x0	/* Ethernet (IPATH) warnings on   */
+#define __IPATH_IPATHERR  0x0	/* Ethernet (IPATH) errors on   */
+#define __IPATH_IPATHPD   0x0	/* Ethernet (IPATH) packet dump on   */
+#define __IPATH_IPATHTABLE 0x0	/* Ethernet (IPATH) packet dump on   */
+
+#endif				/* _IPATH_DEBUGGING */
+
+#define __IPATH_VERBOSEDBG __IPATH_VERBDBG
+
+#endif				/* _IPATH_DEBUG_H */
diff -r d4136de1a941 -r 2a9e52d59741 drivers/infiniband/hw/ipath/ipath_kernel.h
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Mar  9 16:15:10 2006 -0800
@@ -0,0 +1,774 @@
+#ifndef _IPATH_KERNEL_H
+#define _IPATH_KERNEL_H
+/*
+ * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+/*
+ * This header file is the base header file for infinipath kernel code
+ * ipath_user.h serves a similar purpose for user code.
+ */
+
+#include "ipath_common.h"
+#include "ipath_debug.h"
+#include "ipath_registers.h"
+#include <linux/interrupt.h>
+#include <asm/io.h>
+
+/* only s/w major version of InfiniPath we can handle */
+#define IPATH_CHIP_VERS_MAJ 2U
+
+#define IPATH_CHIP_VERS_MIN 0U	/* don't care about this except printing */
+
+extern struct infinipath_stats ipath_stats;	/* temporary, maybe always */
+
+#define IPATH_CHIP_SWVERSION IPATH_CHIP_VERS_MAJ
+
+struct ipath_portdata {
+	void **port_rcvegrbuf;
+	dma_addr_t *port_rcvegrbuf_phys;
+	void *port_rcvhdrq;	/* rcvhdrq base, needs mmap before useful */
+	/* kernel virtual address where hdrqtail is updated */
+	u64 *port_rcvhdrtail_kvaddr;
+	struct page *port_rcvhdrtail_pagep;	/* page * used for uaddr */
+	/*
+	 * temp buffer for expected send setup, allocated at open, instead
+	 * of each setup call
+	 */
+	void *port_tid_pg_list;
+	wait_queue_head_t port_wait;	/* when waiting for rcv or pioavail */
+	/*
+	 * rcvegr bufs base, physical, must fit
+	 * in 44 bits so 32 bit programs mmap64 44 bit works)
+	 */
+	dma_addr_t port_rcvegr_phys;
+	dma_addr_t port_rcvhdrq_phys;	/* mmap of hdrq, must fit in 44 bits */
+	/*
+	 * the actual user address that we ipath_mlock'ed, so we can
+	 * ipath_munlock it at close
+	 */
+	unsigned long port_rcvhdrtail_uaddr;
+	/*
+	 * number of opens on this instance (0 or 1; ignoring forks, dup,
+	 * etc. for now)
+	 */
+	int port_cnt;
+	/*
+	 * how much space to leave at start of eager TID entries for protocol
+	 * use, on each TID
+	 */
+	unsigned port_port;	/* instead of calculating it */
+	u32 port_piobufs;	/* chip offset of PIO buffers for this port */
+	/* how many alloc_pages() chunks in port_rcvegrbuf_pages */
+	u32 port_rcvegrbuf_chunks;
+	u32 port_rcvegrbufs_perchunk;	/* how many egrbufs per chunk */
+	size_t port_rcvegrbuf_size;	/* order for port_rcvegrbuf_pages */
+	size_t port_rcvhdrq_size;	/* rcvhdrq size (for freeing) */
+	/* next expected TID to check when looking for free */
+	u32 port_tidcursor;
+	unsigned long port_flag;	/* next expected TID to check */
+	u32 port_rcvwait_to;	/* WAIT_RCV that timed out, no interrupt */
+	u32 port_piowait_to;	/* WAIT_PIO that timed out, no interrupt */
+	u32 port_rcvnowait;	/* WAIT_RCV already happened, no wait */
+	u32 port_pionowait;	/* WAIT_PIO already happened, no wait */
+	u32 port_hdrqfull;	/* total number of rcvhdrqfull errors */
+	pid_t port_pid;		/* pid of process using this port */
+	char port_comm[16];	/* same size as task_struct .comm[] */
+	u16 port_pkeys[4];	/* pkeys set by this use of this port */
+	struct ipath_devdata *port_dd;	/* so file ops can get at unit */
+};
+
+struct sk_buff;
+
+/*
+ * control information for layered drivers
+ */
+struct _ipath_layer {
+	int (*l_intr)(int, u32);
+	int (*l_rcv)(int, void *, struct sk_buff *);
+	int (*l_rcv_lid)(int, void *);
+	u16 l_rcv_opcode;
+	u16 l_rcv_lid_opcode;
+};
+
+/* Verbs layer interface */
+struct _verbs_layer {
+	int (*l_piobufavail)(int);
+	void (*l_rcv)(int, void *, void *, u32);
+	void (*l_timer_cb)(int);
+	struct timer_list l_timer;
+	unsigned l_flags;
+};
+
+typedef u64 __bitwise ipath_err_t;
+
+struct ipath_devdata {
+	struct ipath_kregs const *ipath_kregs;
+	struct ipath_cregs const *ipath_cregs;
+
+	/* mem-mapped pointer to base of chip regs */
+	u64 __iomem *ipath_kregbase;
+	/* end of mem-mapped chip space; range checking */
+	u64 __iomem *ipath_kregend;
+	/* physical address of chip for io_remap, etc. */
+	unsigned long ipath_physaddr;
+	/* base of memory alloced for ipath_kregbase, for free */
+	u64 *ipath_kregalloc;
+	/*
+	 * version of kregbase that doesn't have high bits set (for 32 bit
+	 * programs, so mmap64 44 bit works)
+	 */
+	u64 __iomem *ipath_kregvirt;
+	/*
+	 * virtual address where port0 rcvhdrqtail updated for this unit.
+	 * only written to by the chip, not the driver.
+	 */
+	volatile __le64 *ipath_hdrqtailptr;
+	dma_addr_t ipath_dma_addr;
+	struct ipath_portdata **ipath_pd;	/* ipath_cfgports pointers */
+	/* sk_buffs used by port 0 eager receive queue */
+	struct sk_buff **ipath_port0_skbs;
+	void __iomem *ipath_pio2kbase;	/* kvirt address of 1st 2k pio buffer */
+	void __iomem *ipath_pio4kbase;	/* kvirt address of 1st 4k pio buffer */
+	/*
+	 * points to area where PIOavail registers will be DMA'ed.  Has to
+	 * be on a page of it's own, because the page will be mapped into user
+	 * program space.  This copy is *ONLY* ever written by DMA, not by
+	 * the driver!  Need a copy per device when we get to multiple devices
+	 */
+	volatile __le64 *ipath_pioavailregs_dma;
+	size_t ipath_pioavailregs_size;
+	/* original address for free */
+	void *__ipath_pioavailregs_base;
+	/* physical address where updates occur */
+	dma_addr_t ipath_pioavailregs_phys;
+	struct _ipath_layer ipath_layer;
+	int (*ipath_f_intrsetup) (struct ipath_devdata *);	/* setup intr */
+	/* setup on-chip bus config */
+	int (*ipath_f_bus) (struct ipath_devdata *, struct pci_dev *);
+	int (*ipath_f_reset) (struct ipath_devdata *); /* hard reset chip */
+	int (*ipath_f_get_boardname) (struct ipath_devdata *, char *, size_t);
+	void (*ipath_f_init_hwerrors) (struct ipath_devdata *);
+	void (*ipath_f_handle_hwerrors) (struct ipath_devdata *, char *, size_t);
+	void (*ipath_f_quiet_serdes) (struct ipath_devdata *);
+	int (*ipath_f_bringup_serdes) (struct ipath_devdata *);
+	int (*ipath_f_early_init) (struct ipath_devdata *);
+	void (*ipath_f_clear_tids) (struct ipath_devdata *, unsigned);
+	void (*ipath_f_put_tid) (struct ipath_devdata *, u64 __iomem*,
+				 u32, unsigned long);
+	void (*ipath_f_tidtemplate) (struct ipath_devdata *);
+	void (*ipath_f_cleanup) (struct ipath_devdata *);
+	void (*ipath_f_setextled) (struct ipath_devdata *, u64, u64);
+	/* fill out chip-specific fields */
+	int (*ipath_f_get_base_info)(struct ipath_portdata *, void *);
+	struct _verbs_layer verbs_layer;
+	u64 ipath_sword;	/* total dwords sent (summed from counter) */
+	u64 ipath_rword;	/* total dwords rcvd (summed from counter) */
+	u64 ipath_spkts;	/* total packets sent (summed from counter) */
+	u64 ipath_rpkts;	/* total packets rcvd (summed from counter) */
+	u64 _ipath_status;	/* ipath_statusp initially points to this. */
+	u64 ipath_guid;	/* GUID for this interface, in network order */
+	/*
+	 * aggregrate of error bits reported since
+	 * last cleared, for limiting of error reporting
+	 */
+	ipath_err_t ipath_lasterror;
+	/*
+	 * aggregrate of error bits reported
+	 * since last cleared, for limiting of hwerror reporting
+	 */
+	ipath_err_t ipath_lasthwerror;
+	/*
+	 * errors masked because they occur too fast,
+	 * also includes errors that are always ignored (ipath_ignorederrs)
+	 */
+	ipath_err_t ipath_maskederrs;
+	cycles_t ipath_unmasktime;	/* time at which to re-enable maskederrs */
+	/*
+	 * errors always ignored (masked), at least
+	 * for a given chip/device, because they are wrong or not useful
+	 */
+	ipath_err_t ipath_ignorederrs;
+	/* count of egrfull errors, combined for all ports */
+	u64 ipath_last_tidfull;
+	u64 ipath_lastport0rcv_cnt;	/* for ipath_qcheck() */
+	u64 ipath_tidtemplate; /* template for writing TIDs  */
+	u64 ipath_tidinvalid;	/* value to write to free TIDs */
+	u64 ipath_rhdrhead_intr_off; /* PE-800 rcv interrupt setup */
+
+	u32 ipath_kregsize;	/* size of memory at ipath_kregbase */
+	u32 ipath_pioavregs;	/* number of registers used for pioavail */
+	u32 ipath_flags;	/* IPATH_POLL, etc. */
+	u32 ipath_sma_state_wanted;	/* ipath_flags sma is waiting for */
+	/* last buffer for user use, first buf for kernel use is this index. */
+	u32 ipath_lastport_piobuf;
+	u32 ipath_stats_timer_active;	/* is a stats timer active */
+	u32 ipath_lastsword;	/* dwords sent read from counter */
+	u32 ipath_lastrword;	/* dwords received read from counter */
+	u32 ipath_lastspkts;	/* sent packets read from counter */
+	u32 ipath_lastrpkts;	/* received packets read from counter */
+	u32 ipath_pbufsport;	/* pio bufs allocated per port */
+	/*
+	 * number of ports configured as max; zero is
+	 * set to number chip supports, less gives more pio bufs/port, etc.
+	 */
+	u32 ipath_cfgports;
+	u32 ipath_port0head;	/* port0 rcvhdrq head offset */
+	u32 ipath_p0_hdrqfull;	/* count of port 0 hdrqfull errors */
+
+	/*
+	 * (*cfgports) used to suppress multiple instances of same port
+	 * staying stuck at same point
+	 */
+	u32 *ipath_lastrcvhdrqtails;
+	/*
+	 * (*cfgports) used to suppress multiple instances of same port
+	 * staying stuck at same point
+	 */
+	u32 *ipath_lastegrheads;
+	/*
+	 * index of last piobuffer we used.  Speeds up searching, by starting
+	 * at this point.  Doesn't matter if multiple cpu's use and update,
+	 * last updater is only write that matters.  Whenever it wraps,
+	 * we update shadow copies.  Need a copy per device when we get to
+	 * multiple devices
+	 */
+	u32 ipath_lastpioindex;
+	u32 ipath_freezelen;	/* max length of freezemsg */
+	u32 ipath_consec_nopiobuf;	/* consecutive times we wanted a PIO buffer
+					 * but were unable to get one */
+	u32 ipath_upd_pio_shadow;	/* hint that we should update
+					 * ipath_pioavailshadow before looking for a PIO buffer */
+	u32 ipath_pcibar0;	/* so we can rewrite it after a chip reset */
+	u32 ipath_pcibar1;	/* so we can rewrite it after a chip reset */
+	u32 ipath_nosma_bufs;	/* sequential tries for SMA send and no bufs */
+	u32 ipath_nosma_secs;	/* duration (seconds) ipath_nosma_bufs set */
+
+	u16 ipath_vendorid;	/* HT/PCI Vendor ID (here for NodeInfo) */
+	u16 ipath_deviceid;	/* HT/PCI Device ID (here for NodeInfo) */
+	/* offset in HT config space of slave/primary interface block */
+	u8 ipath_ht_slave_off;
+	unsigned long ipath_wc_cookie;	/* for write combining settings */
+	atomic_t ipath_pkeyrefs[4];	/* ref count for each pkey */
+	/* shadow copy of all exptids physaddr; used only by funcsim */
+	u64 *ipath_tidsimshadow;
+	/* shadow copy of struct page *'s for exp tid pages */
+	struct page **ipath_pageshadow;
+	spinlock_t ipath_tid_lock; /* lock to workaround chip bug 9437 */
+
+	/*
+	 * IPATH_STATUS_*,
+	 * this address is mapped readonly into user processes so they can
+	 * get status cheaply, whenever they want.
+	 */
+	u64 *ipath_statusp;
+	char *ipath_freezemsg;	/* freeze msg if hw error put chip in freeze */
+	struct pci_dev *pcidev;	/* pci access data structure */
+	struct cdev *cdev;
+	struct class_device *class_dev;
+	/* timer used to prevent stats overflow, error throttling, etc. */
+	struct timer_list ipath_stats_timer;
+	/* check for stale messages in rcv queue */
+	unsigned long ipath_rcv_pending;	/* only allow one intr at a time. */
+
+	/*
+	 * shadow copies of registers; size indicates read access size
+	 * Most of them are readonly, but some are write-only register, where
+	 * we manipulate the bits in the shadow copy, and then write the shadow
+	 * copy to infinipath
+	 * We deliberately make most of these 32 bits, since they have
+	 * restricted range and for any that we read, we won't to generate
+	 * 32 bit accesses, since Opteron will generate 2 separate 32 bit
+	 * HT transactions for a 64 bit read, and we want to avoid unnecessary
+	 * HT transactions
+	 */
+
+	/* This is the 64 bit group */
+	/* shadow of pioavail, check to be sure it's large enough at init time. */
+	unsigned long ipath_pioavailshadow[8];
+	u64 ipath_gpio_out;	/* shadow of kr_gpio_out, for rmw ops */
+	u64 ipath_revision;	/* kr_revision shadow */
+	/* shadow of ibcctrl, for interrupt handling of link changes, etc. */
+	u64 ipath_ibcctrl;
+	/*
+	 * last ibcstatus, to suppress "duplicate" status change messages,
+	 * mostly from 2 to 3
+	 */
+	u64 ipath_lastibcstat;
+	ipath_err_t ipath_hwerrmask;	/* hwerrmask shadow */
+	u64 ipath_intconfig;	/* interrupt config reg shadow */
+	u64 ipath_piobufbase;	/* kr_sendpiobufbase value */
+
+	/* these are the "32 bit" regs */
+	/*
+	 * number of GUIDs in the flash for this interface; may need some
+	 * rethinking for setting on other ifaces
+	 */
+	u32 ipath_nguid;
+	/*
+	 * the following two are 32-bit bitmasks, but
+	 * {test,clear,set}_bit all expect bit fields to be "unsigned
+	 * long"
+	 */
+	unsigned long ipath_rcvctrl;	/* shadow kr_rcvctrl */
+	unsigned long ipath_sendctrl;	/* shadow kr_sendctrl */
+
+	u32 ipath_rcvhdrcnt;	/* value we put in kr_rcvhdrcnt */
+	u32 ipath_rcvhdrsize;	/* value we put in kr_rcvhdrsize */
+	u32 ipath_rcvhdrentsize;	/* value we put in kr_rcvhdrentsize */
+	u32 ipath_hdrqlast;	/* offset of last entry in rcvhdrq */
+	u32 ipath_portcnt;	/* kr_portcnt value */
+	u32 ipath_palign;	/* kr_pagealign value */
+	u32 ipath_piobcnt2k;	/* number of "2KB" PIO buffers */
+	u32 ipath_piosize2k;	/* size in bytes of "2KB" PIO buffers */
+	u32 ipath_piobcnt4k;	/* number of "4KB" PIO buffers */
+	u32 ipath_piosize4k;	/* size in bytes of "4KB" PIO buffers */
+	u32 ipath_rcvegrbase;	/* kr_rcvegrbase value */
+	u32 ipath_rcvegrcnt;	/* kr_rcvegrcnt value */
+	u32 ipath_rcvtidbase;	/* kr_rcvtidbase value */
+	u32 ipath_rcvtidcnt;	/* kr_rcvtidcnt value */
+	u32 ipath_sregbase;	/* kr_sendregbase */
+	u32 ipath_uregbase;	/* kr_userregbase */
+	u32 ipath_cregbase;	/* kr_counterregbase */
+	u32 ipath_control;	/* shadow the control register contents */
+	u32 ipath_extctrl;	/* shadow the gpio output contents */
+	u32 ipath_pcirev;	/* PCI revision register (HTC rev on FPGA) */
+
+	u32 ipath_4kalign;	/* chip address space used by 4k pio buffers */
+	u32 ipath_ibmtu;	/* The MTU programmed for this unit */
+	/*
+	 * The max size IB packet, included IB headers that we can send.
+	 * Starts same as ipath_piosize, but is affected when ibmtu is
+	 * changed, or by size of eager buffers
+	 */
+	u32 ipath_ibmaxlen;
+	/*
+	 * ibmaxlen at init time, limited by chip and by receive buffer size.
+	 * Not changed after init.
+	 */
+	u32 ipath_init_ibmaxlen;
+	u32 ipath_rcvegrbufsize;	/* size of each rcvegrbuffer */
+	u32 ipath_htwidth;	/* width (2,4,8,16,32) from HT config reg */
+	u32 ipath_htspeed;	/* HT speed (200,400,800,1000) from HT config */
+	unsigned long ipath_portpiowait;	/* ports waiting for PIOavail intr */
+	/*
+	 *number of sequential ibcstatus change for polling active/quiet
+	 * (i.e., link not coming up).
+	 */
+	u32 ipath_ibpollcnt;
+	u32 ipath_msi_lo;	/* low and high portions of MSI capability/vector */
+	u32 ipath_msi_hi;	/* saved after PCIe init for restore after reset */
+	u16 ipath_msi_data;	/* MSI data (vector) saved for restore */
+	u16 ipath_mlid;	/* MLID programmed for this instance */
+	u16 ipath_lid;	/* LID programmed for this instance */
+	u16 ipath_pkeys[4];	/* list of pkeys programmed; 0 if not set */
+	u8 ipath_serial[12];	/* ASCII serial number, from flash */
+	u8 ipath_boardversion[80];	/* human readable board version */
+	u8 ipath_majrev;	/* chip major rev, from ipath_revision */
+	u8 ipath_minrev;	/* chip minor rev, from ipath_revision */
+	u8 ipath_boardrev;	/* board rev, from ipath_revision */
+	int ipath_unit;		/* unit # of this chip, if present */
+	u8 ipath_pci_cacheline;	/* saved for restore after reset */
+	u8 ipath_lmc;		/* LID mask control */
+};
+
+extern u64 *ipath_port0_rcvhdrtail;
+extern dma_addr_t ipath_port0_rcvhdrtail_dma;
+
+#define IPATH_PORT0_RCVHDRTAIL_SIZE PAGE_SIZE
+
+extern atomic_t ipath_max;
+extern struct ipath_devdata *ipath_lookup(int unit);
+
+struct page *ipath_nopage(struct vm_area_struct *, unsigned long, int *);
+int ipath_init_chip(struct ipath_devdata *, int);
+int ipath_enable_wc(struct ipath_devdata *dd);
+void ipath_disable_wc(struct ipath_devdata *dd);
+int ipath_count_units(int *npresentp, int *nupp, u32 *maxportsp);
+
+struct file_operations;
+int ipath_cdev_init(int minor, char *name, struct file_operations *fops,
+		    struct cdev **cdevp, struct class_device **class_devp);
+void ipath_cdev_cleanup(struct cdev **cdevp, struct class_device **class_devp);
+
+int ipath_diag_init(void);
+void ipath_diag_cleanup(void);
+void ipath_diag_bringup_link(struct ipath_devdata *);
+
+int ipath_sma_init(void);
+void ipath_sma_cleanup(void);
+
+int ipath_user_add(struct ipath_devdata *dd);
+void ipath_user_del(struct ipath_devdata *dd);
+
+struct sk_buff *ipath_alloc_skb(struct ipath_devdata *dd, gfp_t);
+
+extern __kernel_pid_t ipath_diag_alive;	/* contains pid if diags mode enabled? */
+
+irqreturn_t ipath_intr(int irq, void *devid, struct pt_regs *regs);
+void ipath_decode_err(char *buf, size_t blen, ipath_err_t err);
+#if __IPATH_INFO || __IPATH_DBG
+extern const char *ipath_ibcstatus_str[];
+#endif
+
+/* clean up any per-chip chip-specific stuff */
+void ipath_chip_cleanup(struct ipath_devdata *);
+void ipath_chip_done(void);	/* clean up any chip type-specific stuff */
+
+/* check to see if we have to force ordering for write combining */
+int ipath_unordered_wc(void);
+
+void ipath_disarm_piobufs(struct ipath_devdata *, unsigned first,
+			  unsigned cnt);
+
+#define IPATH_SMA_HDRSZ (8+12+8)	/* LRH+BTH+DETH */
+#define IPATH_SMA_MAX_PKTSZ (IPATH_SMA_HDRSZ+256)
+#define IPATH_NUM_SMA_PKTS  16
+
+int ipath_create_rcvhdrq(struct ipath_devdata *, struct ipath_portdata *);
+void ipath_free_pddata(struct ipath_devdata *, u32, int);
+
+int ipath_parse_ushort(const char *str, unsigned short *valp);
+
+extern unsigned ipath_sma_first;
+extern unsigned ipath_sma_next;
+extern atomic_t ipath_sma_alive;
+extern spinlock_t ipath_sma_lock;
+extern u8 ipath_sma_data_bufs[IPATH_NUM_SMA_PKTS + 1][IPATH_SMA_MAX_PKTSZ];
+extern u8 *ipath_sma_data_spare;
+extern wait_queue_head_t ipath_sma_wait;
+extern wait_queue_head_t ipath_sma_state_wait;
+
+extern struct _ipath_sma_rpkt {
+	/* length of received packet; non-zero if queued */
+	u32 len;
+	/* unit number of interface packet was received from */
+	u32 unit;
+	u8 *buf;
+} ipath_sma_data[IPATH_NUM_SMA_PKTS];
+
+int ipath_wait_linkstate(struct ipath_devdata *, u32, int);
+void ipath_set_ib_lstate(struct ipath_devdata *, int);
+void ipath_kreceive(struct ipath_devdata *);
+int ipath_setrcvhdrsize(struct ipath_devdata *, unsigned);
+int ipath_reset_device(int);
+void ipath_get_faststats(unsigned long);
+
+/* for use in system calls, where we want to know device type, etc. */
+#define port_fp(fp) ((struct ipath_portdata *) (fp)->private_data)
+
+/*
+ * values for ipath_flags
+ */
+#define IPATH_INITTED       0x2	/* The chip is up and initted */
+#define IPATH_RCVHDRSZ_SET  0x4	/* set if any user code has set kr_rcvhdrsize */
+/* The chip is present and valid for accesses */
+#define IPATH_PRESENT       0x8
+/* HT link0 is only 8 bits wide, ignore upper byte crc errors, etc. */
+#define IPATH_8BIT_IN_HT0   0x10
+/* HT link1 is only 8 bits wide, ignore upper byte crc errors, etc. */
+#define IPATH_8BIT_IN_HT1   0x20
+#define IPATH_LINKDOWN      0x40	/* The link is down */
+#define IPATH_LINKINIT      0x80	/* The link level is up (0x11) */
+#define IPATH_LINKARMED     0x100	/* The link is in the armed (0x21) state */
+#define IPATH_LINKACTIVE    0x200	/* The link is in the active (0x31) state */
+#define IPATH_LINKUNK       0x400	/* link current state is unknown */
+#define IPATH_NOCABLE       0x4000	/* no IB cable, or no device on IB cable */
+/* Supports port zero per packet receive interrupts via GPIO */
+#define IPATH_GPIO_INTR     0x8000  /* GPIO port0 rx interrupts avail */
+#define IPATH_4BYTE_TID     0x10000	/* uses the coded 4byte TID, not 8 byte */
+#define IPATH_32BITCOUNTERS 0x20000	/* packet/word counters are 32 bit, else
+					 * those 4 counters are 64bit */
+#define IPATH_POLL_RX_INTR  0x40000 /* can miss port0 rx interrupts */
+
+/* portdata flag bit offsets */
+#define IPATH_PORT_WAITING_RCV   2	/* waiting for a packet to arrive */
+/* waiting for a PIO buffer to be available */
+#define IPATH_PORT_WAITING_PIO   3
+
+/* free up any allocated data at closes */
+void ipath_free_data(struct ipath_portdata *dd);
+int ipath_waitfor_mdio_cmdready(struct ipath_devdata *);
+int ipath_waitfor_complete(struct ipath_devdata *, ipath_kreg, u64, u64 *);
+u32 __iomem *ipath_getpiobuf(struct ipath_devdata *, u32 *);
+void ipath_init_pe800_funcs(struct ipath_devdata *);	/* init PE-800-specific func */
+void ipath_init_ht400_funcs(struct ipath_devdata *);	/* init HT-400-specific func */
+void ipath_get_guid(struct ipath_devdata *);
+u64 ipath_snap_cntr(struct ipath_devdata *, ipath_creg);
+
+/*
+ * number of words used for protocol header if not set by ipath_userinit();
+ */
+#define IPATH_DFLT_RCVHDRSIZE 9
+
+#define IPATH_MDIO_CMD_WRITE   1
+#define IPATH_MDIO_CMD_READ    2
+#define IPATH_MDIO_CLD_DIV     25	/* to get 2.5 Mhz mdio clock */
+#define IPATH_MDIO_CMDVALID    0x40000000	/* bit 30 */
+#define IPATH_MDIO_DATAVALID   0x80000000	/* bit 31 */
+#define IPATH_MDIO_CTRL_STD    0x0
+
+static inline u64 ipath_mdio_req(int cmd, int dev, int reg, int data)
+{
+	return (((u64) IPATH_MDIO_CLD_DIV) << 32) |
+		(cmd << 26) |
+		(dev << 21) |
+		(reg << 16) |
+		(data & 0xFFFF);
+}
+
+#define IPATH_MDIO_CTRL_XGXS_REG_8  0x8	/* signal and fifo status, in bank 31 */
+
+#define IPATH_MDIO_CTRL_8355_REG_1  0x10	/* controls loopback, redundancy */
+#define IPATH_MDIO_CTRL_8355_REG_2  0x11	/* premph, encdec, etc. */
+#define IPATH_MDIO_CTRL_8355_REG_6  0x15	/* Kchars, etc. */
+#define IPATH_MDIO_CTRL_8355_REG_9  0x18
+#define IPATH_MDIO_CTRL_8355_REG_10 0x1D
+
+int ipath_get_user_pages(unsigned long, size_t, struct page **);
+int ipath_get_user_pages_nocopy(unsigned long, struct page **);
+void ipath_release_user_pages(struct page **, size_t);
+void ipath_release_user_pages_on_close(struct page **, size_t);
+int ipath_eeprom_read(struct ipath_devdata *, u8, void *, int);
+int ipath_eeprom_write(struct ipath_devdata *, u8, const void *, int);
+
+/* these are used for the registers that vary with port */
+void ipath_write_kreg_port(const struct ipath_devdata *, ipath_kreg,
+			   unsigned, u64);
+u64 ipath_read_kreg64_port(const struct ipath_devdata *, ipath_kreg, unsigned);
+
+/*
+ * we could have a single register get/put routine, that takes a group
+ * type, but this is somewhat clearer and cleaner.  It also gives us some
+ * error checking.  64 bit register reads should always work, but are
+ * inefficient on opteron (the northbridge always generates 2 separate
+ * HT 32 bit reads), so we use kreg32 wherever possible.
+ * User register and counter register reads are always 32 bit reads, so only
+ * one form of those routines.
+ */
+
+/*
+ * At the moment, none of the s-registers are writable, so no ipath_write_sreg()
+ * At the moment, none of the c-registers are writable, so no ipath_write_creg()
+ */
+
+/*
+ * return the contents of a register that is virtualized to be per port
+ * prints a debug message and returns -1 on errors (not distinguishable from
+ * valid contents at runtime; we may add a separate error variable at some
+ * point).
+ * This is normally not used by the kernel, but may be for debugging,
+ * and has a different implementation than user mode, which is why
+ * it's not in _common.h
+ */
+static inline u32 ipath_read_ureg32(const struct ipath_devdata *dd,
+				    ipath_ureg regno, int port)
+{
+	if (!dd->ipath_kregbase)
+		return 0;
+
+	return readl(regno + (u64 __iomem *)
+		     (dd->ipath_uregbase +
+		      (char __iomem *)dd->ipath_kregbase +
+		      dd->ipath_palign * port));
+}
+
+/*
+ * change the contents of a register that is virtualized to be per port
+ * prints a debug message and returns 1 on errors, 0 on success.
+ */
+static inline void ipath_write_ureg(const struct ipath_devdata *dd,
+				    ipath_ureg regno, u64 value, int port)
+{
+	u64 __iomem *ubase;
+
+	ubase = (u64 __iomem *)
+	    (dd->ipath_uregbase +
+	     (char __iomem *)dd->ipath_kregbase +
+	     dd->ipath_palign * port);
+	if (dd->ipath_kregbase)
+		writeq(value, &ubase[regno]);
+}
+
+static inline u32 ipath_read_kreg32(const struct ipath_devdata *dd,
+				    ipath_kreg regno)
+{
+	if (!dd->ipath_kregbase)
+		return -1;
+	return readl((u32 __iomem *) & dd->ipath_kregbase[regno]);
+}
+
+static inline u64 ipath_read_kreg64(const struct ipath_devdata *dd,
+				    ipath_kreg regno)
+{
+	if (!dd->ipath_kregbase)
+		return -1;
+
+	return readq(&dd->ipath_kregbase[regno]);
+}
+
+static inline void ipath_write_kreg(const struct ipath_devdata *dd,
+				    ipath_kreg regno, u64 value)
+{
+	if (dd->ipath_kregbase)
+		writeq(value, &dd->ipath_kregbase[regno]);
+}
+
+static inline u64 ipath_read_creg(const struct ipath_devdata *dd, ipath_sreg regno)
+{
+	if (!dd->ipath_kregbase)
+		return 0;
+
+	return readq(regno + (u64 __iomem *)
+		     (dd->ipath_cregbase +
+		      (char __iomem *)dd->ipath_kregbase));
+}
+
+static inline uint32_t ipath_read_creg32(const struct ipath_devdata *dd,
+					 ipath_sreg regno)
+{
+	if (!dd->ipath_kregbase)
+		return 0;
+	return readl(regno + (u64 __iomem *)
+		     (dd->ipath_cregbase +
+		      (char __iomem *)dd->ipath_kregbase));
+}
+
+/*
+ * caddr is the destination chip address (full pointer, not offset),
+ * val is the qword to write there.  We only handle a single qword (8 bytes).
+ * This is not used for copies to the PIO buffer, just TID updates, etc.
+ * This function localizes all chip mem (as opposed to register) qword writes.
+ */
+static inline void ipath_write_memq(const struct ipath_devdata *dd,
+				   u64 __iomem * caddr, u64 val)
+{
+	if (dd->ipath_kregbase)
+		writeq(val, caddr);
+}
+
+/*
+ * caddr is the destination chip address (full pointer, not offset),
+ * val is the dword to write there.  We only handle a single dword (4 bytes).
+ * This is not used for copies to the PIO buffer, just TID updates, etc.
+ * This function localizes all chip mem (as opposed to register) dword writes.
+ */
+static inline void ipath_write_meml(const struct ipath_devdata *dd,
+				   u32 __iomem * caddr, u32 val)
+{
+	if (dd->ipath_kregbase)
+		writel(val, caddr);
+}
+
+static inline u64 ipath_read_memq(const struct ipath_devdata *dd,
+				   u64 __iomem * caddr)
+{
+	if (dd->ipath_kregbase)
+		return readq(caddr);
+	return ~0ULL;
+}
+
+static inline u32 ipath_read_meml(const struct ipath_devdata *dd,
+				   u32 __iomem * caddr)
+{
+	if (dd->ipath_kregbase)
+		return readl(caddr);
+	return ~0U;
+}
+
+/*
+ * sysfs interface.
+ */
+
+struct device_driver;
+
+extern const char ipath_core_version[];
+
+int ipath_driver_create_group(struct device_driver *);
+void ipath_driver_remove_group(struct device_driver *);
+
+int ipath_device_create_group(struct device *, struct ipath_devdata *);
+void ipath_device_remove_group(struct device *, struct ipath_devdata *);
+int ipath_expose_reset(struct device *);
+
+/*
+ * Flush write combining store buffers (if present) and perform a write
+ * barrier.
+ */
+#if defined(CONFIG_X86_64)
+#define ipath_flush_wc() asm volatile("sfence" ::: "memory")
+#else
+#define ipath_flush_wc() wmb()
+#endif
+
+extern unsigned ipath_debug; /* debugging bit mask */
+
+const char *ipath_get_unit_name(int unit);
+
+extern struct mutex ipath_mutex;
+
+#define IPATH_DRV_NAME		"ipath_core"
+#define IPATH_MAJOR		233
+#define IPATH_SMA_MINOR		128
+#define IPATH_DIAG_MINOR	129
+#define IPATH_NMINORS		130
+
+#define ipath_dev_err(dd,fmt,...) \
+	do { \
+		const struct ipath_devdata *__dd = (dd); \
+		if (__dd->pcidev) \
+			dev_err(&__dd->pcidev->dev, "%s: " fmt, \
+				ipath_get_unit_name(__dd->ipath_unit), ##__VA_ARGS__); \
+		else \
+			printk(KERN_ERR IPATH_DRV_NAME ": %s: " fmt, \
+			       ipath_get_unit_name(__dd->ipath_unit), ##__VA_ARGS__); \
+	} while (0)
+
+#if _IPATH_DEBUGGING
+
+#define __IPATH_DBG_WHICH(which,fmt,...) \
+	do { \
+		if(unlikely(ipath_debug&(which))) \
+			printk(KERN_DEBUG IPATH_DRV_NAME ": %s: " fmt, \
+			       __func__,##__VA_ARGS__);		       \
+	} while(0)
+
+#define  ipath_dbg(fmt,...) __IPATH_DBG_WHICH(__IPATH_DBG,fmt,##__VA_ARGS__)
+#define  ipath_cdbg(which,fmt,...) __IPATH_DBG_WHICH(__IPATH_##which##DBG,fmt,##__VA_ARGS__)
+
+#else				/* ! _IPATH_DEBUGGING */
+
+#define ipath_dbg(fmt,...)
+#define ipath_cdbg(which,fmt,...)
+
+#endif				/* _IPATH_DEBUGGING */
+
+#endif				/* _IPATH_KERNEL_H */
diff -r d4136de1a941 -r 2a9e52d59741 drivers/infiniband/hw/ipath/ipath_registers.h
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_registers.h	Thu Mar  9 16:15:10 2006 -0800
@@ -0,0 +1,443 @@
+/*
+ * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#ifndef _IPATH_REGISTERS_H
+#define _IPATH_REGISTERS_H
+
+/*
+ * This file should only be included by kernel source, and by the diags.
+ * It defines the registers, and their contents, for the InfiniPath HT-400 chip
+ */
+
+/*
+ * These are the InfiniPath register and buffer bit definitions,
+ * that are visible to software, and needed only by the kernel
+ * and diag code.  A few, that are visible to protocol and user
+ * code are in ipath_common.h.  Some bits are specific
+ * to a given chip implementation, and have been moved to the
+ * chip-specific source file
+ */
+
+/* kr_revision bits */
+#define INFINIPATH_R_CHIPREVMINOR_MASK 0xFF
+#define INFINIPATH_R_CHIPREVMINOR_SHIFT 0
+#define INFINIPATH_R_CHIPREVMAJOR_MASK 0xFF
+#define INFINIPATH_R_CHIPREVMAJOR_SHIFT 8
+#define INFINIPATH_R_ARCH_MASK 0xFF
+#define INFINIPATH_R_ARCH_SHIFT 16
+#define INFINIPATH_R_SOFTWARE_MASK 0xFF
+#define INFINIPATH_R_SOFTWARE_SHIFT 24
+#define INFINIPATH_R_BOARDID_MASK 0xFF
+#define INFINIPATH_R_BOARDID_SHIFT 32
+
+/* kr_control bits */
+#define INFINIPATH_C_FREEZEMODE 0x00000002
+#define INFINIPATH_C_LINKENABLE 0x00000004
+#define INFINIPATH_C_RESET 0x00000001
+
+/* kr_sendctrl bits */
+#define INFINIPATH_S_DISARMPIOBUF_SHIFT 16
+
+#define IPATH_S_ABORT		0
+#define IPATH_S_PIOINTBUFAVAIL	1
+#define IPATH_S_PIOBUFAVAILUPD	2
+#define IPATH_S_PIOENABLE	3
+#define IPATH_S_DISARM		31
+
+#define INFINIPATH_S_ABORT		(1U << IPATH_S_ABORT)
+#define INFINIPATH_S_PIOINTBUFAVAIL	(1U << IPATH_S_PIOINTBUFAVAIL)
+#define INFINIPATH_S_PIOBUFAVAILUPD	(1U << IPATH_S_PIOBUFAVAILUPD)
+#define INFINIPATH_S_PIOENABLE		(1U << IPATH_S_PIOENABLE)
+#define INFINIPATH_S_DISARM		(1U << IPATH_S_DISARM)
+
+/* kr_rcvctrl bits */
+#define INFINIPATH_R_PORTENABLE_SHIFT 0
+#define INFINIPATH_R_INTRAVAIL_SHIFT 16
+#define INFINIPATH_R_TAILUPD   0x80000000
+
+/* kr_intstatus, kr_intclear, kr_intmask bits */
+#define INFINIPATH_I_RCVURG_SHIFT 0
+#define INFINIPATH_I_RCVAVAIL_SHIFT 12
+#define INFINIPATH_I_ERROR        0x80000000
+#define INFINIPATH_I_SPIOSENT     0x40000000
+#define INFINIPATH_I_SPIOBUFAVAIL 0x20000000
+#define INFINIPATH_I_GPIO         0x10000000
+
+/* kr_errorstatus, kr_errorclear, kr_errormask bits */
+#define INFINIPATH_E_RFORMATERR      0x0000000000000001ULL
+#define INFINIPATH_E_RVCRC           0x0000000000000002ULL
+#define INFINIPATH_E_RICRC           0x0000000000000004ULL
+#define INFINIPATH_E_RMINPKTLEN      0x0000000000000008ULL
+#define INFINIPATH_E_RMAXPKTLEN      0x0000000000000010ULL
+#define INFINIPATH_E_RLONGPKTLEN     0x0000000000000020ULL
+#define INFINIPATH_E_RSHORTPKTLEN    0x0000000000000040ULL
+#define INFINIPATH_E_RUNEXPCHAR      0x0000000000000080ULL
+#define INFINIPATH_E_RUNSUPVL        0x0000000000000100ULL
+#define INFINIPATH_E_REBP            0x0000000000000200ULL
+#define INFINIPATH_E_RIBFLOW         0x0000000000000400ULL
+#define INFINIPATH_E_RBADVERSION     0x0000000000000800ULL
+#define INFINIPATH_E_RRCVEGRFULL     0x0000000000001000ULL
+#define INFINIPATH_E_RRCVHDRFULL     0x0000000000002000ULL
+#define INFINIPATH_E_RBADTID         0x0000000000004000ULL
+#define INFINIPATH_E_RHDRLEN         0x0000000000008000ULL
+#define INFINIPATH_E_RHDR            0x0000000000010000ULL
+#define INFINIPATH_E_RIBLOSTLINK     0x0000000000020000ULL
+#define INFINIPATH_E_SMINPKTLEN      0x0000000020000000ULL
+#define INFINIPATH_E_SMAXPKTLEN      0x0000000040000000ULL
+#define INFINIPATH_E_SUNDERRUN       0x0000000080000000ULL
+#define INFINIPATH_E_SPKTLEN         0x0000000100000000ULL
+#define INFINIPATH_E_SDROPPEDSMPPKT  0x0000000200000000ULL
+#define INFINIPATH_E_SDROPPEDDATAPKT 0x0000000400000000ULL
+#define INFINIPATH_E_SPIOARMLAUNCH   0x0000000800000000ULL
+#define INFINIPATH_E_SUNEXPERRPKTNUM 0x0000001000000000ULL
+#define INFINIPATH_E_SUNSUPVL        0x0000002000000000ULL
+#define INFINIPATH_E_IBSTATUSCHANGED 0x0001000000000000ULL
+#define INFINIPATH_E_INVALIDADDR     0x0002000000000000ULL
+#define INFINIPATH_E_RESET           0x0004000000000000ULL
+#define INFINIPATH_E_HARDWARE        0x0008000000000000ULL
+
+/* kr_hwerrclear, kr_hwerrmask, kr_hwerrstatus, bits */
+/* TXEMEMPARITYERR bit 0: PIObuf, 1: PIOpbc, 2: launchfifo
+ * RXEMEMPARITYERR bit 0: rcvbuf, 1: lookupq, 2: eagerTID, 3: expTID
+ * 		bit 4: flag buffer, 5: datainfo, 6: header info */
+#define INFINIPATH_HWE_TXEMEMPARITYERR_MASK 0xFULL
+#define INFINIPATH_HWE_TXEMEMPARITYERR_SHIFT 40
+#define INFINIPATH_HWE_RXEMEMPARITYERR_MASK 0x7FULL
+#define INFINIPATH_HWE_RXEMEMPARITYERR_SHIFT 44
+#define INFINIPATH_HWE_RXDSYNCMEMPARITYERR  0x0000000400000000ULL
+#define INFINIPATH_HWE_IBCBUSTOSPCPARITYERR 0x4000000000000000ULL
+#define INFINIPATH_HWE_IBCBUSFRSPCPARITYERR 0x8000000000000000ULL
+
+/* kr_hwdiagctrl bits */
+#define INFINIPATH_DC_FORCETXEMEMPARITYERR_MASK 0xFULL
+#define INFINIPATH_DC_FORCETXEMEMPARITYERR_SHIFT 40
+#define INFINIPATH_DC_FORCERXEMEMPARITYERR_MASK 0x7FULL
+#define INFINIPATH_DC_FORCERXEMEMPARITYERR_SHIFT 44
+#define INFINIPATH_DC_FORCERXDSYNCMEMPARITYERR  0x0000000400000000ULL
+#define INFINIPATH_DC_COUNTERDISABLE            0x1000000000000000ULL
+#define INFINIPATH_DC_COUNTERWREN               0x2000000000000000ULL
+#define INFINIPATH_DC_FORCEIBCBUSTOSPCPARITYERR 0x4000000000000000ULL
+#define INFINIPATH_DC_FORCEIBCBUSFRSPCPARITYERR 0x8000000000000000ULL
+
+/* kr_ibcctrl bits */
+#define INFINIPATH_IBCC_FLOWCTRLPERIOD_MASK 0xFFULL
+#define INFINIPATH_IBCC_FLOWCTRLPERIOD_SHIFT 0
+#define INFINIPATH_IBCC_FLOWCTRLWATERMARK_MASK 0xFFULL
+#define INFINIPATH_IBCC_FLOWCTRLWATERMARK_SHIFT 8
+#define INFINIPATH_IBCC_LINKINITCMD_MASK 0x3ULL
+#define INFINIPATH_IBCC_LINKINITCMD_DISABLE 1
+#define INFINIPATH_IBCC_LINKINITCMD_POLL 2	/* cycle through TS1/TS2 till OK */
+#define INFINIPATH_IBCC_LINKINITCMD_SLEEP 3	/* wait for TS1, then go on */
+#define INFINIPATH_IBCC_LINKINITCMD_SHIFT 16
+#define INFINIPATH_IBCC_LINKCMD_MASK 0x3ULL
+#define INFINIPATH_IBCC_LINKCMD_INIT 1	/* move to 0x11 */
+#define INFINIPATH_IBCC_LINKCMD_ARMED 2	/* move to 0x21 */
+#define INFINIPATH_IBCC_LINKCMD_ACTIVE 3	/* move to 0x31 */
+#define INFINIPATH_IBCC_LINKCMD_SHIFT 18
+#define INFINIPATH_IBCC_MAXPKTLEN_MASK 0x7FFULL
+#define INFINIPATH_IBCC_MAXPKTLEN_SHIFT 20
+#define INFINIPATH_IBCC_PHYERRTHRESHOLD_MASK 0xFULL
+#define INFINIPATH_IBCC_PHYERRTHRESHOLD_SHIFT 32
+#define INFINIPATH_IBCC_OVERRUNTHRESHOLD_MASK 0xFULL
+#define INFINIPATH_IBCC_OVERRUNTHRESHOLD_SHIFT 36
+#define INFINIPATH_IBCC_CREDITSCALE_MASK 0x7ULL
+#define INFINIPATH_IBCC_CREDITSCALE_SHIFT 40
+#define INFINIPATH_IBCC_LOOPBACK             0x8000000000000000ULL
+#define INFINIPATH_IBCC_LINKDOWNDEFAULTSTATE 0x4000000000000000ULL
+
+/* kr_ibcstatus bits */
+#define INFINIPATH_IBCS_LINKTRAININGSTATE_MASK 0xF
+#define INFINIPATH_IBCS_LINKTRAININGSTATE_SHIFT 0
+#define INFINIPATH_IBCS_LINKSTATE_MASK 0x7
+#define INFINIPATH_IBCS_LINKSTATE_SHIFT 4
+#define INFINIPATH_IBCS_TXREADY       0x40000000
+#define INFINIPATH_IBCS_TXCREDITOK    0x80000000
+/* link training states (shift by INFINIPATH_IBCS_LINKTRAININGSTATE_SHIFT) */
+#define INFINIPATH_IBCS_LT_STATE_DISABLED	0x00
+#define INFINIPATH_IBCS_LT_STATE_LINKUP		0x01
+#define INFINIPATH_IBCS_LT_STATE_POLLACTIVE	0x02
+#define INFINIPATH_IBCS_LT_STATE_POLLQUIET	0x03
+#define INFINIPATH_IBCS_LT_STATE_SLEEPDELAY	0x04
+#define INFINIPATH_IBCS_LT_STATE_SLEEPQUIET	0x05
+#define INFINIPATH_IBCS_LT_STATE_CFGDEBOUNCE	0x08
+#define INFINIPATH_IBCS_LT_STATE_CFGRCVFCFG	0x09
+#define INFINIPATH_IBCS_LT_STATE_CFGWAITRMT	0x0a
+#define INFINIPATH_IBCS_LT_STATE_CFGIDLE	0x0b
+#define INFINIPATH_IBCS_LT_STATE_RECOVERRETRAIN	0x0c
+#define INFINIPATH_IBCS_LT_STATE_RECOVERWAITRMT	0x0e
+#define INFINIPATH_IBCS_LT_STATE_RECOVERIDLE	0x0f
+/* link state machine states (shift by INFINIPATH_IBCS_LINKSTATE_SHIFT) */
+#define INFINIPATH_IBCS_L_STATE_DOWN		0x0
+#define INFINIPATH_IBCS_L_STATE_INIT		0x1
+#define INFINIPATH_IBCS_L_STATE_ARM		0x2
+#define INFINIPATH_IBCS_L_STATE_ACTIVE		0x3
+#define INFINIPATH_IBCS_L_STATE_ACT_DEFER	0x4
+
+/* combination link status states that we use with some frequency */
+#define IPATH_IBSTATE_MASK ((INFINIPATH_IBCS_LINKTRAININGSTATE_MASK \
+		<< INFINIPATH_IBCS_LINKSTATE_SHIFT) | \
+		(INFINIPATH_IBCS_LINKSTATE_MASK \
+		<<INFINIPATH_IBCS_LINKTRAININGSTATE_SHIFT))
+#define IPATH_IBSTATE_INIT ((INFINIPATH_IBCS_L_STATE_INIT \
+		<< INFINIPATH_IBCS_LINKSTATE_SHIFT) | \
+		(INFINIPATH_IBCS_LT_STATE_LINKUP \
+		<<INFINIPATH_IBCS_LINKTRAININGSTATE_SHIFT))
+#define IPATH_IBSTATE_ARM ((INFINIPATH_IBCS_L_STATE_ARM \
+		<< INFINIPATH_IBCS_LINKSTATE_SHIFT) | \
+		(INFINIPATH_IBCS_LT_STATE_LINKUP \
+		<<INFINIPATH_IBCS_LINKTRAININGSTATE_SHIFT))
+#define IPATH_IBSTATE_ACTIVE ((INFINIPATH_IBCS_L_STATE_ACTIVE \
+		<< INFINIPATH_IBCS_LINKSTATE_SHIFT) | \
+		(INFINIPATH_IBCS_LT_STATE_LINKUP \
+		<<INFINIPATH_IBCS_LINKTRAININGSTATE_SHIFT))
+
+/* kr_extstatus bits */
+#define INFINIPATH_EXTS_SERDESPLLLOCK 0x1
+#define INFINIPATH_EXTS_GPIOIN_MASK 0xFFFFULL
+#define INFINIPATH_EXTS_GPIOIN_SHIFT 48
+
+/* kr_extctrl bits */
+#define INFINIPATH_EXTC_GPIOINVERT_MASK 0xFFFFULL
+#define INFINIPATH_EXTC_GPIOINVERT_SHIFT 32
+#define INFINIPATH_EXTC_GPIOOE_MASK 0xFFFFULL
+#define INFINIPATH_EXTC_GPIOOE_SHIFT 48
+#define INFINIPATH_EXTC_SERDESENABLE         0x80000000ULL
+#define INFINIPATH_EXTC_SERDESCONNECT        0x40000000ULL
+#define INFINIPATH_EXTC_SERDESENTRUNKING     0x20000000ULL
+#define INFINIPATH_EXTC_SERDESDISRXFIFO      0x10000000ULL
+#define INFINIPATH_EXTC_SERDESENPLPBK1       0x08000000ULL
+#define INFINIPATH_EXTC_SERDESENPLPBK2       0x04000000ULL
+#define INFINIPATH_EXTC_SERDESENENCDEC       0x02000000ULL
+#define INFINIPATH_EXTC_LED1SECPORT_ON       0x00000020ULL
+#define INFINIPATH_EXTC_LED2SECPORT_ON       0x00000010ULL
+#define INFINIPATH_EXTC_LED1PRIPORT_ON       0x00000008ULL
+#define INFINIPATH_EXTC_LED2PRIPORT_ON       0x00000004ULL
+#define INFINIPATH_EXTC_LEDGBLOK_ON          0x00000002ULL
+#define INFINIPATH_EXTC_LEDGBLERR_OFF        0x00000001ULL
+
+/* kr_mdio bits */
+#define INFINIPATH_MDIO_CLKDIV_MASK 0x7FULL
+#define INFINIPATH_MDIO_CLKDIV_SHIFT 32
+#define INFINIPATH_MDIO_COMMAND_MASK 0x7ULL
+#define INFINIPATH_MDIO_COMMAND_SHIFT 26
+#define INFINIPATH_MDIO_DEVADDR_MASK 0x1FULL
+#define INFINIPATH_MDIO_DEVADDR_SHIFT 21
+#define INFINIPATH_MDIO_REGADDR_MASK 0x1FULL
+#define INFINIPATH_MDIO_REGADDR_SHIFT 16
+#define INFINIPATH_MDIO_DATA_MASK 0xFFFFULL
+#define INFINIPATH_MDIO_DATA_SHIFT 0
+#define INFINIPATH_MDIO_CMDVALID    0x0000000040000000ULL
+#define INFINIPATH_MDIO_RDDATAVALID 0x0000000080000000ULL
+
+/* kr_partitionkey bits */
+#define INFINIPATH_PKEY_SIZE 16
+#define INFINIPATH_PKEY_MASK 0xFFFF
+#define INFINIPATH_PKEY_DEFAULT_PKEY 0xFFFF
+
+/* kr_serdesconfig0 bits */
+#define INFINIPATH_SERDC0_RESET_MASK  0xfULL	/* overal reset bits */
+#define INFINIPATH_SERDC0_RESET_PLL   0x10000000ULL	/* pll reset */
+#define INFINIPATH_SERDC0_TXIDLE      0xF000ULL	/* tx idle enables (per lane) */
+#define INFINIPATH_SERDC0_RXDETECT_EN 0xF0000ULL	/* rx detect enables (per lane) */
+#define INFINIPATH_SERDC0_L1PWR_DN	 0xF0ULL	/* L1 Power down; use with RXDETECT,
+							   Otherwise not used on IB side */
+
+/* kr_xgxsconfig bits */
+#define INFINIPATH_XGXS_RESET          0x7ULL
+#define INFINIPATH_XGXS_MDIOADDR_MASK  0xfULL
+#define INFINIPATH_XGXS_MDIOADDR_SHIFT 4
+
+#define INFINIPATH_RT_ADDR_MASK 0xFFFFFFFFFFULL	/* 40 bits valid */
+
+/* TID entries (memory), HT400-only */
+#define INFINIPATH_RT_VALID 0x8000000000000000ULL
+#define INFINIPATH_RT_ADDR_SHIFT 0
+#define INFINIPATH_RT_BUFSIZE_MASK 0x3FFF
+#define INFINIPATH_RT_BUFSIZE_SHIFT 48
+
+/*
+ * IPATH_PIO_MAXIBHDR is the max IB header size allowed for in our
+ * PIO send buffers.  This is well beyond anything currently
+ * defined in the InfiniBand spec.
+ */
+#define IPATH_PIO_MAXIBHDR 128
+
+/* mask of defined bits for various registers */
+extern u64
+    infinipath_i_bitsextant, infinipath_e_bitsextant, infinipath_hwe_bitsextant;
+
+/* masks that are different in various chips, or only exist in some chips */
+extern u32 infinipath_i_rcvavail_mask, infinipath_i_rcvurg_mask;
+
+/*
+ * register bits for selecting i2c direction and values, used for I2C serial
+ * flash
+ */
+extern u16 ipath_gpio_sda_num, ipath_gpio_scl_num;
+extern u64 ipath_gpio_sda, ipath_gpio_scl;
+
+/*
+ * These are the infinipath general register numbers (not offsets).
+ * The kernel registers are used directly, those beyond the kernel
+ * registers are calculated from one of the base registers.  The use of
+ * an integer type doesn't allow type-checking as thorough as, say,
+ * an enum but allows for better hiding of chip differences.
+ */
+typedef const u16 ipath_kreg,	/* infinipath general registers */
+ ipath_creg,			/* infinipath counter registers */
+ ipath_sreg;			/* kernel-only, infinipath send registers */
+
+/*
+ * These are the chip registers common to all infinipath chips, and
+ * used both by the kernel and the diagnostics or other user code.
+ * They are all implemented such that 64 bit accesses work.
+ * Some implement no more than 32 bits.  Because 64 bit reads
+ * require 2 HT cmds on opteron, we access those with 32 bit
+ * reads for efficiency (they are written as 64 bits, since
+ * the extra 32 bits are nearly free on writes, and it slightly reduces
+ * complexity).  The rest are all accessed as 64 bits.
+ */
+struct ipath_kregs {
+	/* These are the 32 bit group */
+	ipath_kreg kr_control;
+	ipath_kreg kr_counterregbase;
+	ipath_kreg kr_intmask;
+	ipath_kreg kr_intstatus;
+	ipath_kreg kr_pagealign;
+	ipath_kreg kr_portcnt;
+	ipath_kreg kr_rcvtidbase;
+	ipath_kreg kr_rcvtidcnt;
+	ipath_kreg kr_rcvegrbase;
+	ipath_kreg kr_rcvegrcnt;
+	ipath_kreg kr_scratch;
+	ipath_kreg kr_sendctrl;
+	ipath_kreg kr_sendpiobufbase;
+	ipath_kreg kr_sendpiobufcnt;
+	ipath_kreg kr_sendpiosize;
+	ipath_kreg kr_sendregbase;
+	ipath_kreg kr_userregbase;
+	/* These are the 64 bit group */
+	ipath_kreg kr_debugport;
+	ipath_kreg kr_debugportselect;
+	ipath_kreg kr_errorclear;
+	ipath_kreg kr_errormask;
+	ipath_kreg kr_errorstatus;
+	ipath_kreg kr_extctrl;
+	ipath_kreg kr_extstatus;
+	ipath_kreg kr_gpio_clear;
+	ipath_kreg kr_gpio_mask;
+	ipath_kreg kr_gpio_out;
+	ipath_kreg kr_gpio_status;
+	ipath_kreg kr_hwdiagctrl;
+	ipath_kreg kr_hwerrclear;
+	ipath_kreg kr_hwerrmask;
+	ipath_kreg kr_hwerrstatus;
+	ipath_kreg kr_ibcctrl;
+	ipath_kreg kr_ibcstatus;
+	ipath_kreg kr_intblocked;
+	ipath_kreg kr_intclear;
+	ipath_kreg kr_interruptconfig;
+	ipath_kreg kr_mdio;
+	ipath_kreg kr_partitionkey;
+	ipath_kreg kr_rcvbthqp;
+	ipath_kreg kr_rcvbufbase;
+	ipath_kreg kr_rcvbufsize;
+	ipath_kreg kr_rcvctrl;
+	ipath_kreg kr_rcvhdrcnt;
+	ipath_kreg kr_rcvhdrentsize;
+	ipath_kreg kr_rcvhdrsize;
+	ipath_kreg kr_rcvintmembase;
+	ipath_kreg kr_rcvintmemsize;
+	ipath_kreg kr_revision;
+	ipath_kreg kr_sendbuffererror;
+	ipath_kreg kr_sendpioavailaddr;
+	ipath_kreg kr_serdesconfig0;
+	ipath_kreg kr_serdesconfig1;
+	ipath_kreg kr_serdesstatus;
+	ipath_kreg kr_txintmembase;
+	ipath_kreg kr_txintmemsize;
+	ipath_kreg kr_xgxsconfig;
+	ipath_kreg kr_ibpllcfg;
+	/* use these two (and the following N ports) only with ipath_k*_kreg64_port();
+	 * not *kreg64() */
+	ipath_kreg kr_rcvhdraddr;
+	ipath_kreg kr_rcvhdrtailaddr;
+
+	/* remaining registers are not present on all types of infinipath chips  */
+	ipath_kreg kr_rcvpktledcnt;
+	ipath_kreg kr_pcierbuftestreg0;
+	ipath_kreg kr_pcierbuftestreg1;
+	ipath_kreg kr_pcieq0serdesconfig0;
+	ipath_kreg kr_pcieq0serdesconfig1;
+	ipath_kreg kr_pcieq0serdesstatus;
+	ipath_kreg kr_pcieq1serdesconfig0;
+	ipath_kreg kr_pcieq1serdesconfig1;
+	ipath_kreg kr_pcieq1serdesstatus;
+};
+
+struct ipath_cregs {
+	ipath_creg cr_badformatcnt;
+	ipath_creg cr_erricrccnt;
+	ipath_creg cr_errlinkcnt;
+	ipath_creg cr_errlpcrccnt;
+	ipath_creg cr_errpkey;
+	ipath_creg cr_errrcvflowctrlcnt;
+	ipath_creg cr_err_rlencnt;
+	ipath_creg cr_errslencnt;
+	ipath_creg cr_errtidfull;
+	ipath_creg cr_errtidvalid;
+	ipath_creg cr_errvcrccnt;
+	ipath_creg cr_ibstatuschange;
+	ipath_creg cr_intcnt;
+	ipath_creg cr_invalidrlencnt;
+	ipath_creg cr_invalidslencnt;
+	ipath_creg cr_lbflowstallcnt;
+	ipath_creg cr_iblinkdowncnt;
+	ipath_creg cr_iblinkerrrecovcnt;
+	ipath_creg cr_ibsymbolerrcnt;
+	ipath_creg cr_pktrcvcnt;
+	ipath_creg cr_pktrcvflowctrlcnt;
+	ipath_creg cr_pktsendcnt;
+	ipath_creg cr_pktsendflowcnt;
+	ipath_creg cr_portovflcnt;
+	ipath_creg cr_rcvebpcnt;
+	ipath_creg cr_rcvovflcnt;
+	ipath_creg cr_rxdroppktcnt;
+	ipath_creg cr_senddropped;
+	ipath_creg cr_sendstallcnt;
+	ipath_creg cr_sendunderruncnt;
+	ipath_creg cr_unsupvlcnt;
+	ipath_creg cr_wordrcvcnt;
+	ipath_creg cr_wordsendcnt;
+};
+
+#endif				/* _IPATH_REGISTERS_H */
diff -r d4136de1a941 -r 2a9e52d59741 drivers/infiniband/hw/ipath/ips_common.h
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ips_common.h	Thu Mar  9 16:15:10 2006 -0800
@@ -0,0 +1,256 @@
+#ifndef IPS_COMMON_H
+#define IPS_COMMON_H
+/*
+ * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include "ipath_common.h"
+
+struct ipath_header {
+	/*
+	 * Version - 4 bits, Port - 4 bits, TID - 10 bits and Offset - 14 bits
+	 * before ECO change ~28 Dec 03.
+	 * After that, Vers 4, Port 3, TID 11, offset 14.
+	 */
+	__u32 ver_port_tid_offset;
+	__u16 chksum;
+	__u16 pkt_flags;
+};
+
+struct ips_message_header {
+	__be16 lrh[4];
+	__be32 bth[3];
+	/* fields below this point are in host byte order */
+	struct ipath_header iph;
+	__u8 sub_opcode;
+	__u8 flags;
+	__u16 src_rank;
+	/* 24 bits. The upper 8 bit is available for other use */
+	union {
+		struct {
+			unsigned ack_seq_num:24;
+			unsigned port:4;
+			unsigned unused:4;
+		};
+		__u32 ack_seq_num_org;
+	};
+	__u8 expected_tid_session_id;
+	__u8 tinylen;		/* to aid MPI */
+	__u16 tag;		/* to aid MPI */
+	union {
+		__u32 mpi[4];	/* to aid MPI */
+		__u32 data[4];
+		struct {
+			__u16 mtu;
+			__u8 major_ver;
+			__u8 minor_ver;
+			__u32 not_used;	//free
+			__u32 run_id;
+			__u32 client_ver;
+		};
+	};
+};
+
+struct ether_header {
+	__be16 lrh[4];
+	__be32 bth[3];
+	/* fields below this point are in host byte order */
+	struct ipath_header iph;
+	__u8 sub_opcode;
+	__u8 cmd;
+	__u16 lid;
+	__u16 mac[3];
+	__u8 frag_num;
+	__u8 seq_num;
+	__u32 len;
+	/* MUST be of word size do to PIO write requirements */
+	__u32 csum;
+	__u16 csum_offset;
+	__u16 flags;
+	__u16 first_2_bytes;
+	__u8 unused[2];		/* currently unused */
+};
+
+/*
+ * The PIO buffer used for sending infinipath messages must only be written
+ * in 32-bit words, all the data must be written, and no writes can occur
+ * after the last word is written (which transfers "ownership" of the buffer
+ * to the chip and triggers the message to be sent).
+ * Since the Linux sk_buff structure can be recursive, non-aligned, and
+ * any number of bytes in each segment, we use the following structure
+ * to keep information about the overall state of the copy operation.
+ * This is used to save the information needed to store the checksum
+ * in the right place before sending the last word to the hardware and
+ * to buffer the last 0-3 bytes of non-word sized segments.
+ */
+struct copy_data_s {
+	struct ether_header *hdr;
+	__u32 __iomem *csum_pio;	/* addr of PIO buf to write csum to */
+	__u32 __iomem *to;	/* addr of PIO buf to write data to */
+	__u32 device;		/* which device to allocate PIO bufs from */
+	__s32 error;		/* set if there is an error. */
+	__s32 extra;		/* amount of data saved in u.buf below */
+	__u32 len;		/* total length to send in bytes */
+	__u32 flen;		/* frament length in words */
+	__u32 csum;		/* partial IP checksum */
+	__u32 pos;		/* position for partial checksum */
+	__u32 offset;		/* offset to where data currently starts */
+	__s32 checksum_calc;	/* set to 1 when csum has been calculated */
+	struct sk_buff *skb;
+	union {
+		__u32 w;
+		__u8 buf[4];
+	} u;
+};
+
+/* IB - LRH header consts */
+#define IPS_LRH_GRH 0x0003	/* 1. word of IB LRH - next header: GRH */
+#define IPS_LRH_BTH 0x0002	/* 1. word of IB LRH - next header: BTH */
+
+#define IPS_OFFSET  0
+
+/*
+ * defines the cut-off point between the header queue and eager/expected
+ * TID queue
+ */
+#define NUM_OF_EXTRA_WORDS_IN_HEADER_QUEUE ((sizeof(struct ips_message_header) - offsetof(struct ips_message_header, iph)) >> 2)
+
+/* OpCodes  */
+#define OPCODE_IPS 0xC0
+#define OPCODE_ITH4X 0xC1
+
+/* OpCode 30 is use by stand-alone test programs  */
+#define OPCODE_RAW_DATA 0xDE
+/* last OpCode (31) is reserved for test  */
+#define OPCODE_TEST 0xDF
+
+/* sub OpCodes - ips  */
+#define OPCODE_SEQ_DATA 0x01
+#define OPCODE_SEQ_CTRL 0x02
+
+#define OPCODE_SEQ_MQ_DATA 0x03
+#define OPCODE_SEQ_MQ_CTRL 0x04
+
+#define OPCODE_ACK 0x10
+#define OPCODE_NAK 0x11
+
+#define OPCODE_ERR_CHK 0x20
+#define OPCODE_ERR_CHK_PLS 0x21
+
+#define OPCODE_STARTUP 0x30
+#define OPCODE_STARTUP_ACK 0x31
+#define OPCODE_STARTUP_NAK 0x32
+
+#define OPCODE_STARTUP_EXT 0x34
+#define OPCODE_STARTUP_ACK_EXT 0x35
+#define OPCODE_STARTUP_NAK_EXT 0x36
+
+#define OPCODE_TIDS_RELEASE 0x40
+#define OPCODE_TIDS_RELEASE_CONFIRM 0x41
+
+#define OPCODE_CLOSE 0x50
+#define OPCODE_CLOSE_ACK 0x51
+/*
+ * like OPCODE_CLOSE, but no complaint if other side has already closed.  Used
+ * when doing abort(), MPI_Abort(), etc.
+ */
+#define OPCODE_ABORT 0x52
+
+/* sub OpCodes - ith4x  */
+#define OPCODE_ENCAP 0x81
+#define OPCODE_LID_ARP 0x82
+
+/* Receive Header Queue: receive type (from infinipath) */
+#define RCVHQ_RCV_TYPE_EXPECTED  0
+#define RCVHQ_RCV_TYPE_EAGER     1
+#define RCVHQ_RCV_TYPE_NON_KD    2
+#define RCVHQ_RCV_TYPE_ERROR     3
+
+/* misc. */
+#define SIZE_OF_CRC 1
+
+#define EAGER_TID_ID INFINIPATH_I_TID_MASK
+
+#define IPS_DEFAULT_P_KEY 0xFFFF
+
+#define IPS_PERMISSIVE_LID 0xFFFF
+#define IPS_MULTICAST_LID_BASE 0xC000
+
+#define IPS_AETH_CREDIT_SHIFT 24
+#define IPS_AETH_CREDIT_MASK 0x1F
+#define IPS_AETH_CREDIT_INVAL 0x1F
+
+#define IPS_PSN_MASK 0xFFFFFF
+#define IPS_MSN_MASK 0xFFFFFF
+#define IPS_QPN_MASK 0xFFFFFF
+#define IPS_MULTICAST_QPN 0xFFFFFF
+
+/* functions for extracting fields from rcvhdrq entries */
+static inline __u32 ips_get_hdr_err_flags(const __u32 * rbuf)
+{
+	return rbuf[1];
+}
+
+static inline __u32 ips_get_index(const __u32 * rbuf)
+{
+	return (rbuf[0] >> INFINIPATH_RHF_EGRINDEX_SHIFT)
+	    & INFINIPATH_RHF_EGRINDEX_MASK;
+}
+
+static inline __u32 ips_get_rcv_type(const __u32 * rbuf)
+{
+	return (rbuf[0] >> INFINIPATH_RHF_RCVTYPE_SHIFT)
+	    & INFINIPATH_RHF_RCVTYPE_MASK;
+}
+
+static inline __u32 ips_get_length_in_bytes(const __u32 * rbuf)
+{
+	return ((rbuf[0] >> INFINIPATH_RHF_LENGTH_SHIFT)
+		& INFINIPATH_RHF_LENGTH_MASK) << 2;
+}
+
+static inline void *ips_get_first_protocol_header(const uint32_t * rbuf)
+{
+	return (void *)&rbuf[2];
+}
+
+static inline struct ips_message_header *ips_get_ips_header(const __u32 * rbuf)
+{
+	return (struct ips_message_header *)&rbuf[2];
+}
+
+static inline __u32 ips_get_ipath_ver(__u32 hdrword)
+{
+	return (hdrword >> INFINIPATH_I_VERS_SHIFT)
+	    & INFINIPATH_I_VERS_MASK;
+}
+
+#endif				/* IPS_COMMON_H */
