Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWJAT7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWJAT7n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 15:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWJAT7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 15:59:43 -0400
Received: from havoc.gtf.org ([69.61.125.42]:24196 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932254AbWJAT7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 15:59:42 -0400
Date: Sun, 1 Oct 2006 15:59:41 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [doc] Full audit of 'make allmodconfig' uninit warnings
Message-ID: <20061001195941.GA17762@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, done with the first pass on x86_64.  I break down each and every
uninit warning.  There were more Real Bugs than I would have guessed.

There are three categories:

1) gcc bugs, and things highly difficult for the compiler to figure out.
2) confirmed kernel bugs.  already created patches for several of these.
3) other stuff.  explanations inline.


1) COMPILER ANALYSIS DIFFICULTIES AND BUGS
------------------------------------------
arch/x86_64/kernel/../../i386/kernel/microcode.c:387: warning: ‘new_mc’ may be used uninitialized in this function
drivers/ata/pata_artop.c:429: warning: ‘info’ may be used uninitialized in this function
drivers/infiniband/hw/mthca/mthca_qp.c:1529: warning: ‘f0’ may be used uninitialized in this function
drivers/infiniband/hw/mthca/mthca_qp.c:1872: warning: ‘f0’ may be used uninitialized in this function
drivers/net/r8169.c:2221: warning: ‘txd’ may be used uninitialized in this function
drivers/net/wan/sbni.c:598: warning: ‘framelen’ may be used uninitialized in this function
drivers/usb/misc/auerswald.c:667: warning: ‘length’ may be used uninitialized in this function
drivers/usb/net/kaweth.c:1213: warning: ‘length’ may be used uninitialized in this function
drivers/video/matrox/matroxfb_maven.c:287: warning: ‘p’ may be used uninitialized in this function
drivers/video/matrox/matroxfb_maven.c:718: warning: ‘a’ may be used uninitialized in this function
drivers/video/matrox/matroxfb_maven.c:718: warning: ‘b’ may be used uninitialized in this function
drivers/video/matrox/matroxfb_maven.c:718: warning: ‘h2’ may be used uninitialized in this function
fs/bio.c:169: warning: ‘idx’ may be used uninitialized in this function
fs/eventpoll.c:500: warning: ‘fd’ may be used uninitialized in this function
fs/jfs/jfs_txnmgr.c:1922: warning: ‘pxd.addr1’ may be used uninitialized in this function
fs/jfs/jfs_txnmgr.c:1922: warning: ‘pxd.addr2’ may be used uninitialized in this function
fs/jfs/jfs_txnmgr.c:1922: warning: ‘pxd.len’ may be used uninitialized in this function
ipc/msg.c:341: warning: ‘setbuf.gid’ may be used uninitialized in this function
ipc/msg.c:341: warning: ‘setbuf.mode’ may be used uninitialized in this function
ipc/msg.c:341: warning: ‘setbuf.qbytes’ may be used uninitialized in this function
ipc/msg.c:341: warning: ‘setbuf.uid’ may be used uninitialized in this function
ipc/sem.c:809: warning: ‘setbuf.gid’ may be used uninitialized in this function
ipc/sem.c:809: warning: ‘setbuf.mode’ may be used uninitialized in this function
ipc/sem.c:809: warning: ‘setbuf.uid’ may be used uninitialized in this function
fs/ocfs2/dlm/dlmdomain.c:918: warning: ‘response’ may be used uninitialized in this function
fs/ocfs2/vote.c:667: warning: ‘response’ may be used uninitialized in this function
fs/udf/balloc.c:751: warning: ‘goal_eloc.logicalBlockNum’ may be used uninitialized in this function
fs/udf/super.c:1363: warning: ‘ino.partitionReferenceNum’ may be used uninitialized in this function
kernel/auditfilter.c:1164: warning: ‘ndp’ may be used uninitialized in this function
kernel/auditfilter.c:1164: warning: ‘ndw’ may be used uninitialized in this function
kernel/auditfilter.c:1599: warning: ‘state’ may be used uninitialized in this function
sound/pci/pcxhr/pcxhr.c:640: warning: ‘stream’ may be used uninitialized in this function

2) KERNEL BUGS
--------------
drivers/ata/pata_atiixp.c:118: warning: ‘wanted_pio’ may be used uninitialized in this function
	--> Needs BUG() to be marked 'noreturn'
drivers/atm/ambassador.c:1049: warning: ‘tx_rate_bits’ may be used uninitialized in this function
drivers/atm/firestream.c:870: warning: ‘tmc0’ may be used uninitialized in this function
drivers/atm/zatm.c:919: warning: ‘pcr’ may be used uninitialized in this function
	--> ATM bug descriptions on LKML
drivers/char/ipmi/ipmi_si_intf.c:1733: warning: ‘data.irq’ may be used uninitialized in this function
	--> Patch sent to LKML
drivers/net/wan/pc300_drv.c:2870: warning: ‘br’ may be used uninitialized in this function
	--> Description sent to LKML, netdev, maintainer
drivers/scsi/ips.c:7123: warning: ‘index’ may be used uninitialized in this function
	--> Description sent to LKML, linux-scsi
drivers/video/aty/aty128fb.c:1511: warning: ‘pll.post_divider’ may be used uninitialized in this function
	--> Might be OK, might need to return an error.  Prefer the latter.
drivers/video/riva/riva_hw.c:1241: warning: ‘m’ may be used uninitialized in this function
drivers/video/riva/riva_hw.c:1241: warning: ‘n’ may be used uninitialized in this function
drivers/video/riva/riva_hw.c:1241: warning: ‘p’ may be used uninitialized in this function
drivers/video/riva/riva_hw.c:1241: warning: ‘VClk’ may be used uninitialized in this function
	--> Unhandled error return... but error propagation is difficult.


3) MISCELLANEOUS
----------------
drivers/telephony/ixj.c:3448: warning: ‘blankword.high’ may be used uninitialized in this function
drivers/telephony/ixj.c:3448: warning: ‘blankword.low’ may be used uninitialized in this function
drivers/telephony/ixj.c:4847: warning: ‘bytes.high’ may be used uninitialized in this function

	--> Difficult to answer without knowning the hardware well,
	    or doing a _really_ deep analysis.


fs/jffs2/readinode.c:664: warning: ‘fd_list’ may be used uninitialized in this function
fs/jffs2/readinode.c:667: warning: ‘latest_mctime’ may be used uninitialized in this function

	--> Code makes my fscking eyes bleed.  Gave up.



net/ipv4/tcp_input.c:2262: warning: ‘tv.tv_sec’ may be used uninitialized in this function
net/ipv4/tcp_input.c:2262: warning: ‘tv.tv_usec’ may be used uninitialized in this function

	--> Difficult to analyze.  Requires knowing about flags and
	    conditions that occur in other parts of the code.

