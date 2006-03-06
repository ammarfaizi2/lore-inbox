Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWCFXIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWCFXIM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 18:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWCFXIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 18:08:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46534 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932430AbWCFXIL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 18:08:11 -0500
Date: Mon, 6 Mar 2006 15:06:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, markhe@nextd.demon.co.uk,
       andrea@suse.de, michaelc@cs.wisc.edu, James.Bottomley@steeleye.com,
       axboe@suse.de, penberg@cs.helsinki.fi
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Message-Id: <20060306150612.51f48efa.akpm@osdl.org>
In-Reply-To: <9a8748490603061501r387291f0ha10e9e9fe3c9e060@mail.gmail.com>
References: <200603060117.16484.jesper.juhl@gmail.com>
	<Pine.LNX.4.64.0603061147260.13139@g5.osdl.org>
	<200603062136.17098.jesper.juhl@gmail.com>
	<9a8748490603061253u5e4d7561vd4e566f5798a5f4@mail.gmail.com>
	<9a8748490603061256h794c5af9wa6fbb616e8ddbd89@mail.gmail.com>
	<Pine.LNX.4.64.0603061306300.13139@g5.osdl.org>
	<9a8748490603061354vaa53c72na161d26065b9302e@mail.gmail.com>
	<Pine.LNX.4.64.0603061402410.13139@g5.osdl.org>
	<Pine.LNX.4.64.0603061423160.13139@g5.osdl.org>
	<Pine.LNX.4.64.0603061445350.13139@g5.osdl.org>
	<9a8748490603061501r387291f0ha10e9e9fe3c9e060@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jesper Juhl" <jesper.juhl@gmail.com> wrote:
>
> And since 2.6.16-rc5-git8 is not experiencing problems I'd suggest you
>  perhaps instead take a look at what's in -mm... That's where we need
>  to work (it seems) to find the bug...

Yes, it's very probably something in git-scsi-misc.

 drivers/block/cciss.c               |    3 
 drivers/message/fusion/Kconfig      |    1 
 drivers/message/fusion/mptbase.c    |   72 -
 drivers/message/fusion/mptbase.h    |   14 
 drivers/message/fusion/mptfc.c      |    4 
 drivers/message/fusion/mptlan.c     |    5 
 drivers/message/fusion/mptsas.c     |  196 ++
 drivers/message/fusion/mptscsih.c   | 2402 +-----------------------------------
 drivers/message/fusion/mptscsih.h   |   11 
 drivers/message/fusion/mptspi.c     |  733 ++++++++++
 drivers/scsi/53c700.c               |   18 
 drivers/scsi/aacraid/aacraid.h      |    5 
 drivers/scsi/aacraid/comminit.c     |    1 
 drivers/scsi/aacraid/commsup.c      |   14 
 drivers/scsi/aacraid/linit.c        |   14 
 drivers/scsi/aha152x.c              |    7 
 drivers/scsi/aic7xxx/aic79xx_core.c |   24 
 drivers/scsi/aic7xxx/aic7xxx_core.c |   24 
 drivers/scsi/aic7xxx/aic7xxx_osm.c  |   45 
 drivers/scsi/aic7xxx/aic7xxx_osm.h  |    5 
 drivers/scsi/hosts.c                |    3 
 drivers/scsi/ipr.c                  |  109 +
 drivers/scsi/ips.c                  |    2 
 drivers/scsi/jazz_esp.c             |   19 
 drivers/scsi/lpfc/lpfc.h            |   40 
 drivers/scsi/lpfc/lpfc_attr.c       |  162 +-
 drivers/scsi/lpfc/lpfc_crtn.h       |   28 
 drivers/scsi/lpfc/lpfc_ct.c         |   74 -
 drivers/scsi/lpfc/lpfc_disc.h       |   19 
 drivers/scsi/lpfc/lpfc_els.c        |  772 +++++++----
 drivers/scsi/lpfc/lpfc_hbadisc.c    |  492 +++----
 drivers/scsi/lpfc/lpfc_hw.h         |   65 
 drivers/scsi/lpfc/lpfc_init.c       |  265 ++-
 drivers/scsi/lpfc/lpfc_mbox.c       |   33 
 drivers/scsi/lpfc/lpfc_nportdisc.c  |  374 +++--
 drivers/scsi/lpfc/lpfc_scsi.c       |   25 
 drivers/scsi/lpfc/lpfc_scsi.h       |    5 
 drivers/scsi/lpfc/lpfc_sli.c        |  385 +++--
 drivers/scsi/lpfc/lpfc_sli.h        |    5 
 drivers/scsi/lpfc/lpfc_version.h    |    6 
 drivers/scsi/ncr53c8xx.c            |  127 -
 drivers/scsi/ncr53c8xx.h            |   37 
 drivers/scsi/osst.c                 |   24 
 drivers/scsi/qla2xxx/qla_def.h      |    6 
 drivers/scsi/qla2xxx/qla_gbl.h      |    2 
 drivers/scsi/qla2xxx/qla_isr.c      |    7 
 drivers/scsi/qla2xxx/qla_mbx.c      |    4 
 drivers/scsi/qla2xxx/qla_os.c       |   89 -
 drivers/scsi/qla2xxx/qla_sup.c      |    4 
 drivers/scsi/scsi.c                 |    6 
 drivers/scsi/scsi_debug.c           |    9 
 drivers/scsi/scsi_ioctl.c           |    3 
 drivers/scsi/scsi_lib.c             |   76 -
 drivers/scsi/scsi_scan.c            |  100 -
 drivers/scsi/scsi_sysfs.c           |    4 
 drivers/scsi/scsi_transport_fc.c    |    9 
 drivers/scsi/scsi_transport_iscsi.c |    3 
 drivers/scsi/scsi_transport_sas.c   |  258 +++
 drivers/scsi/scsi_transport_spi.c   |   83 -
 drivers/scsi/sd.c                   |   11 
 drivers/scsi/sg.c                   |   16 
 drivers/scsi/sr.c                   |    5 
 drivers/scsi/sr_ioctl.c             |    6 
 drivers/scsi/st.c                   |   29 
 drivers/scsi/sym53c8xx_2/sym_hipd.c |   53 
 include/linux/workqueue.h           |    6 
 include/scsi/scsi.h                 |    2 
 include/scsi/scsi_cmnd.h            |   20 
 include/scsi/scsi_device.h          |   16 
 include/scsi/scsi_transport_sas.h   |   22 
 include/scsi/scsi_transport_spi.h   |    4 
 kernel/workqueue.c                  |   29 
 72 files changed, 3444 insertions(+), 4107 deletions(-)

