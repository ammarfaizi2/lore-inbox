Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262951AbUEWRRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbUEWRRy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 13:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263182AbUEWRRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 13:17:54 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:9687 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262574AbUEWRRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 13:17:42 -0400
Subject: [BK PATCH] SCSI bug fixes for 2.6.6
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 23 May 2004 12:17:36 -0500
Message-Id: <1085332657.1763.5.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After the early round of SCSI patches, these are the assorted fixups and
driver updates.

The patch is available at

bk://linux-scsi.bkbits.net/scsi-for-linus-2.6

The short Change Log is:


<g.liakhovetski:gmx.de>:
  o tmscsim: trivial updates
  o tmscsim: remove legacy and void code
  o tmscsim: no internal queue
  o tmscsim: 64-bit cleanup

Achim Leubner:
  o gdth driver update to 3.04

Alan Cox:
  o initial 2.6 fixup for ATP870U scsi
  o Do something about aacraid

Andrew Morton:
  o qlogicfas408.c warning fix

Brian King:
  o ipr driver version 2.0.7
  o ipr remove anonymous unions for gcc 2.95
  o ipr fix for ioa reset timeout oops
  o ipr add error logs to abort and reset paths
  o ipr gcc attributes fixes
  o Make st support the scsi_device timeout

Christoph Hellwig:
  o remove an unused function from NC53c406a
  o tmscsim: remove procfs write support from tmscsim
  o fix assorted wd7000 warnings

Douglas Gilbert:
  o st.c for GET_IDLUN

Go Taniguchi:
  o Fix dpt_i2o

Heiko Carstens:
  o SCSI: fix Stack overflow when lldd returns SCSI_MLQUEUE_DEVICE_BUSY

James Bottomley:
  o SCSI: make inquiry timeout tuneable
  o SCSI: make SCSI REPORT LUNS the default
  o SCSI: deprecate BLIST_FORCELUN
  o SCSI: logging optimisation
  o scsi sg: fix smp_call_function() with intrs disabled
  o Fix SCSI device state model

Rusty Russell:
  o [TRIVIAL 2.6] drivers_scsi_nsp32.c: kill duplicate

This time, the diffstat is reasonable (no qlogic firmware):

 drivers/scsi/Kconfig            |   17 
 drivers/scsi/NCR53c406a.c       |    3 
 drivers/scsi/aacraid/README     |    8 
 drivers/scsi/aacraid/aacraid.h  |  157 --
 drivers/scsi/aacraid/commctrl.c |   37 
 drivers/scsi/aacraid/comminit.c |    9 
 drivers/scsi/aacraid/commsup.c  |   81 -
 drivers/scsi/aacraid/dpcsup.c   |   53 
 drivers/scsi/aacraid/sa.c       |    5 
 drivers/scsi/atp870u.c          |   40 
 drivers/scsi/dc390.h            |   12 
 drivers/scsi/dpt_i2o.c          |  156 +-
 drivers/scsi/dpti.h             |    4 
 drivers/scsi/gdth.c             | 3112
++++++++++++++++++++++------------------
 drivers/scsi/gdth.h             |  157 +-
 drivers/scsi/gdth_ioctl.h       |   50 
 drivers/scsi/gdth_proc.c        | 1591 ++++++--------------
 drivers/scsi/gdth_proc.h        |   29 
 drivers/scsi/ipr.c              |  131 -
 drivers/scsi/ipr.h              |   29 
 drivers/scsi/nsp32.c            |    1 
 drivers/scsi/qlogicfas408.c     |    2 
 drivers/scsi/qlogicfas408.h     |    2 
 drivers/scsi/scsi_lib.c         |    4 
 drivers/scsi/scsi_logging.h     |    2 
 drivers/scsi/scsi_scan.c        |   39 
 drivers/scsi/scsiiom.c          |   45 
 drivers/scsi/sg.c               |  153 -
 drivers/scsi/st.c               |   54 
 drivers/scsi/st.h               |    1 
 drivers/scsi/tmscsim.c          |  954 +-----------
 drivers/scsi/tmscsim.h          |   23 
 drivers/scsi/wd7000.c           |    7 
 include/scsi/scsi_devinfo.h     |    6 
 34 files changed, 3091 insertions(+), 3883 deletions(-)

James


