Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbULHSnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbULHSnD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 13:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbULHSmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 13:42:47 -0500
Received: from magic.adaptec.com ([216.52.22.17]:5584 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S261306AbULHSme convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 13:42:34 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: How to add/drop SCSI drives from within the driver?
Date: Wed, 8 Dec 2004 13:42:06 -0500
Message-ID: <60807403EABEB443939A5A7AA8A7458B7F5071@otce2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to add/drop SCSI drives from within the driver?
Thread-Index: AcTdPwvp7EMdGbbgRP2AM/ae8X8FaQAFcVhw
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "James Bottomley" <James.Bottomley@SteelEye.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "Matt Domsch" <Matt_Domsch@Dell.com>, <brking@us.ibm.com>,
       <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
       <bunk@fs.tum.de>, "Andrew Morton" <akpm@osdl.org>,
       "Ju, Seokmann" <sju@lsil.com>, "Doelfel, Hardy" <hdoelfel@lsil.com>,
       "Mukker, Atul" <Atulm@lsil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley writes:
> On Wed, 2004-12-08 at 01:16, Bagalkote, Sreenivas wrote:
>> Adding a drive:- For application to use sysfs to scan newly added
drive,
>> it needs to know the HCTL (SCSI address - Host, Channel, Target &
Lun)
>> of the drive. Driver is the only one that knows the mapping between a

>> drive and the corresponding HCTL.
>The real way I'd like to handle this is via hotplug.  The hotplug event
>would transmit the HCTL in the environment.  Whether the drive actually
>gets incorporated into the system and where is user policy, so it's
>appropriate that it should be in userland.

The problem is the aac based cards generate events (AIFs) that are
picked up by the driver. To go all the way to userland to interpret
these events and back to the driver is a waste and a source of failures.
Only the Firmware knows when an array zeroing has completed in order to
bring the device online.

>This same infrastructure could be used by fibre channel login, scsi
>enclosure events etc.

I would need to emulate an SES to propagate array changes?

>We have some of the hotplug infrastructure in SCSI, but not quite
enough
>for this ... you'll need an additional API.

What was wrong with scsi_scan_single_target (add), scsi_rescan_device
(remove/change)?

Sincerely -- Mark Salyzyn
