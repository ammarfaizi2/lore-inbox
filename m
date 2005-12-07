Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030387AbVLGV6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030387AbVLGV6i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 16:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030384AbVLGV6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 16:58:38 -0500
Received: from fmr17.intel.com ([134.134.136.16]:44689 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030383AbVLGV6h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 16:58:37 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC]add ACPI hooks for IDE suspend/resume
Date: Thu, 8 Dec 2005 05:58:14 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F101082713@pdsmsx406>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC]add ACPI hooks for IDE suspend/resume
thread-index: AcX7Yozn0OS5rWtWS+SjMYbrjv+TAwAFl0dA
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>,
       "linux-ide" <linux-ide@vger.kernel.org>,
       "lkml" <linux-kernel@vger.kernel.org>, "pavel" <pavel@ucw.cz>,
       "Brown, Len" <len.brown@intel.com>, "akpm" <akpm@osdl.org>
X-OriginalArrivalTime: 07 Dec 2005 21:58:15.0949 (UTC) FILETIME=[537183D0:01C5FB79]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
>
>On 12/7/05, Shaohua Li <shaohua.li@intel.com> wrote:
>> On Wed, 2005-12-07 at 16:49 +0100, Bartlomiej Zolnierkiewicz wrote:
>> > On 12/7/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> > > On Mer, 2005-12-07 at 15:45 +0100, Bartlomiej Zolnierkiewicz
wrote:
>> > > > OK, I understand it now - when using 'ide-generic' host driver
for
>IDE
>> > > > PCI device, resume fails (for obvious reason - IDE PCI device
is
>not
>> > > > re-configured) and this patch fixes it through using ACPI
methods.
>> >
>> > I was talking about bugzilla bug #5604.
>> Sorry for my ignorance in IDE side. From the ACPI spec, there isn't a
>> generic way to save/restore IDE's configuration. That's why ACPI
>> provides such methods. I suppose all IDE drivers need call the
methods,
>> wrong?
>
>From the hardware POV:
>* there is generic way to save/restores IDE device's configuration
>* there is no generic way to save/restore IDE controller's
configuration
>
>From the software POV what we only do currently is setting controller
>and drive for a correct transfer mode by using host driver specific
>callback
>(in case of using 'ide-generic' there is no such callback).
>
>> > > Even in the piix case some devices need it because the bios wants
to
>> > > issue commands such as password control if the laptop is set up
in
>> > > secure modes.
>> >
>> > I completely agree.  However at the moment this patch doesn't seem
>> > to issue any ATA commands (code is commented out in _GTF) so
>> > this is not a case for bugzilla bug #5604.
>> I actually tried to invoke ATA commands using IDE APIs, but can't
find
>> any available one. I'd be very happy if you can give me any hint how
to
>> do it or even you can fix it.
>
>Probably do_rw_taskfile() is the method you want to use, you also need
>to place invoking of ACPI provided ATA commands in the right place in
>the IDE PM state machine [ ide_{start,complete}_power_step() ].
>
>PS1 Please don't use taskfile_lib_get_identify(), drive->id
>should contain valid ID - if it doesn't it is a BUG.
>
>PS2 Have you seen libata ACPI patches by Randy?
>Maybe some of the code dealing with ACPI can be put to
><linux/ata.h> and be shared between IDE and libata drivers?
Thanks a lot! I'll try your suggestions after my travel. Hopefully I can
understand the IDE staffs you mentioned then :).

Thanks,
Shaohua
