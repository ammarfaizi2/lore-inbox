Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbUAOTGH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 14:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbUAOTGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 14:06:07 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:22400 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id S261950AbUAOTGE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 14:06:04 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: iswraid calling modprobe when scsi statically compiled?
Date: Thu, 15 Jan 2004 12:05:50 -0700
Message-ID: <933D2981B35C9B4B8793B56C4AE9E16B593A8F@azsmsx405.ch.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: iswraid calling modprobe when scsi statically compiled?
Thread-Index: AcPbk2D8qMGzkQQyQWewdYIgYF96IwABjX+Q
From: "Kannanthanam, Boji T" <boji.t.kannanthanam@intel.com>
To: "Sergey Vlasov" <vsu@altlinux.ru>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 15 Jan 2004 19:05:50.0806 (UTC) FILETIME=[9766F760:01C3DB9A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> The problem is in the initialization ordering. iswraid must initialize
> after SCSI, but it is located in the IDE drivers directory, and
> therefore is initialized before SCSI. So it won't work when built into
> the kernel.
> 
> If you build iswraid as module and load it from initrd (after the SCSI
> subsystem is initialized and raw drives are detected), it should work.
> 

As pointed this in an unfortunate side effect of the nature of driver
dependency: iswraid (in ataraid/IDE subsystem) depending on ata_piix (in
SCSI). The above solution will solve the issue. 

But can anyone shed some light on resolving this issue other than
compiling the driver as kernel module ?
i.e is there a way I can change the order of driver initialization in
the kernel ? Load SCSI subsystem before IDE ? 

Thanks,
boji
