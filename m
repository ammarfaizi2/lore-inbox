Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbVBASRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVBASRx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 13:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVBASQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 13:16:01 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:5858 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262093AbVBASOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 13:14:37 -0500
Subject: [BK PATCH] Critical SCSI fixes for 2.6.11-rc2
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 12:14:21 -0600
Message-Id: <1107281661.4800.32.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following regression tests on BK latest, two critical problems have
turned up in the SCSI subsystem:

1) Hang using REQ_BLOCK_PC on CD/DVD
2) oops in transport classes with multiple HBAs

Could we do a quick include of this tree:

bk://linux-scsi.bkbits.net/scsi-for-linus-2.6

to pick up fixes for them?  Everything else in this tree is also a
regression bugfix (except the addition of the qla maintainer, which is a
documentation bugfix)

The tree contains:

Andrew Vasquez:
  o MAINTAINERS: add entry for qla2xxx driver

Douglas Gilbert:
  o fix scsi cdrom problem

James Bottomley:
  o Fix missed class_remove_file in attribute_container
  o SCSI: fix multiple HBA problem with transport classes
  o SCSI Fix oops with faulty DVD

Randy Dunlap:
  o gdth: fix module_param() type for 'irq'

and the diffstat is:

 MAINTAINERS                         |    6 ++
 drivers/base/attribute_container.c  |  108 +++++++++++++++++++++++++++++++++++-
 drivers/base/transport_class.c      |   25 +-------
 drivers/scsi/gdth.c                 |    2 
 drivers/scsi/scsi_lib.c             |   10 +--
 drivers/scsi/scsi_transport_fc.c    |   12 +++-
 drivers/scsi/scsi_transport_iscsi.c |   12 +++-
 drivers/scsi/scsi_transport_spi.c   |   15 ++++-
 drivers/scsi/sr.c                   |    1 
 include/linux/attribute_container.h |   12 ++++
 10 files changed, 166 insertions(+), 37 deletions(-)

James


