Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUHBXms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUHBXms (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 19:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUHBXms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 19:42:48 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:52740 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S264522AbUHBXmV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 19:42:21 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: libata-core, 2.4.27-rc3, and scsi_unregister_module()
Date: Mon, 2 Aug 2004 16:42:18 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B03F9612@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: libata-core, 2.4.27-rc3, and scsi_unregister_module()
Thread-Index: AcR0C1TpQP7X89+/TRuAZWllJhA6jAE3mN/w
From: "Andrew Chew" <achew@nvidia.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>
X-OriginalArrivalTime: 02 Aug 2004 23:42:20.0192 (UTC) FILETIME=[5A106200:01C478EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that in ata_pci_remove_one, that scsi_unregister_module() is
being called for the SCSI host template.  I also noticed that the SATA
drivers are calling scsi_unregister_module() in their cleanup routines
as well.  Is this work-in-progress, or an actual bug?  In any case, the
scsi_unregister_module() call in ata_pci_remove_one() takes an exception
with a NULL sht upon driver unload (when I'm experimenting with the
sata_nv module).  Commenting out the scsi_unregister_module() call in
ata_pci_remove_one() fixes things.
