Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbWJYXNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbWJYXNb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 19:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030178AbWJYXNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 19:13:31 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:55781 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1030190AbWJYXNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 19:13:30 -0400
Subject: Re: [GIT PATCH] SCSI fixes for 2.6.19-rc3
From: James Bottomley <James.Bottomley@SteelEye.com>
To: adam radford <aradford@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
In-Reply-To: <1161813563.3816.29.camel@mulgrave.il.steeleye.com>
References: <1161792760.3816.6.camel@mulgrave.il.steeleye.com>
	 <b1bc6a000610251449j34e5226crc606a1759b6aca19@mail.gmail.com>
	 <1161813563.3816.29.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain; charset=utf-8
Date: Wed, 25 Oct 2006 16:13:22 -0700
Message-Id: <1161818002.3816.32.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-25 at 14:59 -0700, James Bottomley wrote:
> On Wed, 2006-10-25 at 14:49 -0700, adam radford wrote:
> > I NACK'd this patch in an earlier email and CC'd you on it:
> 
> Oh ... oops ... I didn't notice.
> 
> I'll redo the rc-fixes tree since Linus hasn't yet merged it.

OK, this is all redone at 

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6.git

The short changelog is:

Adrian Bunk:
  o aic79xx: make ahd_set_tags() static
  o aic7xxx: cleanups

Alan Cox:
  o Switch fdomain to the pci_get API

Alexey Dobriyan:
  o scsi_lib.c: use BUILD_BUG_ON

Amol Lad:
  o drivers/scsi: Handcrafted MIN/MAX macro removal

Andrew Vasquez:
  o qla2xxx: Update version number to 8.01.07-k3
  o qla2xxx: Correct QUEUE_FULL handling
  o qla2xxx: Workaround D3 power-management issues
  o qla2xxx: Check return value of sysfs_create_bin_file() usage
  o Maintain module-parameter name consistency with qla2xxx/qla4xxx

Andrey Mirkin:
  o megaraid_{mm,mbox}: 64-bit DMA capability fix

Doug Maxey:
  o qla4xxx: fix double printk on load

Eric Sesterhenn:
  o lpfc: check before dereference in lpfc_ct.c

Guennadi Liakhovetski:
  o tmscsim: set max_sectors

Hannes Reinecke:
  o aic79xx: Print out signalling
  o aic7xxx: Remove slave_destroy
  o aic79xx: set precompensation
  o aic79xx: Fixup external device reset
  o scsi_debug: support REPORT TARGET PORT GROUPS
  o aic7xxx: Adjust .max_sectors

Henne:
  o fix typo in previous Scsi_Cmnd convertion in aic7xxx_old.c
  o Scsi_Cmnd conversion in qlogicfas408 driver
  o Scsi_Cmnd convertion in sun3-driver

Henrik Kretzschmar:
  o fc4: Conversion to struct scsi_cmnd in fc4
  o convert ninja driver to struct scsi_cmnd
  o Scsi_Cmnd conversion in psi240i driver

James Bottomley:
  o add can_queue to host parameters

Jes Sorensen:
  o qla1280 bus reset typo

Kai M�isara:
  o st: Fixup -ENOMEDIUM

Michael Reed:
  o mptfc: stall eh handlers if resetting while rport blocked

Mike Christie:
  o libiscsi: fix logout pdu processing
  o libiscsi: fix aen support
  o libiscsi: fix missed iscsi_task_put in xmit error path
  o libiscsi: fix oops in connection create failure path
  o iscsi class: fix slab corruption during restart

Randy Dunlap:
  o lpfc: fix printk format warning

Santiago Leon:
  o ibmvscsi: correctly reenable CRQ

Sergey Kononenko:
  o aic94xx: Supermicro motherboards support

Swen Schillig:
  o zfcp: initialize scsi_host_template.max_sectors with appropriate value

Tomonori FUJITA:
  o replace u8 and u32 with __u8 and __u32 in scsi.h for user space


And the diffstat

 drivers/fc4/fc.c                       |   28 +-
 drivers/fc4/fcp_impl.h                 |   15 -
 drivers/message/fusion/mptbase.h       |    4 
 drivers/message/fusion/mptfc.c         |   89 ++++++++
 drivers/s390/scsi/zfcp_def.h           |    4 
 drivers/s390/scsi/zfcp_scsi.c          |    1 
 drivers/scsi/aic7xxx/aic79xx.h         |   66 ------
 drivers/scsi/aic7xxx/aic79xx_core.c    |  350 +++++++++++++++++++++------------
 drivers/scsi/aic7xxx/aic79xx_inline.h  |   30 --
 drivers/scsi/aic7xxx/aic79xx_osm.c     |   45 +++-
 drivers/scsi/aic7xxx/aic79xx_osm.h     |    5 
 drivers/scsi/aic7xxx/aic79xx_osm_pci.c |    2 
 drivers/scsi/aic7xxx/aic79xx_pci.c     |    7 
 drivers/scsi/aic7xxx/aic79xx_proc.c    |    2 
 drivers/scsi/aic7xxx/aic7xxx.h         |   11 -
 drivers/scsi/aic7xxx/aic7xxx_core.c    |   40 +--
 drivers/scsi/aic7xxx/aic7xxx_osm.c     |   72 +-----
 drivers/scsi/aic7xxx/aic7xxx_osm.h     |   13 -
 drivers/scsi/aic7xxx/aic7xxx_osm_pci.c |    2 
 drivers/scsi/aic7xxx/aic7xxx_pci.c     |    4 
 drivers/scsi/aic7xxx/aic7xxx_proc.c    |   10 
 drivers/scsi/aic7xxx_old.c             |    2 
 drivers/scsi/aic94xx/aic94xx_hwi.h     |    1 
 drivers/scsi/aic94xx/aic94xx_init.c    |    2 
 drivers/scsi/aic94xx/aic94xx_sds.c     |    4 
 drivers/scsi/fdomain.c                 |   30 +-
 drivers/scsi/ibmvscsi/ibmvscsi.c       |    2 
 drivers/scsi/libiscsi.c                |   69 +++---
 drivers/scsi/lpfc/lpfc_attr.c          |    3 
 drivers/scsi/lpfc/lpfc_ct.c            |    3 
 drivers/scsi/megaraid/megaraid_mbox.c  |    2 
 drivers/scsi/pcmcia/nsp_cs.c           |   42 ++-
 drivers/scsi/pcmcia/nsp_cs.h           |   46 ++--
 drivers/scsi/pcmcia/nsp_debug.c        |    4 
 drivers/scsi/pcmcia/nsp_message.c      |    4 
 drivers/scsi/psi240i.c                 |   31 +-
 drivers/scsi/psi240i.h                 |    6 
 drivers/scsi/qla1280.c                 |    7 
 drivers/scsi/qla2xxx/qla_attr.c        |   51 +++-
 drivers/scsi/qla2xxx/qla_dbg.h         |   14 -
 drivers/scsi/qla2xxx/qla_def.h         |    4 
 drivers/scsi/qla2xxx/qla_gbl.h         |    4 
 drivers/scsi/qla2xxx/qla_init.c        |   23 ++
 drivers/scsi/qla2xxx/qla_isr.c         |   91 +++++++-
 drivers/scsi/qla2xxx/qla_os.c          |   35 ++-
 drivers/scsi/qla2xxx/qla_version.h     |    2 
 drivers/scsi/qla4xxx/ql4_dbg.h         |    4 
 drivers/scsi/qla4xxx/ql4_glbl.h        |    2 
 drivers/scsi/qla4xxx/ql4_mbx.c         |    2 
 drivers/scsi/qla4xxx/ql4_os.c          |   10 
 drivers/scsi/qlogicfas408.c            |   18 -
 drivers/scsi/qlogicfas408.h            |   29 +-
 drivers/scsi/scsi_debug.c              |  141 +++++++++++--
 drivers/scsi/scsi_lib.c                |    2 
 drivers/scsi/scsi_sysfs.c              |    2 
 drivers/scsi/scsi_transport_iscsi.c    |  246 +----------------------
 drivers/scsi/st.c                      |    5 
 drivers/scsi/sun3_NCR5380.c            |  109 +++++-----
 drivers/scsi/sun3_scsi.c               |    7 
 drivers/scsi/sun3_scsi.h               |    7 
 drivers/scsi/sun3_scsi_vme.c           |    7 
 drivers/scsi/tmscsim.c                 |    1 
 include/scsi/libiscsi.h                |    3 
 include/scsi/scsi.h                    |    5 
 include/scsi/scsi_transport_iscsi.h    |    4 
 65 files changed, 1011 insertions(+), 875 deletions(-)

James


