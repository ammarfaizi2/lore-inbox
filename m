Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWIFTIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWIFTIN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 15:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWIFTIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 15:08:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:44417 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1751243AbWIFTIK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 15:08:10 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,221,1154934000"; 
   d="scan'208"; a="121969504:sNHT5262535208"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: one more ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
Date: Wed, 6 Sep 2006 11:59:47 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4E38B52@orsmsx415.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: one more ACPI Error (utglobal-0125): Unknown exception code: 0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
Thread-Index: AcbR4Obxbw0L1mAyR6qbmhg9YiUU8gABa4FA
From: "Moore, Robert" <robert.moore@intel.com>
To: <kmannth@us.ibm.com>, "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Cc: "Len Brown" <lenb@kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>,
       "Mattia Dongili" <malattia@linux.it>, "Andrew Morton" <akpm@osdl.org>,
       "lkml" <linux-kernel@vger.kernel.org>,
       "linux acpi" <linux-acpi@vger.kernel.org>,
       "KAMEZAWA Hiroyuki" <kamezawa.hiroyu@jp.fujitsu.com>
X-OriginalArrivalTime: 06 Sep 2006 18:59:48.0707 (UTC) FILETIME=[A033CB30:01C6D1E6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From one of the ACPI guys:

> Get hid
> Look for driver
> If you find a match, load it
> If no match, get CID
> Look for driver
> If you find a match, load it
> If you did not find an hid or cid match, punt



> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of keith mannthey
> Sent: Wednesday, September 06, 2006 11:14 AM
> To: Bjorn Helgaas
> Cc: Len Brown; Moore, Robert; Li, Shaohua; Mattia Dongili; Andrew
Morton;
> lkml; linux acpi; KAMEZAWA Hiroyuki
> Subject: Re: one more ACPI Error (utglobal-0125): Unknown exception
code:
> 0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
> 
> On Fri, 2006-09-01 at 17:20 -0600, Bjorn Helgaas wrote:
> > On Friday 01 September 2006 17:01, keith mannthey wrote:
> > > On Thu, 2006-08-31 at 21:15 -0600, Bjorn Helgaas wrote:
> > > > The current ACPI driver binding algorithm in
acpi_bus_find_driver()
> > > > looks at each driver, checking whether it can match either the
_HID
> > > > or the _CID of a device.  Since we try the motherboard driver
first,
> > > > it matches the memory device _CID.
> > >
> > > Ok I reverted the motherboard driver patch and cooked up the
following
> > > patch that works for my issue.
> > >
> > >   It creates the idea that acpi_match_ids has a type of request to
> check
> > > against for _HID, _CID or both.  See acpi_bus_match_req. I then
fix up
> > > all the needed callers to change the API to acpi_match_ids and
> > > acpi_bus_match and have callers can say what they want to match
> > > against.
> > >
> > >   Then in acpi_bus_find_driver I have it do 2 passes to search for
> _HID
> > > first then the _CID.
> > >
> > > Does this look like it is in the right ballpark or should we be
doing
> > > something else?  Built/tested against 2.6.18-rc4-mm3.
> >
> > Conceptually I like this much better than mucking with the
motherboard
> > driver.  I'm not sure the important people have signed off on this
> > strategy of binding with _HID first, then _CID (hi, Len :-))  Maybe
> > there are ramifications that we need to consider.  But I think it
> > is a better match for "what people expect should happen."
> 
> ACPI folks can we get some response to this?  This problem has been
> reported a few times against the -mm tree and I would like to get the
> proper fix (whatever it is) upstream sometime soon.
> 
> Bjorn thanks for the help and for pointing the error reports in the
> right direction.
> 
> Thanks,
>   Keith
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
