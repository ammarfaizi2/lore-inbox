Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVFNWhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVFNWhn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 18:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVFNWhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 18:37:42 -0400
Received: from fmr13.intel.com ([192.55.52.67]:56011 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S261383AbVFNWhK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 18:37:10 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: Fwd: hpet patches
Date: Tue, 14 Jun 2005 15:37:09 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6004F782CB@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Fwd: hpet patches
Thread-Index: AcVxKzBYrWms1/ptS92Rg12syP4QRwABZBPg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Jon Smirl" <jonsmirl@gmail.com>, "Bob Picco" <bob.picco@hp.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "lkml" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Jun 2005 22:36:26.0425 (UTC) FILETIME=[7FF86A90:01C57131]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Jon Smirl [mailto:jonsmirl@gmail.com] 
>Sent: Tuesday, June 14, 2005 2:51 PM
>To: Bob Picco
>Cc: Pallipadi, Venkatesh; Andrew Morton; lkml
>Subject: Re: Fwd: hpet patches
>
>On 6/14/05, Bob Picco <bob.picco@hp.com> wrote:
>> Jon Smirl wrote:        [Tue Jun 14 2005, 01:50:49PM EDT]
>> > Problem like this are usually fixed with quirks:
>> >
>> > DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,
>> > PCI_DEVICE_ID_INTEL_82801EB_0,  quirk_intel_ich5_hpet);
>> >
>> > quirk_intel_ich5_hpet()
>> > {
>> >     if (!hpet_address)
>> >           hpet_address = 0xfed00000ULL;
>> > }
>> >
>> > 0xfed00000ULL is right for ICH5, do you want to start 
>adding these as
>> > part of HPET support? My hpet works fine once the address 
>is set. For
>> > complete coverage you need a list of these for all of the AMD/Intel
>> > chipsets with hpet support. The list isn't very big.
>> >
>> Well my ignorance is going to show here.  The platform 
>initialization code
>> has already run and PCI probing happens later.  How do you 
>reconcile Venki's
>> concern for an HPET armed for legacy support when platform
>> is already using PIT?  Also the hpet driver isn't a PCI driver but
>> ACPI driver.  It's working for you so I'm obviously missing a detail.
>
>You don't actually use the PCI_FIXUP macros. You make a new one called
>ACPI_FIXUP and run them right after ACPI is read and before you do
>anything else. I was just illustrating how the quirk fixup system
>worked.
>
>To make it work on my system I just added an assignment statement for
>the fix right after the ACPI code looked for the HPET entry. But
>that's not a general solution, building the ACPI_FIXUP macros is one.
>

OK. I was thinking PCI fixup is to late in the initialization for 
HPET fixup. But, we should be OK with a new ACPI_FIXUP macro. My only
other concern is, we should safely fallback to PIT, when our fixed_up 
HPET address isn't right.

Thanks,
Venki

