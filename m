Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVACXOI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVACXOI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 18:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVACXLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:11:35 -0500
Received: from mail0.lsil.com ([147.145.40.20]:440 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261920AbVACXKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:10:25 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230CACD@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'Matt Domsch'" <Matt_Domsch@dell.com>,
       James Bottomley <James.Bottomley@SteelEye.com>
Cc: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>, brking@us.ibm.com,
       linux-kernel@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, bunk@fs.tum.de,
       Andrew Morton <akpm@osdl.org>, "Ju, Seokmann" <sju@lsil.com>,
       "Doelfel, Hardy" <hdoelfel@lsil.com>, "Mukker, Atul" <Atulm@lsil.com>
Subject: RE: How to add/drop SCSI drives from within the driver?
Date: Mon, 3 Jan 2005 18:02:20 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I am trying to stoke this thread once more. Please review the brief summary
of all discussion and a new sysfs based proposal.

o    The more ideal and long-term way to handle addition and removal of
devices is through hotplug mechanism. Currently it is not fully developed.
Moreover, the megaraid SCSI driver doesn't get any event notification from
the FW that the configuration has been changed.

o    Management App that communicates to FW via driver private ioctls is the
one that creates/modifies the configuration. This is transparent to the
driver.

o    Logical drives being "logical", the driver exports the logical drives
on virtual
SCSI addresses. The management app that knows about LD0, LD1 .. LDn, does
not know the LDn to HCTL mapping (Host:Channel:Target:Lun)

o    Everybody understands that as long as the SCSI scan/rescan is triggered
by 
the management app, there is no getting around knowing HCTL mapping. The app
must know the HCTL quad of a logical drive.

o    Our original solution was that the driver returns HCTL of a LD via
ioctl. This
has been squarely rejected because kernel cannot add any more private
ioctls.

Considering that the app has to somehow _know_ the HCTL given a logical
drive
(that it has deleted or will be adding), please provide your feedback on the
following
proposal. I know that it is not radically different.

The driver would create nodes for all possible logical drives.

/sys/modules
 |-- megaraid_mbox
 |   |-- LD0
 |   |-- LD1
 |   |-- LD2
 |   |-- LD(i)
 |   |-- LD40

One of the attributes of a LD node would be HCTL information. A management
app
can then scan, delete the LDs using corresponding HCTL address.

Y'all have a great new year!

Sreenivas
LSI Logic
