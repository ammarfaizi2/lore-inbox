Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266116AbUJOD70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbUJOD70 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 23:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266137AbUJOD70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 23:59:26 -0400
Received: from havoc.gtf.org ([69.28.190.101]:40852 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266127AbUJOD7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 23:59:16 -0400
Date: Thu, 14 Oct 2004 23:58:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [SATA] libata queue updated
Message-ID: <20041015035853.GA29321@havoc.gtf.org>
Reply-To: linux-ide@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the current batch of SATA changes I have waiting for Linus
and Marcelo.  There are a bunch more goodies in the experimental
"libata-dev" queue, which I will cover in another email.

BK users:

	bk pull bk://gkernel.bkbits.net/libata-2.6
		or
	bk pull bk://gkernel.bkbits.net/libata-2.4

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.4.28-pre4-bk2-libata1.patch.bz2
	or
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.9-rc4-libata1.patch.bz2


SATA status reports, FAQs, and such:

	http://linux.yyz.us/sata/


This will update the following files:

 drivers/scsi/Kconfig       |    8 +
 drivers/scsi/Makefile      |    1 
 drivers/scsi/ata_piix.c    |   20 +--
 drivers/scsi/libata-core.c |    8 +
 drivers/scsi/sata_nv.c     |   38 +++---
 drivers/scsi/sata_uli.c    |  282 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |    2 
 7 files changed, 330 insertions(+), 29 deletions(-)

through these ChangeSets:

<bzolnier@elka.pw.edu.pl> (04/10/11 1.2165)
   [PATCH] libata: PCI IDE legacy mode fix
   
   In PCI IDE legacy mode ap->port_no is incorrectly set to zero for
   the second port.  Fix it by adding ->hard_port_no to struct ata_probe_ent
   and struct ata_port (per Jeff's suggestion) and teaching ata_piix.c
   to use it instead of ->port_no.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

<romieu@fr.zoreil.com> (04/09/30 1.2009.4.5)
   [PATCH] sata_nv: housekeeping for goto labels
   
   - each label used in a goto contains a part of the operation that must
     be issued. This way both the no-error and the error paths can be checked
     separately;
   - probe_ent does not need to be NULL-initialized.
   
   Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

<romieu@fr.zoreil.com> (04/09/30 1.2009.4.4)
   [PATCH] sata_nv: wrong failure path and leak
   
   - wrong branching: the driver does not want to iounmap() an address that it
     has just failed to set;
   - return a sensible error status code instead of a success code;
   - leak plugged: host was never freed if a late error heppened.
   
   Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

<romieu@fr.zoreil.com> (04/09/30 1.2009.4.3)
   [PATCH] sata_nv: enable hotplug event on successfull init only
   
   Wait for successfull completion of nv_init_one() before hotplug events
   are enabled.
   
   Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

<jgarzik@pobox.com> (04/09/30 1.2009.4.2)
   [libata sata_uli] add dev_select hook

<jgarzik@pobox.com> (04/09/30 1.2009.4.1)
   [libata] add sata_uli driver for ULi (formerly ALi) SATA
   
   Contributed by Peer Chen <peer_chen@ali.com.tw>, updated to
   latest libata by me.

