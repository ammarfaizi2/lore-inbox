Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbVAYS5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVAYS5I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 13:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVAYS45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 13:56:57 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:38096 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261729AbVAYS4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 13:56:24 -0500
Subject: [BK PATCH] SCSI updates for 2.6.11-rc2
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 12:56:05 -0600
Message-Id: <1106679365.6434.45.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is mostly simple updates.  There is one new feature: the move over
to generic transport classes.  This doesn't impact anything other than
SCSI (although the idea is that it will in future) but it does introduce
new abstractions in drivers/base (which I got Greg's sign off on).

The patch is available from:

bk://linux-scsi.bkbits.net/scsi-for-linus-2.6

The short changelog is:

<mark_salyzyn:adaptec.com>:
  o dpt_i2o: remove schedule_timeout()

Adrian Bunk:
  o SCSI NCR_Q720.c: make some code static

Alan Stern:
  o Fix reference to deallocated memory in sd.c

Andi Kleen:
  o Add compat_ioctl to scsi host structure

Christoph Hellwig:
  o osst: don't use obsolete SCSI APIs
  o cosmetic jazz_esp updates
  o update dec_esp with changes from mips CVS
  o update mips driver Kconfig bits

Domen Puncer:
  o delete unused file dpt_osdutil.h

Douglas Gilbert:
  o sd descriptor sense support
  o streamline block SG_IO error processing in sd
  o streamline block SG_IO error processing
  o sense data helpers lk 2.6.11-rc1-bk1
  o sg descriptor sense cleanup lk 2.6.11-rc1-bk1
  o scsi_debug dsense

Geert Uytterhoeven:
  o SCSI NCR53C9x.c: some cleanups

James Bottomley:
  o SCSI: Fix style nitpicks
  o move the SCSI transport classes over to the generic transport class
  o add a generic device transport class
  o Add attribute container to generic device model
  o fix use after potential free in scsi_cd_put

Mark Haverkamp:
  o aacraid 2.6: add scsi synchronize cache support

and the diffstat:

 b/drivers/base/Makefile               |    3 
 b/drivers/base/attribute_container.c  |  274 +++++++++++++++++++++++
 b/drivers/base/init.c                 |    3 
 b/drivers/base/transport_class.c      |  272 +++++++++++++++++++++++
 b/drivers/scsi/Kconfig                |    4 
 b/drivers/scsi/NCR53C9x.c             |    4 
 b/drivers/scsi/NCR53C9x.h             |    2 
 b/drivers/scsi/NCR_Q720.c             |    4 
 b/drivers/scsi/aacraid/aachba.c       |  113 +++++++++
 b/drivers/scsi/aacraid/aacraid.h      |   24 ++
 b/drivers/scsi/dec_esp.c              |  396 +++++++++++++++++-----------------
 b/drivers/scsi/dpt_i2o.c              |    1 
 b/drivers/scsi/hosts.c                |   21 -
 b/drivers/scsi/jazz_esp.c             |   49 ++--
 b/drivers/scsi/oktagon_esp.c          |    2 
 b/drivers/scsi/osst.c                 |  198 ++++++++---------
 b/drivers/scsi/osst.h                 |    4 
 b/drivers/scsi/scsi_debug.c           |    6 
 b/drivers/scsi/scsi_error.c           |   93 +++++++
 b/drivers/scsi/scsi_lib.c             |  108 ++++-----
 b/drivers/scsi/scsi_priv.h            |    2 
 b/drivers/scsi/scsi_scan.c            |   24 --
 b/drivers/scsi/scsi_sysfs.c           |  131 ++---------
 b/drivers/scsi/scsi_transport_fc.c    |  112 +++++----
 b/drivers/scsi/scsi_transport_iscsi.c |   85 ++++---
 b/drivers/scsi/scsi_transport_spi.c   |  139 +++++++----
 b/drivers/scsi/sd.c                   |  169 ++++++++------
 b/drivers/scsi/sg.c                   |   30 +-
 b/drivers/scsi/sr.c                   |    4 
 b/include/linux/attribute_container.h |   61 +++++
 b/include/linux/transport_class.h     |   77 ++++++
 b/include/scsi/scsi_device.h          |    9 
 b/include/scsi/scsi_eh.h              |    6 
 b/include/scsi/scsi_host.h            |   19 +
 b/include/scsi/scsi_transport.h       |   33 --
 b/include/scsi/scsi_transport_spi.h   |    1 
 drivers/scsi/dpt/dpt_osdutil.h        |  358 ------------------------------
 37 files changed, 1729 insertions(+), 1112 deletions(-)

James

