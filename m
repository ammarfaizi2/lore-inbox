Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbVL2Aou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbVL2Aou (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 19:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbVL2Aok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 19:44:40 -0500
Received: from mx.pathscale.com ([64.160.42.68]:50664 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932572AbVL2AjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 19:39:10 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 5 of 20] ipath - driver core header files
X-Mercurial-Node: 2d9a3f27a10c8f11df92fdcc55b0beb2d9e21135
Message-Id: <2d9a3f27a10c8f11df92.1135816284@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1135816279@eng-12.pathscale.com>
Date: Wed, 28 Dec 2005 16:31:24 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r a3a00f637da6 -r 2d9a3f27a10c drivers/infiniband/hw/ipath/ipath_common.h
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_common.h	Wed Dec 28 14:19:42 2005 -0800
@@ -0,0 +1,704 @@
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
+ *
+ * Patent licenses, if any, provided herein do not apply to
+ * combinations of this program with other software, or any other
+ * product whatsoever.
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
+#define IPATH_IDSTR "PathScale 1.1\n"
+
+typedef uint8_t ipath_type;
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
+
+/*
+ * These tell the driver which ioctl's belong to the diags interface.
+ * As above, don't use them elsewhere.
+ */
+#define _IPATH_DIAG_IOCTL_LOW 100
+#define _IPATH_DIAG_IOCTL_HIGH 109
+
+struct ipath_eeprom_req {
+	long long addr;
+	uint16_t len;
+	uint16_t offset;
+};
+
+/*
+ * NOTE:   We use compatible ioctls, the same ioctl code for both 32 and 64
+ * bit user mode.  For that reason, all structures, etc. used in these
+ * ioctls must have the same size and offsets, in both 32 and 64 bit mode.
+ * We normally use uint64_t to  hold pointers for this reason, doing appropriate
+ * casts on both sides before using the data value.
+ */
+
+/* init;  user params to kernel  */
+#define IPATH_USERINIT      _IOW('s', 16, struct ipath_user_info)
+/* init;  kernel/chip params to user */
+#define IPATH_BASEINFO      _IOR('s', 17, struct ipath_base_info)
+/* send a packet */
+#define IPATH_SENDPKT       _IOW('s', 18, struct ipath_sendpkt)
+/*
+ * if arg is 0, disable port, used when flushing after a hdrq overflow.
+ * If arg ia 1, re-enable, and return new value of head register
+ */
+#define IPATH_RCVCTRL       _IOR('s', 19, uint32_t)
+#define IPATH_READ_EEPROM  _IOWR('s', 20, struct ipath_eeprom_req)
+/* set an accepted partition key; up to 4 pkeys can be active at once */
+#define IPATH_SET_PKEY      _IOW('s', 21, uint16_t)
+#define IPATH_WRITE_EEPROM _IOWR('s', 22, struct ipath_eeprom_req)
+/* set LID for interface (SMA) */
+#define IPATH_SET_LID       _IOW('s', 23, uint32_t)
+/* set IB MTU for interface (SMA) */
+#define IPATH_SET_MTU       _IOW('s', 24, uint32_t)
+/* set IB link state for interface (SMA) */
+#define IPATH_SET_LINKSTATE _IOW('s', 25, uint32_t)
+/* send an SMA packet, sps_flags contains "normal" SMA unit and minor number. */
+#define IPATH_SEND_SMA_PKT  _IOW('s', 26, struct ipath_sendpkt)
+/* receive an SMA packet */
+#define IPATH_RCV_SMA_PKT   _IOW('s', 27, struct ipath_sendpkt)
+/* get the portinfo data (SMA)
+ * takes array of 13, returns port info fields.  Data is in host order,
+ * not network order; SMA-only fields are not filled in
+ */
+#define IPATH_GET_PORTINFO  _IOWR('s', 28, uint32_t *)
+/*
+ * get the nodeinfo data (SMA)
+ * takes an array of 10, returns nodeinfo fields in host order
+ */
+#define IPATH_GET_NODEINFO  _IOWR('s', 29, uint32_t *)
+/* set GUID on interface (SMA; GUID given in network order) */
+#define IPATH_SET_GUID      _IOW('s', 30,  struct ipath_setguid)
+/* set MLID for interface (SMA) */
+#define IPATH_SET_MLID      _IOW('s', 31, uint32_t)
+#define IPATH_GET_MLID      _IOWR('s', 32, uint32_t *)	/* get the MLID (SMA) */
+/* update expected TID entries */
+#define IPATH_UPDM_TID      _IOWR('s', 33, struct _tidupd)
+/* free expected TID entries */
+#define IPATH_FREE_TID      _IOW('s', 34, struct _tidupd)
+/* return assigned unit:port */
+#define IPATH_GETPORT       _IOR('s', 35, uint32_t)
+/* wait for rcv pkt or pioavail */
+#define IPATH_WAIT          _IOW('s', 36, uint32_t)
+/* return LID for passed in unit */
+#define IPATH_GETLID        _IOR('s', 37, uint16_t)
+/* return # of units supported by driver */
+#define IPATH_GETUNITS      _IO('s',  38)
+/* get the device status */
+#define IPATH_GET_DEVSTATUS _IOWR('s', 39, uint64_t *)
+
+/* available for reuse ('s', 48) */
+
+/* diagnostic read */
+#define IPATH_DIAGREAD      _IOR('s', 100, struct ipath_diag_info)
+/* diagnostic write */
+#define IPATH_DIAGWRITE     _IOW('s', 101, struct ipath_diag_info)
+/* HT Config read */
+#define IPATH_DIAG_HTREAD   _IOR('s', 102, struct ipath_diag_info)
+/* HT config write */
+#define IPATH_DIAG_HTWRITE  _IOW('s', 103, struct ipath_diag_info)
+#define IPATH_DIAGENTER     _IO('s', 104)	/* Enter diagnostic mode */
+#define IPATH_DIAGLEAVE     _IO('s', 105)	/* Leave diagnostic mode */
+/* send a packet, sps_flags contains unit and minor number. */
+#define IPATH_SEND_DIAG_PKT _IOW('s', 106, struct ipath_sendpkt)
+/*
+ * read I2C FLASH
+ * NOTE: To read the I2C device, the _uaddress field should contain
+ * a pointer to struct ipath_eeprom_req, and _unit must be valid
+ */
+#define IPATH_DIAG_RD_I2C   _IOW('s', 107, struct ipath_diag_info)
+
+/*
+ * Monitoring ioctls.  All of these work with the main device
+ * (/dev/ipath), if you don't mind using a port (e.g. you already have
+ * the device open.)  IPATH_GETSTATS and IPATH_GETUNITCOUNTERS also
+ * work with the control device (/dev/ipath_ctrl), if you don't want to
+ * use a port.
+ */
+
+/* return chip counters for current unit. */
+#define IPATH_GETCOUNTERS     _IOR('s', 40, struct infinipath_counters)
+/* return chip stats */
+#define IPATH_GETSTATS        _IOR('s', 41, struct infinipath_stats)
+/* return chip counters for a particular unit. */
+#define IPATH_GETUNITCOUNTERS _IOR('s', 43, struct infinipath_getunitcounters)
+
+/*
+ * unit is incoming unit number.
+ * data is a pointer to the infinipath_counters structure.
+ */
+struct infinipath_getunitcounters {
+	uint16_t unit;
+	uint16_t fill[3]; /* required for same size struct 32/64 bit */
+	uint64_t data;
+};
+
+/*
+ * The value in the BTH QP field that InfiniPath uses to differentiate
+ * an infinipath protocol IB packet vs standard IB transport
+ */
+#define IPATH_KD_QP 0x656b79
+
+/*
+ * valid states passed to ipath_set_linkstate() user call
+ * (IPATH_SET_LINKSTATE ioctl)
+ */
+#define IPATH_IB_LINKDOWN		0
+#define IPATH_IB_LINKARM		1
+#define IPATH_IB_LINKACTIVE		2
+#define IPATH_IB_LINKINIT		3
+#define IPATH_IB_LINKDOWN_POLL		4
+#define IPATH_IB_LINKDOWN_DISABLE	5
+
+/*
+ * stats maintained by the driver.  For now, at least, this is global
+ * to all minor devices.
+ */
+struct infinipath_stats {
+	uint64_t sps_ints;	/* number of interrupts taken */
+	uint64_t sps_errints;	/* number of interrupts for errors */
+	/* number of errors from chip (not including packet errors or CRC) */
+	uint64_t sps_errs;
+	/* number of packet errors from chip other than CRC */
+	uint64_t sps_pkterrs;
+	/* number of packets with CRC errors (ICRC and VCRC) */
+	uint64_t sps_crcerrs;
+	/* number of hardware errors reported (parity, etc.) */
+	uint64_t sps_hwerrs;
+	/* number of times IB link changed state unexpectedly */
+	uint64_t sps_iblink;
+	uint64_t sps_unused3;	/* no longer used; left for compatibility */
+	uint64_t sps_port0pkts; /* number of kernel (port0) packets received */
+	/* number of "ethernet" packets sent by driver */
+	uint64_t sps_ether_spkts;
+	/* number of "ethernet" packets received by driver */
+	uint64_t sps_ether_rpkts;
+	uint64_t sps_sma_spkts;	/* number of SMA packets sent by driver */
+	uint64_t sps_sma_rpkts;	/* number of SMA packets received by driver */
+	/* number of times all ports rcvhdrq was full and packet dropped */
+	uint64_t sps_hdrqfull;
+	/* number of times all ports egrtid was full and packet dropped */
+	uint64_t sps_etidfull;
+	/*
+	 * number of times we tried to send from driver, but no pio
+	 * buffers avail
+	 */
+	uint64_t sps_nopiobufs;
+	uint64_t sps_ports;	/* number of ports currently open */
+	/* list of pkeys (other than default) accepted (0 means not set) */
+	uint16_t sps_pkeys[4];
+	/* lids for up to 4 infinipaths, indexed by infinipath # */
+	uint16_t sps_lid[4];
+	/* number of user ports per chip (not IB ports) */
+	uint32_t sps_nports;
+	uint32_t sps_nullintr;	/* not our interrupt, or already handled */
+	uint32_t sps_maxpkts_call;  /* max number of packets handled per receive call */
+	uint32_t sps_avgpkts_call;  /* avg number of packets handled per receive call */
+	uint64_t sps_pagelocks;	/* total number of pages locked */
+	uint64_t sps_pageunlocks; /* total number of pages unlocked */
+	/*
+	 * Number of packets dropped in kernel other than errors
+	 * (ether packets if ipath not configured, sma/mad, etc.)
+	 */
+	uint64_t sps_krdrops;
+	/* mlids for up to 4 infinipaths, indexed by infinipath # */
+	uint16_t sps_mlid[4];
+	uint64_t __sps_pad[45];	/* pad for future growth */
+};
+
+/*
+ * These are the status bits returned (in ascii form, 64bit value)
+ * by the IPATH_GETSTATS ioctl.
+ */
+#define IPATH_STATUS_INITTED       0x1	/* basic driver initialization done */
+#define IPATH_STATUS_DISABLED      0x2  /* hardware disabled */
+#define IPATH_STATUS_UNUSED        0x4	/* available */
+#define IPATH_STATUS_OIB_SMA       0x8	/* ipath_mad kernel SMA running */
+#define IPATH_STATUS_SMA          0x10	/* user SMA running */
+/* Chip has been found and initted */
+#define IPATH_STATUS_CHIP_PRESENT 0x20
+#define IPATH_STATUS_IB_READY     0x40	/* IB link is at ACTIVE, has LID,
+										 * usable for all VL's */
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
+/* SMA minor# no portinfo, one for all instances */
+#define IPATH_SMA 128
+
+/* Control minor# no portinfo, one for all instances */
+#define IPATH_CTRL 130
+
+/*
+ * This structure is returned by ipath_userinit() immediately after open
+ * to get implementation-specific info, and info specific to this
+ * instance.
+ */
+struct ipath_base_info {
+	/* version of hardware, for feature checking. */
+	uint32_t spi_hw_version;
+	/* version of software, for feature checking. */
+	uint32_t spi_sw_version;
+	/* InfiniPath port assigned, goes into sent packets */
+	uint32_t spi_port;
+	/*
+	 * IB MTU, packets IB data must be less than this.
+	 * The MTU is in bytes, and will be a multiple of 4 bytes.
+	 */
+	uint32_t spi_mtu;
+	/*
+	 * size of a PIO buffer.  Any given packet's total
+	 * size must be less than this (in words).  Included is the
+	 * starting control word, so if 513 is returned, then total
+	 * pkt size is 512 words or less.
+	 */
+	uint32_t spi_piosize;
+	/* size of the TID cache in infinipath, in entries */
+	uint32_t spi_tidcnt;
+	/* size of the TID Eager list in infinipath, in entries */
+	uint32_t spi_tidegrcnt;
+	/* size of a single receive header queue entry. */
+	uint32_t spi_rcvhdrent_size;
+	/* Count of receive header queue entries allocated.
+	 * This may be less than the spu_rcvhdrcnt passed in!.
+	 */
+	uint32_t spi_rcvhdr_cnt;
+
+	uint32_t __32_bit_compatibility_pad;	/* DO NOT  MOVE OR REMOVE */
+
+	/* address where receive buffer queue is mapped into */
+	uint64_t spi_rcvhdr_base;
+
+	/* user program. */
+
+	/* base address of eager TID receive buffers. */
+	uint64_t spi_rcv_egrbufs;
+
+	/* Allocated by initialization code, not by protocol. */
+
+	/* size of each TID buffer in host memory,
+	 * starting at spi_rcv_egrbufs.  It includes spu_egrskip, and is
+	 * at least spi_mtu bytes, and the buffers are virtually contiguous
+	 */
+	uint32_t spi_rcv_egrbufsize;
+	/*
+	 * The special QP (queue pair) value that identifies an infinipath
+	 * protocol packet from standard IB packets.  More, probably much
+	 * more, to be added.
+	 */
+	uint32_t spi_qpair;
+
+	/*
+	 * user register base for init code, not to be used directly by
+	 * protocol or applications
+	 */
+	uint64_t __spi_uregbase;
+	/*
+	 * maximum buffer size in bytes that can be used in a
+	 * single TID entry (assuming the buffer is aligned to this boundary).
+	 * This is the minimum of what the hardware and software support
+	 * Guaranteed to be a power of 2.
+	 */
+	uint32_t spi_tid_maxsize;
+	/*
+	 * alignment of each pio send buffer (byte count
+	 * to add to spi_piobufbase to get to second buffer)
+	 */
+	uint32_t spi_pioalign;
+	/*
+	 * the index of the first pio buffer available
+	 * to this process; needed to do lookup in spi_pioavailaddr; not added
+	 * to spi_piobufbase
+	 */
+	uint32_t spi_pioindex;
+	uint32_t spi_piocnt;	/* number of buffers mapped for this process */
+
+	/*
+	 * base address of writeonly pio buffers for this process.
+	 * Each buffer has spi_piosize words, and is aligned on spi_pioalign
+	 * boundaries.  spi_piocnt buffers are mapped from this address
+	 */
+	uint64_t spi_piobufbase;
+
+	/*
+	 * base address of readonly memory copy of the pioavail registers.
+	 * There are 2 bits for each buffer.
+	 */
+	uint64_t spi_pioavailaddr;
+
+	/*
+	 * Address where driver updates a copy
+	 * of the interface and driver status (IPATH_STATUS_*) as a 64 bit value
+	 * It's followed by a string indicating hardware error, if there was one
+	 */
+	uint64_t spi_status;
+
+	/* number of chip ports available to user processes */
+	uint32_t spi_nports;
+	uint32_t spi_unit;	/* unit number of chip we are using */
+	uint32_t spi_rcv_egrperchunk;	/* num bufs in each contiguous set */
+	/* size in bytes of each contiguous set */
+	uint32_t spi_rcv_egrchunksize;
+	/* total size of mmap to cover full rcvegrbuffers */
+	uint32_t spi_rcv_egrbuftotlen;
+	/*
+	 * ioctl cmd includes struct size, so pad out, and adjust down as
+	 * new fields are added to keep size constant
+	 */
+	uint32_t __spi_pad[19];
+} __attribute__ ((aligned(8)));
+
+#define IPATH_WAIT_RCV   0x1	/* IPATH_WAIT, receive */
+#define IPATH_WAIT_PIO   0x2	/* IPATH_WAIT, PIO */
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
+ * user code buffers are, sizes, etc.
+ */
+struct ipath_user_info {
+	/*
+	 * version of user software, to detect compatibility issues.
+	 * Should be set to IPATH_USER_SWVERSION.
+	 */
+	uint32_t spu_userversion;
+
+	/* desired number of receive header queue entries */
+	uint32_t spu_rcvhdrcnt;
+
+	/*
+	 * Leave this much unused space at the start of
+	 * each eager buffer for software use.  Similar in effect to
+	 * setting K_Offset to this value.  needs to be 'small', on the
+	 * order of one or two cachelines
+	 */
+	uint32_t spu_egrskip;
+
+	/*
+	 * number of words in KD protocol header
+	 * This tells InfiniPath how many words to copy to rcvhdrq.  If 0,
+	 * kernel uses a default.  Once set, attempts to set any other value
+	 * are an error (EAGAIN) until driver is reloaded.
+	 */
+	uint32_t spu_rcvhdrsize;
+
+	/*
+	 * cache line aligned (64 byte) user address to
+	 * which the rcvhdrtail register will be written by infinipath
+	 * whenever it changes, so that no chip registers are read in
+	 * the performance path.
+	 */
+	uint64_t spu_rcvhdraddr;
+
+	/*
+	 * ioctl cmd includes struct size, so pad out,
+	 * and adjust down as new fields are added to keep size constant
+	 */
+	uint32_t __spu_pad[6];
+} __attribute__ ((aligned(8)));
+
+struct ipath_iovec {
+	/* Pointer to data, but same size 32 and 64 bit */
+	uint64_t iov_base;
+
+	/*
+	 * Length of data; don't need 64 bits, but want
+	 * ipath_sendpkt to remain same size as before 32 bit changes, so...
+	 */
+	uint64_t iov_len;
+};
+
+/*
+ * Describes a single packet for send.  Each packet can have one or more
+ * buffers, but the total length (exclusive of IB headers) must be less
+ * than the MTU, and if using the PIO method, entire packet length,
+ * including IB headers, must be less than the ipath_piosize value (words).
+ * Use of this necessitates including sys/uio.h
+ */
+struct ipath_sendpkt {
+	uint32_t sps_flags;	/* flags for packet (TBD) */
+	uint32_t sps_cnt;	/* number of entries to use in sps_iov */
+	/* array of iov's describing packet. TEMPORARY */
+	struct ipath_iovec sps_iov[4];
+};
+
+struct _tidupd {		/* used only in inlined function for ioctl. */
+	uint32_t tidcnt;
+	uint32_t tid__unused;	/* make structure same size in 32 and 64 bit */
+	uint64_t tidvaddr;	/* virtual address of first page in transfer */
+	/* pointer (same size 32/64 bit) to uint16_t tid array */
+	uint64_t tidlist;
+
+	/*
+	 * pointer (same size 32/64 bit) to bitmap of TIDs used
+	 * for this call; checked for being large enough at open
+	 */
+	uint64_t tidmap;
+};
+
+struct ipath_setguid {		/* set GUID for interface */
+	uint64_t sguid;		/* in network order */
+	uint64_t sunit;		/* unit number of interface */
+};
+
+/*
+ * Structure used to send data to and receive data from a diags ioctl.
+ *
+ * NOTE: For HT reads and writes, we only support byte, word (16bits) and
+ * dword (32bits).  All other sizes for HT are invalid.
+ */
+struct ipath_diag_info {
+	uint64_t _base_offset;	/* register to start reading from */
+	uint64_t _num_bytes;	/* number of bytes to read or write */
+	/*
+	 * address in user space.
+	 * for reads, this is the address to store the read result(s).
+	 * for writes, it the address to get the write data from.
+	 * This memory better be valid in user space!
+	 */
+	uint64_t _uaddress;
+	uint64_t _unit;		/* Unit ID of chip we are accessing. */
+	uint64_t _pad[15];
+};
+
+/*
+ * Data layout in I2C flash (for GUID, etc.)
+ * All fields are little-endian binary unless otherwise stated
+ */
+#define IPATH_FLASH_VERSION 1
+struct ipath_flash {
+	uint8_t if_fversion;	/* flash layout version (IPATH_FLASH_VERSION) */
+	uint8_t if_csum;	/* checksum protecting if_length bytes */
+	/*
+	 * valid length (in use, protected by if_csum), including if_fversion
+	 * and if_sum themselves)
+	 */
+	uint8_t if_length;
+	uint8_t if_guid[8];	/* the GUID, in network order */
+	/* number of GUIDs to use, starting from if_guid */
+	uint8_t if_numguid;
+	char    if_serial[12];	/* the board serial number, in ASCII */
+	char    if_mfgdate[8];	/* board mfg date (YYYYMMDD ASCII) */
+	/* last board rework/test date (YYYYMMDD ASCII) */
+	char    if_testdate[8];
+	uint8_t if_errcntp[4];	/* logging of error counts, TBD */
+	/* powered on hours, updated at driver unload */
+	uint8_t if_powerhour[2];
+	char    if_comment[32];	/* ASCII free-form comment field */
+	uint8_t if_future[50];	/* 78 bytes used, min flash size is 128 bytes */
+};
+
+uint8_t ipath_flash_csum(struct ipath_flash *, int);
+
+/*
+ * These are the counters implemented in the chip, and are listed in order.
+ * They are returned in this order by the IPATH_GETCOUNTERS ioctl
+ */
+struct infinipath_counters {
+	unsigned long long LBIntCnt;
+	unsigned long long LBFlowStallCnt;
+	unsigned long long Reserved1;
+	unsigned long long TxUnsupVLErrCnt;
+	unsigned long long TxDataPktCnt;
+	unsigned long long TxFlowPktCnt;
+	unsigned long long TxDwordCnt;
+	unsigned long long TxLenErrCnt;
+	unsigned long long TxMaxMinLenErrCnt;
+	unsigned long long TxUnderrunCnt;
+	unsigned long long TxFlowStallCnt;
+	unsigned long long TxDroppedPktCnt;
+	unsigned long long RxDroppedPktCnt;
+	unsigned long long RxDataPktCnt;
+	unsigned long long RxFlowPktCnt;
+	unsigned long long RxDwordCnt;
+	unsigned long long RxLenErrCnt;
+	unsigned long long RxMaxMinLenErrCnt;
+	unsigned long long RxICRCErrCnt;
+	unsigned long long RxVCRCErrCnt;
+	unsigned long long RxFlowCtrlErrCnt;
+	unsigned long long RxBadFormatCnt;
+	unsigned long long RxLinkProblemCnt;
+	unsigned long long RxEBPCnt;
+	unsigned long long RxLPCRCErrCnt;
+	unsigned long long RxBufOvflCnt;
+	unsigned long long RxTIDFullErrCnt;
+	unsigned long long RxTIDValidErrCnt;
+	unsigned long long RxPKeyMismatchCnt;
+	unsigned long long RxP0HdrEgrOvflCnt;
+	unsigned long long RxP1HdrEgrOvflCnt;
+	unsigned long long RxP2HdrEgrOvflCnt;
+	unsigned long long RxP3HdrEgrOvflCnt;
+	unsigned long long RxP4HdrEgrOvflCnt;
+	unsigned long long RxP5HdrEgrOvflCnt;
+	unsigned long long RxP6HdrEgrOvflCnt;
+	unsigned long long RxP7HdrEgrOvflCnt;
+	unsigned long long RxP8HdrEgrOvflCnt;
+	unsigned long long Reserved6;
+	unsigned long long Reserved7;
+	unsigned long long IBStatusChangeCnt;
+	unsigned long long IBLinkErrRecoveryCnt;
+	unsigned long long IBLinkDownedCnt;
+	unsigned long long IBSymbolErrCnt;
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
diff -r a3a00f637da6 -r 2d9a3f27a10c drivers/infiniband/hw/ipath/ipath_kernel.h
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Wed Dec 28 14:19:42 2005 -0800
@@ -0,0 +1,697 @@
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
+ *
+ * Patent licenses, if any, provided herein do not apply to
+ * combinations of this program with other software, or any other
+ * product whatsoever.
+ */
+
+
+
+/*
+ * This header file is the base header file for infinipath kernel code
+ * ipath_user.h serves a similar purpose for user code.
+ */
+
+#include "ipath_common.h"
+#include "ipath_kdebug.h"
+#include "ipath_registers.h"
+#include <linux/timex.h>
+#include <asm/io.h>
+
+/* only s/w major version of InfiniPath we can handle */
+#define IPATH_CHIP_VERS_MAJ 2U
+
+#define IPATH_CHIP_VERS_MIN 0U	/* don't care about this except printing */
+
+extern struct infinipath_stats ipath_stats; /* temporary, maybe always */
+
+/* only s/w version of chip we can handle for now */
+#define IPATH_CHIP_SWVERSION IPATH_CHIP_VERS_MAJ
+
+struct ipath_portdata {
+	/* minor number of devices, for ipath_type use */
+	unsigned port_unit;
+	/* array of struct page pointers */
+	struct page **port_rcvegrbuf_pages;
+	/* array of virtual addresses (from above) */
+	void **port_rcvegrbuf_virt;
+	void *port_rcvhdrq;	/* rcvhdrq base, needs mmap before useful */
+	/* kernel virtual address where hdrqtail is updated */
+	uint64_t *port_rcvhdrtail_kvaddr;
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
+	unsigned long port_rcvegr_phys;
+	/* for mmap of hdrq, must fit in 44 bits */
+	unsigned long port_rcvhdrq_phys;
+	/*
+	 * the actual user address that we locked, so we can
+	 * unlock it at close
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
+	unsigned port_egrskip;
+	unsigned port_port;	/* instead of calculating it */
+	uint32_t port_piobufs;	/* chip offset of PIO buffers for this port */
+	/* how many alloc_pages() chunks in port_rcvegrbuf_pages */
+	uint32_t port_rcvegrbuf_chunks;
+	uint32_t port_rcvegrbufs_perchunk;	/* how many egrbufs per chunk */
+	/* order used with port_rcvegrbuf_pages */
+	uint32_t port_rcvegrbuf_order;
+	uint32_t port_rcvhdrq_order;	/* rcvhdrq order (for free_pages) */
+	/* next expected TID to check when looking for free */
+	uint32_t port_tidcursor;
+	/* next expected TID to check when looking for free */
+	uint32_t port_flag;
+	/* WAIT_RCV that timed out, no interrupt */
+	uint32_t port_rcvwait_to;
+	/* WAIT_PIO that timed out, no interrupt */
+	uint32_t port_piowait_to;
+	uint32_t port_rcvnowait;	/* WAIT_RCV already happened, no wait */
+	uint32_t port_pionowait;	/* WAIT_PIO already happened, no wait */
+	uint32_t port_hdrqfull;	/* total number of rcvhdrqfull errors */
+	pid_t port_pid;		/* pid of process using this port */
+	/* same size as task_struct .comm[], but no define */
+	char port_comm[16];
+	uint16_t port_pkeys[4];	/* pkeys set by this use of this port */
+};
+
+struct sk_buff;
+
+/*
+ * control information for layered drivers
+ * This is used only as part of devdata via ipath_layer;
+ */
+struct _ipath_layer {
+	int (*l_intr) (const ipath_type, uint32_t);
+	int (*l_rcv) (const ipath_type, void *, struct sk_buff *);
+	int (*l_rcv_lid) (const ipath_type, void *);
+	uint16_t l_rcv_opcode;
+	uint16_t l_rcv_lid_opcode;
+};
+
+/* Verbs layer interface */
+struct _verbs_layer {
+	int (*l_piobufavail) (const ipath_type);
+	void (*l_rcv) (const ipath_type, void *, void *, uint32_t);
+	void (*l_timer_cb) (const ipath_type);
+	struct timer_list l_timer;
+	unsigned l_flags;
+};
+
+/*
+ * These are the fields that only exist for port 0, not per port, so
+ * they aren't in ipath_devdata
+ */
+struct ipath_devdata {
+	/* driver data structures */
+	/* mem-mapped pointer to base of chip regs; should always use read/write{lq}
+	 * when accesses are made, or via memcpy32() for PIO buffers*/
+	uint64_t __iomem *ipath_kregbase;
+	/* end of mem-mapped chip space; range checking */
+	uint64_t __iomem *ipath_kregend;
+	/* physical address of chip for io_remap, etc. */
+	unsigned long ipath_physaddr;
+	/* base of memory alloced for ipath_kregbase, for free */
+	uint64_t *ipath_kregalloc;
+	/*
+	 * version of kregbase that doesn't have high bits set (for 32 bit
+	 * programs, so mmap64 44 bit works)
+	 */
+	uint64_t __iomem *ipath_kregvirt;
+	struct ipath_portdata **ipath_pd; /* ipath_cfgports pointers */
+	/* sk_buffs used by port 0 eager receive queue */
+	struct sk_buff **ipath_port0_skbs;
+	void __iomem *ipath_piobase;	/* kvirt address of 1st pio buffer */
+
+	/*
+	 * virtual address where port0 rcvhdrqtail updated by chip via DMA
+	 * volatile because we want to be sure compiler always makes a memory
+	 * reference when we dereference it.
+	 */
+	volatile uint64_t *ipath_hdrqtailptr;
+	/*
+	 * points to area where PIOavail registers will be DMA'ed.  Has to
+	 * be on a page of it's own, because the page will be mapped into user
+	 * program space.  Updated by chip via DMA, treated as readonly by software.
+	 * volatile because we want to be sure compiler always makes a memory
+	 * reference when we dereference it.
+	 */
+	volatile uint64_t *ipath_pioavailregs_dma;
+
+	/* original address for kfree */
+	volatile uint64_t *__ipath_pioavailregs_base;
+	/* physical address where updates occur */
+	unsigned long ipath_pioavailregs_phys;
+	struct _ipath_layer ipath_layer;
+	struct _verbs_layer verbs_layer;
+	/* total dwords sent (summed from counter) */
+	uint64_t ipath_sword;
+	/* total dwords received (summed from counter) */
+	uint64_t ipath_rword;
+	/* total packets sent (summed from counter) */
+	uint64_t ipath_spkts;
+	/* total packets received (summed from counter) */
+	uint64_t ipath_rpkts;
+	/* to make the receive interrupt failsafe */
+	uint64_t ipath_lastqtail;
+	uint64_t _ipath_status;	/* ipath_statusp initially points to this. */
+	uint64_t ipath_guid;	/* GUID for this interface, in network order */
+	/*
+	 * aggregrate of error bits reported since
+	 * last cleared, for limiting of error reporting
+	 */
+	uint64_t ipath_lasterror;
+	/*
+	 * aggregrate of error bits reported
+	 * since last cleared, for limiting of hwerror reporting
+	 */
+	uint64_t ipath_lasthwerror;
+	/*
+	 * errors masked because they occur too fast,
+	 * also includes errors that are always ignored (ipath_ignorederrs)
+	 */
+	uint64_t ipath_maskederrs;
+	/* time at which to re-enable maskederrs */
+	cycles_t ipath_unmasktime;
+	/*
+	 * errors always ignored (masked), at least
+	 * for a given chip/device, because they are wrong or not useful
+	 */
+	uint64_t ipath_ignorederrs;
+	/* count of egrfull errors, combined for all ports */
+	uint64_t ipath_last_tidfull;
+	uint64_t ipath_lastport0rcv_cnt; /* for ipath_qcheck() */
+
+	uint32_t ipath_kregsize;	/* size of memory at ipath_kregbase */
+	/* number of registers used for pioavail */
+	uint32_t ipath_pioavregs;
+	uint32_t ipath_flags;	/* IPATH_POLL, etc. */
+	/* ipath_flags sma is waiting for */
+	uint32_t ipath_sma_state_wanted;
+	/* last buffer for user use, first buf for kernel use is this index. */
+	uint32_t ipath_lastport_piobuf;
+	uint32_t pci_registered;	/* driver is a registered pci device */
+	uint32_t ipath_stats_timer_active;	/* is a stats timer active */
+	/* dwords sent read from infinipath counter */
+	uint32_t ipath_lastsword;
+	/* dwords received read from infinipath counter */
+	uint32_t ipath_lastrword;
+	/* sent packets read from infinipath counter */
+	uint32_t ipath_lastspkts;
+	/* received packets read from infinipath counter */
+	uint32_t ipath_lastrpkts;
+	uint32_t ipath_pbufsport;	/* pio bufs allocated per port */
+	/*
+	 * number of ports configured as max; zero is
+	 * set to number chip supports, less gives more pio bufs/port, etc.
+	 */
+	uint32_t ipath_cfgports;
+	/* our idea of the port0 rcvhdrq head offset */
+	uint32_t ipath_port0head;
+	uint32_t ipath_p0_hdrqfull;	/* count of port 0 hdrqfull errors */
+
+	/*
+	 * (*cfgports) used to suppress multiple instances of same port
+	 * staying stuck at same point
+	 */
+	uint32_t *ipath_lastrcvhdrqtails;
+	/*
+	 * (*cfgports) used to suppress multiple instances of same port
+	 * staying stuck at same point
+	 */
+	uint32_t *ipath_lastegrheads;
+	/*
+	 * index of last piobuffer we used.  Speeds up searching, by starting
+	 * at this point.  Doesn't matter if multiple cpu's use and update,
+	 * last updater is only write that matters.  Whenever it wraps,
+	 * we update shadow copies.  Need a copy per device when we get to
+	 * multiple devices
+	 */
+	uint32_t ipath_lastpioindex;
+	uint32_t ipath_freezelen;	/* max length of freezemsg */
+	uint32_t ipath_consec_nopiobuf; /* consecutive times we wanted a PIO buffer
+		* but were unable to get one */
+	uint32_t ipath_upd_pio_shadow; /* hint that we should update
+		* ipath_pioavailshadow before looking for a PIO buffer */
+	uint32_t ipath_nosma_bufs; /* sequential tries for SMA send and no bufs */
+	uint32_t ipath_nosma_secs; /* duration (seconds) ipath_nosma_bufs set */
+	/* HT/PCI Vendor ID (here for NodeInfo) */
+	uint16_t ipath_vendorid;
+	/* HT/PCI Device ID (here for NodeInfo) */
+	uint16_t ipath_deviceid;
+	/* offset in HT config space of slave/primary interface block */
+	uint8_t ipath_ht_slave_off;
+	int ipath_mtrr;		/* registration handle for WRCOMB setting on */
+	/* ref count of how many users set each pkey */
+	atomic_t ipath_pkeyrefs[4];
+	/* shadow copy of all exptids physaddr; used only by funcsim */
+	uint64_t *ipath_tidsimshadow;
+	/* shadow copy of struct page *'s for exp tid pages */
+	struct page **ipath_pageshadow;
+	/*
+	 * IPATH_STATUS_*
+	 * this address is mapped readonly into user processes so they can
+	 * get status cheaply, whenever they want.
+	 */
+	uint64_t *ipath_statusp;
+	char *ipath_freezemsg;	/* freeze msg if hw error put chip in freeze */
+	struct pci_dev *pcidev;	/* pci access data structure */
+	/* timer used to prevent stats overflow, error throttling, etc. */
+	struct timer_list ipath_stats_timer;
+	/* only allow one interrupt at a time. */
+	unsigned long ipath_rcv_pending;
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
+	/*
+	 * shadow of pioavail, check to be sure it's large enough at
+	 * init time.
+	 */
+	uint64_t ipath_pioavailshadow[8];
+	uint64_t ipath_gpio_out;	/* shadow of kr_gpio_out, for rmw ops */
+	/* kr_revision value (also see ipath_majrev) */
+	uint64_t ipath_revision;
+	/* shadow of ibcctrl, for interrupt handling of link changes, etc. */
+	uint64_t ipath_ibcctrl;
+	/*
+	 * last ibcstatus, to suppress "duplicate" status change messages,
+	 * mostly from 2 to 3
+	 */
+	uint64_t ipath_lastibcstat;
+	/* mask of hardware errors that are enabled */
+	uint64_t ipath_hwerrmask;
+	uint64_t ipath_extctrl;		/* shadow the gpio output contents */
+
+	/* these are the "32 bit" regs */
+	/*
+	 * number of GUIDs in the flash for this interface; may need some
+	 * rethinking for setting on other ifaces
+	 */
+	uint32_t ipath_nguid;
+	uint32_t ipath_rcvctrl;	/* shadow kr_rcvctrl */
+	uint32_t ipath_sendctrl;	/* shadow kr_sendctrl */
+	uint32_t ipath_rcvhdrcnt;	/* value we put in kr_rcvhdrcnt */
+	uint32_t ipath_rcvhdrsize;	/* value we put in kr_rcvhdrsize */
+	uint32_t ipath_rcvhdrentsize;	/* value we put in kr_rcvhdrentsize */
+	/* byte offset of last entry in rcvhdrq */
+	uint32_t ipath_hdrqlast;
+	uint32_t ipath_portcnt;	/* kr_portcnt value */
+	uint32_t ipath_palign;	/* kr_pagealign value */
+	uint32_t ipath_piobcnt;	/* kr_sendpiobufcnt value */
+	uint32_t ipath_piobufbase;	/* kr_sendpiobufbase value */
+	uint32_t ipath_piosize;	/* kr_sendpiosize */
+	uint32_t ipath_rcvegrbase;	/* kr_rcvegrbase value */
+	uint32_t ipath_rcvegrcnt;	/* kr_rcvegrcnt value */
+	uint32_t ipath_rcvtidbase;	/* kr_rcvtidbase value */
+	uint32_t ipath_rcvtidcnt;	/* kr_rcvtidcnt value */
+	uint32_t ipath_sregbase;	/* kr_sendregbase */
+	uint32_t ipath_uregbase;	/* kr_userregbase */
+	uint32_t ipath_cregbase;	/* kr_counterregbase */
+	uint32_t ipath_control;	/* shadow the control register contents */
+	uint32_t ipath_pcirev;	/* PCI revision register (HTC rev on FPGA) */
+
+	uint32_t ipath_ibmtu;	/* The MTU programmed for this unit */
+	/*
+	 * The max size IB packet, included IB headers that we can send.
+	 * Starts same as ipath_piosize, but is affected when ibmtu is
+	 * changed, or by size of eager buffers
+	 */
+	uint32_t ipath_ibmaxlen;
+	/*
+	 * ibmaxlen at init time, limited by chip and by receive buffer size.
+	 * Not changed after init.
+	 */
+	uint32_t ipath_init_ibmaxlen;
+	/* size we allocate for each rcvegrbuffer */
+	uint32_t ipath_rcvegrbufsize;
+	uint32_t ipath_htwidth;	/* width (2,4,8,16,32) from HT config reg */
+	uint32_t ipath_htspeed;	/* HT speed (200,400,800,1000) from HT config */
+	/* bitmap of ports waiting for PIO avail intr */
+	uint32_t ipath_portpiowait;
+	/*
+	 *number of sequential ibcstatus change for polling active/quiet
+	 * (i.e., link not coming up).
+	 */
+	uint32_t ipath_ibpollcnt;
+	uint16_t ipath_mlid;	/* MLID programmed for this instance */
+	uint16_t ipath_lid;	/* LID programmed for this instance */
+	/* list of pkeys programmed; 0 means not set */
+	uint16_t ipath_pkeys[4];
+	uint8_t ipath_serial[12];	/* ASCII serial number, from flash */
+	uint8_t ipath_majrev;	/* chip major rev, from ipath_revision */
+	uint8_t ipath_minrev;	/* chip minor rev, from ipath_revision */
+	uint8_t ipath_boardrev;	/* board rev, from ipath_revision */
+	uint8_t ipath_unit;	/* Unit number for this chip */
+};
+
+/*
+ * A segment is a linear region of low physical memory.
+ * XXX Maybe we should use phys addr here and kmap()/kunmap()
+ * Used by the verbs layer.
+ */
+struct ipath_seg {
+	void *vaddr;
+	size_t length;
+};
+
+/* The number of ipath_segs that fit in a page. */
+#define IPATH_SEGSZ     (PAGE_SIZE / sizeof (struct ipath_seg))
+
+struct ipath_segarray {
+	struct ipath_seg segs[IPATH_SEGSZ];
+};
+
+/*
+ * Used by the verbs layer.
+ */
+struct ipath_mregion {
+	uint64_t user_base;		/* User's address for this region */
+	uint64_t iova;		/* IB start address of this region */
+	size_t length;
+	uint32_t lkey;
+	uint32_t offset;		/* offset (bytes) to start of region */
+	int access_flags;
+	uint32_t max_segs;		/* number of ipath_segs in all the arrays */
+	uint32_t mapsz;		/* size of the map array */
+	struct ipath_segarray *map[0];	/* the segments */
+};
+
+/*
+ * These keep track of the copy progress within a memory region.
+ * Used by the verbs layer.
+ */
+struct ipath_sge {
+	struct ipath_mregion *mr;
+	void *vaddr;		/* current pointer into the segment */
+	uint32_t sge_length;		/* length of the SGE */
+	uint32_t length;		/* remaining length of the segment */
+	uint16_t m;			/* current index: mr->map[m] */
+	uint16_t n;			/* current index: mr->map[m]->segs[n] */
+};
+
+struct ipath_sge_state {
+	struct ipath_sge *sg_list;	/* next SGE to be used if any */
+	struct ipath_sge sge;	/* progress state for the current SGE */
+	uint8_t num_sge;
+};
+
+extern struct ipath_devdata devdata[];
+#define IPATH_UNIT(p) ((p)-devdata)
+extern const uint32_t infinipath_max;	/* number of units (chips) supported */
+extern const char *ipath_minor_names[];
+
+extern int ipath_diags_enabled;	/* is diags mode enabled? */
+
+/* clean up any per-chip chip-specific stuff */
+void ipath_chip_cleanup(struct ipath_devdata *);
+void ipath_chip_done(void);	/* clean up any chip type-specific stuff */
+void ipath_handle_hwerrors(const ipath_type, char *, int);
+int ipath_validate_rev(struct ipath_devdata *);
+void ipath_clear_init_hwerrs(const ipath_type);
+
+/*
+ * This is here to simplify compatibility with source that supports
+ * multiple chip types
+ */
+void ipath_ht_get_boardname(const ipath_type t, char *name, size_t namelen);
+
+/* these are primarily for SMA, but are also used by diags */
+int ipath_send_smapkt(struct ipath_sendpkt __user *);
+
+int ipath_wait_linkstate(const ipath_type, uint32_t, int);
+void ipath_down_link(const ipath_type);
+void ipath_set_ib_lstate(const ipath_type, int);
+void ipath_kreceive(const ipath_type);
+int ipath_setrcvhdrsize(const ipath_type, unsigned);
+
+/* for use in system calls, where we want to know device type, etc. */
+#define port_fp(fp) (((fp)->private_data>(void*)255UL)?((struct ipath_portdata *)fp->private_data):NULL)
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
+/* The link is down (or not yet up 0x11 or earlier) */
+#define IPATH_LINKDOWN      0x40
+#define IPATH_LINKINIT      0x80	/* The link level is up (0x11) */
+/* The link is in the armed (0x21) state */
+#define IPATH_LINKARMED     0x100
+/* The link is in the active (0x31) state */
+#define IPATH_LINKACTIVE    0x200
+/* The link was taken down, but no interrupt yet */
+#define IPATH_LINKUNK       0x400
+/* link being moved to armed (0x21) state */
+#define IPATH_LINK_TOARMED  0x800
+/* link being moved to active (0x31) state */
+#define IPATH_LINK_TOACTIVE 0x1000
+/* linkinit cmd is SLEEP, move to POLL */
+#define IPATH_LINK_SLEEPING 0x2000
+/* no IB cable, or no device on IB cable */
+#define IPATH_NOCABLE       0x4000
+/* Supports port zero per packet receive interrupts via GPIO */
+#define IPATH_GPIO_INTR     0x8000
+
+/* portdata flag values */
+#define IPATH_PORT_WAITING_RCV   0x4	/* waiting for a packet to arrive */
+/* waiting for a PIO buffer to be available */
+#define IPATH_PORT_WAITING_PIO   0x8
+
+int ipath_init_chip(const ipath_type);
+/* free up any allocated data at closes */
+void ipath_free_data(struct ipath_portdata *dd);
+void ipath_init_picotime(void);	/* init cycles to picosecs conversion */
+int ipath_bringup_serdes(const ipath_type);
+int ipath_waitfor_mdio_cmdready(const ipath_type);
+int ipath_waitfor_complete(const ipath_type, ipath_kreg, uint64_t, uint64_t *);
+void ipath_quiet_serdes(const ipath_type);
+void ipath_get_boardname(uint8_t, char *, size_t);
+uint32_t __iomem *ipath_getpiobuf(int, uint32_t *);
+int ipath_bufavail(int);
+int ipath_rd_eeprom(const ipath_type port_unit,
+		    struct ipath_eeprom_req __user *);
+uint64_t ipath_snap_cntr(const ipath_type, ipath_creg);
+
+/*
+ * these should be somewhat dynamic someday, although they are fixed
+ * for all users of the device on any given load.
+ */
+/* (words) room for all IB headers and KD proto header */
+#define IPATH_RCVHDRENTSIZE 16
+/*
+ * 64K, which is about all you can hope to get contiguous.  API allows
+ * users to request a size, for now I'm ignoring that.
+ */
+#define IPATH_RCVHDRCNT 1024
+
+/*
+ * number of words in KD protocol header if not set by ipath_userinit();
+ * this uses the full 64 bytes of rcvhdrentry
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
+#define IPATH_MDIO_REQ(cmd,dev,reg,data) ( (((uint64_t)IPATH_MDIO_CLD_DIV) << 32) | \
+        ((cmd) << 26) | ((dev)<<21) | ((reg) << 16) | ((data) & 0xFFFF))
+
+#define IPATH_MDIO_CTRL_XGXS_REG_8  0x8	/* signal and fifo status, in bank 31 */
+
+/* controls loopback, redundancy */
+#define IPATH_MDIO_CTRL_8355_REG_1  0x10
+#define IPATH_MDIO_CTRL_8355_REG_2  0x11	/* premph, encdec, etc. */
+#define IPATH_MDIO_CTRL_8355_REG_6  0x15	/* Kchars, etc. */
+#define IPATH_MDIO_CTRL_8355_REG_9  0x18
+#define IPATH_MDIO_CTRL_8355_REG_10 0x1D
+
+/*
+ * ipath_get_upages() is used to pin an address range (if not already pinned),
+ * and optionally return the list of physical addresses
+ * ipath_putpages() does the obvious, and ipath_get_upages() cleans up all
+ * private memory, used at driver unload.
+ * ipath_get_upages_nocopy() is similar to ipage_get_upages, but only 1 page,
+ * and marks the vm so the page isn't taken away on a fork.
+ */
+int ipath_get_upages(unsigned long, size_t, struct page **);
+int ipath_get_upages_nocopy(unsigned long, struct page **);
+void ipath_putpages(size_t, struct page **);
+void ipath_upages_cleanup(struct ipath_portdata *);
+int ipath_eeprom_read(const ipath_type, uint8_t, void *, int);
+int ipath_eeprom_write(const ipath_type, uint8_t, void *, int);
+
+/* these are used for the registers that vary with port */
+void ipath_kput_kreg_port(const ipath_type, ipath_kreg, unsigned, uint64_t);
+uint64_t ipath_kget_kreg64_port(const ipath_type, ipath_kreg, unsigned);
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
+ * At the moment, none of the s-registers are writable, so no ipath_kput_sreg()
+ * At the moment, none of the c-registers are writable, so no ipath_kput_creg()
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
+static inline uint32_t ipath_kget_ureg32(const ipath_type stype,
+					 ipath_ureg regno, int port)
+{
+	if (!devdata[stype].ipath_kregbase)
+		return 0;
+
+	return readl(regno + (uint64_t __iomem *)
+		     (devdata[stype].ipath_uregbase +
+		      (char __iomem *) devdata[stype].ipath_kregbase +
+		      devdata[stype].ipath_palign * port));
+}
+
+/*
+ * change the contents of a register that is virtualized to be per port
+ * prints a debug message and returns 1 on errors, 0 on success.
+ */
+static inline void ipath_kput_ureg(const ipath_type stype, ipath_ureg regno,
+				   uint64_t value, int port)
+{
+	uint64_t __iomem *ubase;
+
+	ubase = (uint64_t __iomem *)
+		(devdata[stype].ipath_uregbase +
+		 (char __iomem *) devdata[stype].ipath_kregbase +
+		 devdata[stype].ipath_palign * port);
+	if(devdata[stype].ipath_kregbase)
+		writeq(value, &ubase[regno]);
+}
+
+static inline uint32_t ipath_kget_kreg32(const ipath_type stype,
+					 ipath_kreg regno)
+{
+	if (!devdata[stype].ipath_kregbase)
+		return -1;
+	return readl((uint32_t __iomem *) &devdata[stype].ipath_kregbase[regno]);
+}
+
+static inline uint64_t ipath_kget_kreg64(const ipath_type stype,
+					 ipath_kreg regno)
+{
+	if (!devdata[stype].ipath_kregbase)
+		return -1;
+
+	return readq(&devdata[stype].ipath_kregbase[regno]);
+}
+
+static inline void ipath_kput_kreg(const ipath_type stype,
+				   ipath_kreg regno, uint64_t value)
+{
+	if (devdata[stype].ipath_kregbase)
+		writeq(value, &devdata[stype].ipath_kregbase[regno]);
+}
+
+static inline uint32_t ipath_kget_creg32(const ipath_type stype,
+					ipath_sreg regno)
+{
+	if(!devdata[stype].ipath_kregbase)
+		return 0;
+	return readl(regno + (uint64_t __iomem *)
+		     (devdata[stype].ipath_cregbase +
+		      (char __iomem *) devdata[stype].ipath_kregbase));
+}
+
+/*
+ * caddr is the destination chip address (full pointer, not offset),
+ * val is the qword to write there.  We only handle a single qword (8 bytes).
+ * This is not used for copies to the PIO buffer, just TID updates, etc.
+ * This function localizes all chip mem (as opposed to register) writes.
+ */
+static inline void ipath_kput_memq(const ipath_type stype,
+				   uint64_t __iomem *caddr, uint64_t val)
+{
+	if (devdata[stype].ipath_kregbase)
+		writeq(val, caddr);
+}
+
+
+#endif				/* _IPATH_KERNEL_H */
diff -r a3a00f637da6 -r 2d9a3f27a10c drivers/infiniband/hw/ipath/ipath_layer.h
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_layer.h	Wed Dec 28 14:19:42 2005 -0800
@@ -0,0 +1,134 @@
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
+ *
+ * Patent licenses, if any, provided herein do not apply to
+ * combinations of this program with other software, or any other
+ * product whatsoever.
+ */
+
+#ifndef _IPATH_LAYER_H
+#define _IPATH_LAYER_H
+
+/*
+ * This header file is for symbols shared between the infinipath driver
+ * and drivers layered upon it (such as ipath).
+ */
+
+struct sk_buff;
+struct ipath_sge_state;
+
+struct ipath_layer_counters {
+	uint64_t	symbol_error_counter;
+	uint64_t	link_error_recovery_counter;
+	uint64_t	link_downed_counter;
+	uint64_t	port_rcv_errors;
+	uint64_t	port_rcv_remphys_errors;
+	uint64_t	port_xmit_discards;
+	uint64_t	port_xmit_data;
+	uint64_t	port_rcv_data;
+	uint64_t	port_xmit_packets;
+	uint64_t	port_rcv_packets;
+};
+
+int ipath_layer_register(const ipath_type device,
+			 int (*l_intr) (const ipath_type, uint32_t),
+			 int (*l_rcv) (const ipath_type, void *,
+				       struct sk_buff *),
+			 uint16_t rcv_opcode,
+			 int (*l_rcv_lid) (const ipath_type, void *),
+			 uint16_t rcv_lid_opcode);
+int ipath_verbs_register(const ipath_type device,
+			 int (*l_piobufavail) (const ipath_type device),
+			 void (*l_rcv) (const ipath_type device,
+					void *rhdr, void *data,
+					uint32_t tlen),
+			 void (*l_timer_cb) (const ipath_type device));
+void ipath_verbs_unregister(const ipath_type device);
+int ipath_layer_open(const ipath_type device, uint32_t * pktmax);
+uint16_t ipath_layer_get_lid(const ipath_type device);
+int ipath_layer_get_mac(const ipath_type device, uint8_t *);
+uint16_t ipath_layer_get_bcast(const ipath_type device);
+int ipath_layer_get_num_of_dev(void);
+int ipath_layer_get_cr_errpkey(const ipath_type device);
+int ipath_kset_linkstate(uint32_t arg);
+int ipath_kset_mtu(uint32_t);
+void ipath_set_sps_lid(const ipath_type, uint32_t);
+void ipath_layer_close(const ipath_type device);
+int ipath_layer_send(const ipath_type device, void *hdr, void *data,
+		     uint32_t datalen);
+int ipath_verbs_send(const ipath_type device, uint32_t hdrwords,
+		     uint32_t *hdr, uint32_t len,
+		     struct ipath_sge_state *ss);
+int ipath_layer_send_skb(struct copy_data_s *cdata);
+void ipath_layer_set_piointbufavail_int(const ipath_type device);
+void ipath_get_boardname(const ipath_type, char *name, size_t namelen);
+void ipath_layer_snapshot_counters(const ipath_type t, uint64_t * swords,
+				  uint64_t * rwords, uint64_t * spkts, uint64_t * rpkts);
+void ipath_layer_get_counters(const ipath_type device,
+			      struct ipath_layer_counters *cntrs);
+void ipath_layer_want_buffer(const ipath_type t);
+int ipath_layer_set_guid(const ipath_type t, uint64_t guid);
+uint64_t ipath_layer_get_guid(const ipath_type t);
+uint32_t ipath_layer_get_nguid(const ipath_type t);
+int ipath_layer_query_device(const ipath_type t, uint32_t * vendor,
+			     uint32_t * boardrev, uint32_t * majrev,
+			     uint32_t * minrev);
+uint32_t ipath_layer_get_flags(const ipath_type t);
+struct device *ipath_layer_get_pcidev(const ipath_type t);
+uint16_t ipath_layer_get_deviceid(const ipath_type t);
+uint64_t ipath_layer_get_lastibcstat(const ipath_type t);
+uint32_t ipath_layer_get_ibmtu(const ipath_type t);
+void ipath_layer_enable_timer(const ipath_type t);
+void ipath_layer_disable_timer(const ipath_type t);
+unsigned ipath_verbs_get_flags(const ipath_type device);
+void ipath_verbs_set_flags(const ipath_type device, unsigned flags);
+unsigned ipath_layer_get_npkeys(const ipath_type device);
+unsigned ipath_layer_get_pkey(const ipath_type device, unsigned index);
+void ipath_layer_get_pkeys(const ipath_type device, uint16_t *pkeys);
+int ipath_layer_set_pkeys(const ipath_type device, uint16_t *pkeys);
+int ipath_layer_get_linkdowndefaultstate(const ipath_type device);
+int ipath_layer_set_linkdowndefaultstate(const ipath_type device, int sleep);
+int ipath_layer_get_phyerrthreshold(const ipath_type device);
+int ipath_layer_set_phyerrthreshold(const ipath_type device, unsigned n);
+int ipath_layer_get_overrunthreshold(const ipath_type device);
+int ipath_layer_set_overrunthreshold(const ipath_type device, unsigned n);
+
+/* ipath_ether interrupt values */
+#define IPATH_LAYER_INT_IF_UP 0x2
+#define IPATH_LAYER_INT_IF_DOWN 0x4
+#define IPATH_LAYER_INT_LID 0x8
+#define IPATH_LAYER_INT_SEND_CONTINUE 0x10
+#define IPATH_LAYER_INT_BCAST 0x40
+
+/* _verbs_layer.l_flags */
+#define IPATH_VERBS_KERNEL_SMA 0x1
+
+#endif				/* _IPATH_LAYER_H */
diff -r a3a00f637da6 -r 2d9a3f27a10c drivers/infiniband/hw/ipath/ipath_registers.h
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_registers.h	Wed Dec 28 14:19:42 2005 -0800
@@ -0,0 +1,355 @@
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
+ *
+ * Patent licenses, if any, provided herein do not apply to
+ * combinations of this program with other software, or any other
+ * product whatsoever.
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
+/* kr_ontrol bits */
+#define INFINIPATH_C_FREEZEMODE 0x00000002
+#define INFINIPATH_C_LINKENABLE 0x00000004
+
+/* kr_sendctrl bits */
+#define INFINIPATH_S_DISARMPIOBUF_SHIFT 16
+#define INFINIPATH_S_ABORT          0x00000001U
+#define INFINIPATH_S_PIOINTBUFAVAIL 0x00000002U
+#define INFINIPATH_S_PIOBUFAVAILUPD 0x00000004U
+#define INFINIPATH_S_PIOENABLE      0x00000008U
+#define INFINIPATH_S_DISARM         0x80000000U
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
+#define INFINIPATH_HWE_HTCMEMPARITYERR_SHIFT 0
+#define INFINIPATH_HWE_TXEMEMPARITYERR_MASK 0xFULL
+#define INFINIPATH_HWE_TXEMEMPARITYERR_SHIFT 40
+#define INFINIPATH_HWE_RXEMEMPARITYERR_MASK 0x7FULL
+#define INFINIPATH_HWE_RXEMEMPARITYERR_SHIFT 44
+#define INFINIPATH_HWE_HTCBUSTREQPARITYERR  0x0000000080000000ULL
+#define INFINIPATH_HWE_HTCBUSTRESPPARITYERR 0x0000000100000000ULL
+#define INFINIPATH_HWE_HTCBUSIREQPARITYERR  0x0000000200000000ULL
+#define INFINIPATH_HWE_RXDSYNCMEMPARITYERR  0x0000000400000000ULL
+#define INFINIPATH_HWE_SERDESPLLFAILED      0x2000000000000000ULL
+#define INFINIPATH_HWE_IBCBUSTOSPCPARITYERR 0x4000000000000000ULL
+#define INFINIPATH_HWE_IBCBUSFRSPCPARITYERR 0x8000000000000000ULL
+
+/* kr_hwdiagctrl bits */
+#define INFINIPATH_DC_FORCEHTCENABLE 0x20
+#define INFINIPATH_DC_FORCEHTCMEMPARITYERR_MASK 0x3FULL
+#define INFINIPATH_DC_FORCEHTCMEMPARITYERR_SHIFT 0
+#define INFINIPATH_DC_FORCETXEMEMPARITYERR_MASK 0xFULL
+#define INFINIPATH_DC_FORCETXEMEMPARITYERR_SHIFT 40
+#define INFINIPATH_DC_FORCERXEMEMPARITYERR_MASK 0x7FULL
+#define INFINIPATH_DC_FORCERXEMEMPARITYERR_SHIFT 44
+#define INFINIPATH_DC_FORCEHTCBUSTREQPARITYERR  0x0000000080000000ULL
+#define INFINIPATH_DC_FORCEHTCBUSTRESPPARITYERR 0x0000000100000000ULL
+#define INFINIPATH_DC_FORCEHTCBUSIREQPARITYERR  0x0000000200000000ULL
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
+/* cycle through TS1/TS2 till OK */
+#define INFINIPATH_IBCC_LINKINITCMD_POLL 2
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
+#define INFINIPATH_EXTC_LEDSECPORTGREENON    0x00000020ULL
+#define INFINIPATH_EXTC_LEDSECPORTYELLOWON   0x00000010ULL
+#define INFINIPATH_EXTC_LEDPRIPORTGREENON    0x00000008ULL
+#define INFINIPATH_EXTC_LEDPRIPORTYELLOWON   0x00000004ULL
+#define INFINIPATH_EXTC_LEDGBLOKGREENON      0x00000002ULL
+#define INFINIPATH_EXTC_LEDGBLERRREDOFF      0x00000001ULL
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
+
+/* kr_xgxsconfig bits */
+#define INFINIPATH_XGXS_RESET          0x7ULL
+#define INFINIPATH_XGXS_MDIOADDR_MASK  0xfULL
+#define INFINIPATH_XGXS_MDIOADDR_SHIFT 4
+
+/* TID entries (memory) */
+#define INFINIPATH_RT_VALID 0x8000000000000000ULL
+#define INFINIPATH_RT_ADDR_MASK 0xFFFFFFFFFFULL
+#define INFINIPATH_RT_ADDR_SHIFT 0
+#define INFINIPATH_RT_BUFSIZE_MASK 0x3FFF
+#define INFINIPATH_RT_BUFSIZE_SHIFT 48
+
+/* mask of defined bits for various registers */
+extern const uint64_t infinipath_c_bitsextant,
+    infinipath_s_bitsextant, infinipath_r_bitsextant,
+    infinipath_i_bitsextant, infinipath_e_bitsextant,
+    infinipath_hwe_bitsextant, infinipath_dc_bitsextant,
+    infinipath_extc_bitsextant, infinipath_mdio_bitsextant,
+    infinipath_ibcs_bitsextant, infinipath_ibcc_bitsextant;
+
+/* masks that are different in different chips */
+extern const uint32_t infinipath_i_rcvavail_mask, infinipath_i_rcvurg_mask;
+extern const uint64_t infinipath_hwe_htcmemparityerr_mask;
+extern const uint64_t infinipath_hwe_spibdcmlockfailed_mask;
+extern const uint64_t infinipath_hwe_sphtdcmlockfailed_mask;
+extern const uint64_t infinipath_hwe_htcdcmlockfailed_mask;
+extern const uint64_t infinipath_hwe_htcdcmlockfailed_shift;
+extern const uint64_t infinipath_hwe_sphtdcmlockfailed_shift;
+extern const uint64_t infinipath_hwe_spibdcmlockfailed_shift;
+
+extern const uint64_t infinipath_hwe_htclnkabyte0crcerr;
+extern const uint64_t infinipath_hwe_htclnkabyte1crcerr;
+extern const uint64_t infinipath_hwe_htclnkbbyte0crcerr;
+extern const uint64_t infinipath_hwe_htclnkbbyte1crcerr;
+
+/*
+ * These are the infinipath general register numbers (not offsets).
+ * The kernel registers are used directly, those beyond the kernel
+ * registers are calculated from one of the base registers.  The use of
+ * an integer type doesn't allow type-checking as thorough as, say,
+ * an enum but allows for better hiding of chip differences.
+ */
+typedef const uint16_t
+	ipath_kreg,	/* kernel-only, infinipath general registers */
+	ipath_creg,	/* kernel-only, infinipath counter registers */
+	ipath_sreg;	/* kernel-only, infinipath send registers */
+
+/*
+ * These are all implemented such that 64 bit accesses work.
+ * Some implement no more than 32 bits.  Because 64 bit reads
+ * require 2 HT cmds on opteron, we access those with 32 bit
+ * reads for efficiency (they are written as 64 bits, since
+ * the extra 32 bits are nearly free on writes, and it slightly reduces
+ * complexity).  The rest are all accessed as 64 bits.
+ */
+extern ipath_kreg
+	/* These are the 32 bit group */
+	kr_control, kr_counterregbase, kr_intmask, kr_intstatus,
+	kr_pagealign, kr_portcnt, kr_rcvtidbase, kr_rcvtidcnt,
+	kr_rcvegrbase, kr_rcvegrcnt, kr_scratch, kr_sendctrl,
+	kr_sendpiobufbase, kr_sendpiobufcnt, kr_sendpiosize,
+	kr_sendregbase, kr_userregbase,
+	/* These are the 64 bit group */
+	kr_debugport, kr_debugportselect, kr_errorclear, kr_errormask,
+	kr_errorstatus, kr_extctrl, kr_extstatus, kr_gpio_clear, kr_gpio_mask,
+	kr_gpio_out, kr_gpio_status, kr_hwdiagctrl, kr_hwerrclear,
+	kr_hwerrmask, kr_hwerrstatus, kr_ibcctrl, kr_ibcstatus, kr_intblocked,
+	kr_intclear, kr_interruptconfig, kr_mdio, kr_partitionkey, kr_rcvbthqp,
+	kr_rcvbufbase, kr_rcvbufsize, kr_rcvctrl, kr_rcvhdrcnt,
+	kr_rcvhdrentsize, kr_rcvhdrsize, kr_rcvintmembase, kr_rcvintmemsize,
+	kr_revision, kr_sendbuffererror, kr_sendbuffererror1,
+	kr_sendbuffererror2, kr_sendbuffererror3, kr_sendpioavailaddr,
+	kr_serdesconfig0, kr_serdesconfig1, kr_serdesstatus, kr_txintmembase,
+	kr_txintmemsize, kr_xgxsconfig,
+	__kr_invalid,	/* a marker for debug, don't use them directly */
+	/* a marker for debug, don't use them directly */
+	__kr_lastvaliddirect,
+	/* use only with ipath_k*_kreg64_port(), not *kreg64() */
+	kr_rcvhdraddr,
+	/* use only with ipath_k*_kreg64_port(), not *kreg64() */
+	kr_rcvhdrtailaddr,
+	/* we define the full set for the diags, the kernel doesn't use them */
+	kr_rcvhdraddr1, kr_rcvhdraddr2, kr_rcvhdraddr3, kr_rcvhdraddr4,
+	kr_rcvhdraddr5, kr_rcvhdraddr6, kr_rcvhdraddr7, kr_rcvhdraddr8,
+	kr_rcvhdrtailaddr1, kr_rcvhdrtailaddr2, kr_rcvhdrtailaddr3,
+	kr_rcvhdrtailaddr4, kr_rcvhdrtailaddr5, kr_rcvhdrtailaddr6,
+	kr_rcvhdrtailaddr7, kr_rcvhdrtailaddr8;
+
+/*
+ * first of the pioavail registers, the total number is
+ * (kr_sendpiobufcnt / 32); each buffer uses 2 bits
+ */
+extern ipath_sreg sr_sendpioavail;
+
+extern ipath_creg cr_badformatcnt, cr_erricrccnt, cr_errlinkcnt,
+	cr_errlpcrccnt, cr_errpkey, cr_errrcvflowctrlcnt,
+	cr_err_rlencnt, cr_errslencnt, cr_errtidfull,
+	cr_errtidvalid, cr_errvcrccnt, cr_ibstatuschange,
+	cr_intcnt, cr_invalidrlencnt, cr_invalidslencnt,
+	cr_lbflowstallcnt, cr_iblinkdowncnt, cr_iblinkerrrecovcnt,
+	cr_ibsymbolerrcnt, cr_pktrcvcnt, cr_pktrcvflowctrlcnt,
+	cr_pktsendcnt, cr_pktsendflowcnt, cr_portovflcnt,
+	cr_portovflcnt1, cr_portovflcnt2, cr_portovflcnt3, cr_portovflcnt4,
+	cr_portovflcnt5, cr_portovflcnt6, cr_portovflcnt7, cr_portovflcnt8,
+	cr_rcvebpcnt, cr_rcvovflcnt, cr_rxdroppktcnt,
+	cr_senddropped, cr_sendstallcnt, cr_sendunderruncnt,
+	cr_unsupvlcnt, cr_wordrcvcnt, cr_wordsendcnt;
+
+/*
+ * register bits for selecting i2c direction and values, used for I2C serial
+ * flash
+ */
+extern const uint16_t ipath_gpio_sda_num;
+extern const uint16_t ipath_gpio_scl_num;
+extern const uint64_t ipath_gpio_sda;
+extern const uint64_t ipath_gpio_scl;
+
+#endif				/* _IPATH_REGISTERS_H */
diff -r a3a00f637da6 -r 2d9a3f27a10c drivers/infiniband/hw/ipath/ips_common.h
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ips_common.h	Wed Dec 28 14:19:42 2005 -0800
@@ -0,0 +1,249 @@
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
+ *
+ * Patent licenses, if any, provided herein do not apply to
+ * combinations of this program with other software, or any other
+ * product whatsoever.
+ */
+
+#include "ipath_common.h"
+
+struct ipath_header_typ {
+	/*
+	 * Version - 4 bits, Port - 4 bits, TID - 10 bits and Offset - 14 bits
+	 * before ECO change ~28 Dec 03.
+	 * After that, Vers 4, Port 3, TID 11, offset 14.
+	 */
+	uint32_t ver_port_tid_offset;
+	uint16_t chksum;
+	uint16_t pkt_flags;
+};
+
+struct ips_message_header_typ {
+	uint16_t lrh[4];
+	uint32_t bth[3];
+	struct ipath_header_typ iph;
+	uint8_t sub_opcode;
+	uint8_t flags;
+	uint16_t src_rank;
+	/* 24 bits. The upper 8 bit is available for other use */
+	union {
+		struct {
+			unsigned ack_seq_num : 24;
+			unsigned port : 4;
+			unsigned unused : 4;
+		};
+		uint32_t ack_seq_num_org;
+	};
+	uint8_t expected_tid_session_id;
+	uint8_t tinylen;	/* to aid MPI */
+	uint16_t tag;		/* to aid MPI */
+	union {
+		uint32_t mpi[4];	/* to aid MPI */
+		uint32_t data[4];
+		struct {
+			uint16_t mtu;
+			uint8_t major_ver;
+			uint8_t minor_ver;
+			uint32_t not_used; //free
+			uint32_t run_id;
+			uint32_t client_ver;
+		};
+	};
+};
+
+struct ether_header_typ {
+	uint16_t lrh[4];
+	uint32_t bth[3];
+	struct ipath_header_typ iph;
+	uint8_t sub_opcode;
+	uint8_t cmd;
+	uint16_t lid;
+	uint16_t mac[3];
+	uint8_t frag_num;
+	uint8_t seq_num;
+	uint32_t len;
+	/* MUST be of word size do to PIO write requirements */
+	uint32_t csum;
+	uint16_t csum_offset;
+	uint16_t flags;
+	uint16_t first_2_bytes;
+	uint8_t unused[2];	/* currently unused */
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
+	struct ether_header_typ *hdr;
+	uint32_t __iomem *csum_pio;	/* addr of PIO buf to write csum to */
+	uint32_t __iomem *to;		/* addr of PIO buf to write data to */
+	uint32_t device;	/* which device to allocate PIO bufs from */
+	int error;		/* set if there is an error. */
+	int extra;		/* amount of data saved in u.buf below */
+	unsigned int len;	/* total length to send in bytes */
+	unsigned int flen;	/* frament length in words */
+	unsigned int csum;	/* partial IP checksum */
+	unsigned int pos;	/* position for partial checksum */
+	unsigned int offset;	/* offset to where data currently starts */
+    int checksum_calc;  /* set to 'true' when the checksum has been calculated */
+	struct sk_buff *skb;
+	union {
+		uint32_t w;
+		uint8_t buf[4];
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
+#define NUM_OF_EKSTRA_WORDS_IN_HEADER_QUEUE ((sizeof(struct ips_message_header_typ) - offsetof(struct ips_message_header_typ, iph)) >> 2)
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
+/* functions for extracting fields from rcvhdrq entries */
+static inline uint32_t ips_get_hdr_err_flags(uint32_t *rbuf)
+{
+	return rbuf[1];
+}
+
+static inline uint32_t ips_get_index(uint32_t *rbuf)
+{
+	return (rbuf[0] >> INFINIPATH_RHF_EGRINDEX_SHIFT)
+		& INFINIPATH_RHF_EGRINDEX_MASK;
+}
+
+static inline uint32_t ips_get_rcv_type(uint32_t *rbuf)
+{
+	return (rbuf[0] >> INFINIPATH_RHF_RCVTYPE_SHIFT)
+		& INFINIPATH_RHF_RCVTYPE_MASK;
+}
+
+static inline uint32_t ips_get_length_in_bytes(uint32_t *rbuf)
+{
+	return ((rbuf[0] >> INFINIPATH_RHF_LENGTH_SHIFT)
+		& INFINIPATH_RHF_LENGTH_MASK) << 2;
+}
+
+static inline void *ips_get_first_protocol_header(uint32_t *rbuf)
+{
+	return (void *)&rbuf[2];
+}
+
+static inline struct ips_message_header_typ *ips_get_ips_header(uint32_t *rbuf)
+{
+	return (struct ips_message_header_typ *)&rbuf[2];
+}
+
+static inline uint32_t ips_get_ipath_ver(uint32_t hdrword)
+{
+	return (hdrword >> INFINIPATH_I_VERS_SHIFT)
+		& INFINIPATH_I_VERS_MASK;
+}
+
+/*
+ * Copy routine that is guaranteed to work in terms of aligned 32-bit
+ * quantities.
+ */
+void ipath_dwordcpy(uint32_t *dest, uint32_t *src, uint32_t ndwords);
+
+#endif /* IPS_COMMON_H */
