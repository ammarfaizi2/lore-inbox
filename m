Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVCWUlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVCWUlD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 15:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVCWUiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 15:38:08 -0500
Received: from mailhub.lss.emc.com ([168.159.2.31]:6552 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S261268AbVCWUgj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 15:36:39 -0500
From: Brett Russ <russb@emc.com>
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH libata-dev-2.6 00/03] libata: scsi error handling improvements
Message-ID: <20050323203514.D62A1893@lns1032.lss.emc.com>
References: <20050317221753.0D09D0D9@lns1032.lss.emc.com> <4240FAB9.5040200@pobox.com>
In-Reply-To: <4240FAB9.5040200@pobox.com>
Date: Wed, 23 Mar 2005 15:36:29 -0500 (EST)
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.0.3.0, Antispam-Data: 2005.3.23.11
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='__CT 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are a resubmit of patch 5/5 of the first series
submitted 2005-03-17.  Jeff requested that the single patch be split
into a suggested 3 smaller patches; the results are below.  I also
took this opportunity to further clean up the changes.

[ Start of patch descriptions ]

01_libata_libata-whitespace.patch
	: whitespace updates

	This patch adjusts some whitespace to bring the format of
	libata-scsi.c to a consistent state.

02_libata_ata_dump_status.patch
	: create/use ata_dump_status()

	This patch introduces the ata_dump_status() function, which
	for now is called from ata_to_sense_error() only.

03_libata_rework-cc-generation.patch
	: rework check condition handling

	This patch refactors the check condition creation within
	libata.  Changes include:

	- ata_to_sense_error() now *only* performs the translation
          from an ATA status/error register combination to a SCSI
          SK/ASC/ASCQ combination.  Additionally, the translation is
          logged at level KERNEL_ERR and any untranslatable combos are
          logged at level KERNEL_WARNING.

	- ata_dump_status() is modified to take a taskfile struct as
          argument in preparation for a future patch which will add
          proper display of the failing location (LBA or CHS)

	- created ata_gen_fixed_sense() to generate a fixed length CC
          sense block.

	- ata_pass_thru_cc() has been renamed to
          ata_gen_ata_desc_sense() to fit the naming convention
          mentioned above.  Its guts were changed a bit as well.

	- ata_scsi_qc_complete() has been modified to fix a bug where
          ATA_12/16 commands would not generate a sense block on
          error.  Other changes made here as well, including the call
          to ata_dump_status().

[ End of patch descriptions ]

