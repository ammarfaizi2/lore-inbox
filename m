Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266173AbUI0GXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266173AbUI0GXr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 02:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266181AbUI0GXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 02:23:47 -0400
Received: from fmr05.intel.com ([134.134.136.6]:3024 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S266173AbUI0GXp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 02:23:45 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: suspend/resume support for driver requires an external firmware
Date: Mon, 27 Sep 2004 14:23:35 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD305753457F2@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: suspend/resume support for driver requires an external firmware
Thread-Index: AcSiNAK1VRp8i1DnThKkovYWxZUSyACJTZig
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Oliver Neukum" <oliver@neukum.org>
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Patrick Mochel" <mochel@digitalimplant.org>,
       "Zhu, Yi" <yi.zhu@intel.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Sep 2004 06:23:38.0364 (UTC) FILETIME=[867E1BC0:01C4A45A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I somewhat think choice 2 is better. The pre-load can be invoked in
any
>> order instead of in the device tree hierarchy order. And currently
only
>> few devices need it, is it worth adding it in the device core?
>
>If order doesn't matter, the device tree order is as good as any
>other order.
>
>> In addition, the notifiers have better flexibility. We can easily add
>> more notifier types if needed, such as adding a callback between the
>> sysdev resume and regular devices resume. To tell the truth, we
actually
>> have the case. An ACPI link device must resume before regular devices
>> but must be with IRQ enabled. I'm considering add a call back between
>> sysdev and regular devices resume for the issue. I guess the MTRR
driver
>> in SMP has the same requirement. Anyway, notifier solution sounds
like
>> easier to extend, but we can't extend device core casually.
>
>If you add this stuff to anything but the device core, you have to
teach
>the drivers about the various notifier chains. Why would adding methods
>to the device core be harder than adding notifier chains? If drivers do
>not need the method they don't need to implement it. If they do need
>it, using a notifier chain isn't easier.
Adding methods to the device core requires changes the device core every
time when you add a new call back. The notifier chain method can keep
the device core stable.
Considering another case, we might want to add some call backs between
sysdevs resume and regular devices resume (the case is the above). It
might not be for a device. How can the device core call back do this? 

Thanks,
Shaohua
