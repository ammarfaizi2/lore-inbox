Return-Path: <linux-kernel-owner+w=401wt.eu-S932596AbXAGQEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbXAGQEM (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 11:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbXAGQEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 11:04:12 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:54658 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932589AbXAGQEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 11:04:11 -0500
Subject: [GIT PATCH] scsi bug fixes for 2.6.20-rc4
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Date: Sun, 07 Jan 2007 10:04:03 -0600
Message-Id: <1168185843.2792.76.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is mainly bug fixes, although there are a few harmless updates
(like email addresses and driver PCI IDs).  The patch is available here:

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6

The Short Changelog is:

adam radford (1):
       3ware 8000 serialize reset code

Adrian Bunk (1):
       qla2xxx: make qla2x00_reg_remote_port() static

Akinobu Mita (1):
       iscsi: fix crypto_alloc_hash() error check

Andrew Vasquez (9):
       qla2xxx: Update version number to 8.01.07-k4.
       qla2xxx: Use generic isp_ops.fw_dump() function.
       qla2xxx: Perform a fw-dump when an ISP23xx RISC-paused state is detected.
       qla2xxx: Correct reset handling logic.
       qla2xxx: Correct IOCB queueing mechanism for ISP54XX HBAs.
       qla2xxx: Detect GPSC capabilities within a fabric.
       qla2xxx: Use proper prep_ms_iocb() function during GFPN_ID.
       qla2xxx: Correct endianess issue while interrogating MS status.
       qla2xxx: Don't log trace-control async-events.

Arne Redlich (1):
       iscsi: fix 2.6.19 data digest calculation bug

Eric Moore (4):
       fusion: bump version
       fusion: MODULE_VERSION support
       fusion: power pc and miscellaneous bug fixs
       fusion: fibre channel: return DID_ERROR for MPI_IOCSTATUS_SCSI_IOC_TERMINATED

FUJITA Tomonori (1):
       iscsi: simplify IPv6 and IPv4 address printing

James Bottomley (3):
       scsi_scan: fix report lun problems with CDROM or RBC devices
       seagate: remove BROKEN tag
       scsi_transport_spi: fix sense buffer size error

Jes Sorensen (1):
       qla1280: set residual correctly

Mariusz Kozlowski (1):
       scsi: lpfc error path fix

Matthew Wilcox (1):
       Add missing completion to scsi_complete_async_scans()

Meelis Roos (1):
       iscsi: newline in printk

Mike Christie (1):
       libiscsi: fix senselen calculation

Randy Dunlap (1):
       advansys: wrap PCI table inside ifdef CONFIG_PCI

Salyzyn, Mark (1):
       aacraid: Product List Update

Sumant Patro (1):
       megaraid_sas: Update module author

Tejun Heo (1):
       sr: fix error code check in sr_block_ioctl()


and the diffstat:

 Documentation/scsi/aacraid.txt       |   66 +++++++++++++++++-------------
 drivers/message/fusion/mptbase.c     |    3 -
 drivers/message/fusion/mptbase.h     |   10 ++--
 drivers/message/fusion/mptctl.c      |    5 +-
 drivers/message/fusion/mptctl.h      |    2 
 drivers/message/fusion/mptfc.c       |    3 -
 drivers/message/fusion/mptlan.c      |    4 +
 drivers/message/fusion/mptlan.h      |    2 
 drivers/message/fusion/mptsas.c      |   38 +++++++++--------
 drivers/message/fusion/mptscsih.c    |   19 +++++++-
 drivers/message/fusion/mptscsih.h    |    2 
 drivers/message/fusion/mptspi.c      |    3 -
 drivers/scsi/3w-xxxx.c               |   60 +++++++++++++--------------
 drivers/scsi/3w-xxxx.h               |    2 
 drivers/scsi/Kconfig                 |    2 
 drivers/scsi/aacraid/linit.c         |   20 ++++-----
 drivers/scsi/advansys.c              |    3 -
 drivers/scsi/iscsi_tcp.c             |   12 ++---
 drivers/scsi/libiscsi.c              |    6 +-
 drivers/scsi/lpfc/lpfc_mem.c         |    6 ++
 drivers/scsi/megaraid/megaraid_sas.c |    6 +-
 drivers/scsi/qla1280.c               |    6 +-
 drivers/scsi/qla2xxx/qla_def.h       |    2 
 drivers/scsi/qla2xxx/qla_gbl.h       |    1 
 drivers/scsi/qla2xxx/qla_gs.c        |   24 ++++++++---
 drivers/scsi/qla2xxx/qla_init.c      |   76 +++++++++++++++++------------------
 drivers/scsi/qla2xxx/qla_isr.c       |   15 ++++--
 drivers/scsi/qla2xxx/qla_mbx.c       |   12 ++---
 drivers/scsi/qla2xxx/qla_os.c        |   59 ++++++++++++++-------------
 drivers/scsi/qla2xxx/qla_version.h   |    2 
 drivers/scsi/scsi_scan.c             |   33 +++++++++++----
 drivers/scsi/scsi_transport_iscsi.c  |    2 
 drivers/scsi/scsi_transport_spi.c    |    2 
 drivers/scsi/seagate.c               |    5 +-
 drivers/scsi/sr.c                    |    2 
 35 files changed, 296 insertions(+), 219 deletions(-)

James


