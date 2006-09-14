Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbWINDCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWINDCN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 23:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWINDCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 23:02:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:47779 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751056AbWINDCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 23:02:11 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,161,1157353200"; 
   d="scan'208"; a="130102644:sNHT186572960"
Subject: Re: one more ACPI Error (utglobal-0125): Unknown exception 
	code:0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
From: Shaohua Li <shaohua.li@intel.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: kmannth@us.ibm.com, "Moore, Robert" <robert.moore@intel.com>,
       Len Brown <lenb@kernel.org>, Mattia Dongili <malattia@linux.it>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       linux acpi <linux-acpi@vger.kernel.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <200609130851.16028.bjorn.helgaas@hp.com>
References: <B28E9812BAF6E2498B7EC5C427F293A4E38B52@orsmsx415.amr.corp.intel.com>
	 <4132.24.9.204.52.1157682479.squirrel@mail.cce.hp.com>
	 <1158110859.6047.27.camel@keithlap>
	 <200609130851.16028.bjorn.helgaas@hp.com>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 11:01:16 +0800
Message-Id: <1158202876.20560.14.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-13 at 22:51 +0800, Bjorn Helgaas wrote:
> On Tuesday 12 September 2006 19:27, keith mannthey wrote:
> > On Thu, 2006-09-07 at 20:27 -0600, Bjorn Helgaas wrote:
> > > > On Thu, 2006-09-07 at 09:25 -0600, Bjorn Helgaas wrote:
> > > >> If we decide that "try HID first, then try CID" is the right
> thing,
> > > >> I think we should figure out how to make that work.  Maybe that
> > > >> means extending the driver model somehow.
> > > > Don't think it's easy, especially no other bus needs it I guess.
> > >
> > > I agree it's probably not easy, but I think having the right
> > > semantics is more important than fitting cleanly into the
> > > driver model.  But I know that without code, I'm just venting
> > > hot air, not contributing to a solution.
> > >
> > > How's the ACPI driver model integration going, anyway?  I seem
> > > to recall some patches a while back, but I don't think they're
> > > in the tree yet.
> > >
> > > > Do we really need the memory hotplug device returns
> pnp0c01/pnp0c02?
> > > > What's the purpose?
> > >
> > > I don't know.  But I think Keith already determined that a BIOS
> change
> > > is not likely.  I hate to ask for BIOS changes like this because
> it
> > > feels like asking them to avoid broken things in Linux.
> >
> >   Ok my motherboard patch was dropped from -mm so I am broken again
> but
> > others are fixed. Is the answer that we do nothing about this
> issues?  
> >
> >   I am pretty sure my SSDT table is valid if someone *cannot* point
> out
> > in the spec where my device is malformed  by having both HID and CID
> I
> > will not be able even start the request to change the BIOS (it would
> be
> > a waste of my time).  Sure having the CID of the memory device may
> be
> > overkill but is it wrong? 
> 
> I think that your SSDT is valid.  I can't point to a specific
> reference in the spec, but I think the "try _HID first, then try
> _CID" strategy is clearly the intent.  Otherwise, there would be
> no reason to separate _HID from _CID.
The spec actually doesn't mention PNP0C01/PNP0C02. It's hard to say this
is valid or invalid. 

The 'try _HID first then _CID' has another downside. It highly depends
on the driver is loaded first and then load the device. See motherboard
driver loads first and the mem hotplug driver isn't loaded, in this
situation if you scan the mem hotplug device, the mechanism will fail as
the two pass search will still bind motherboard driver to the device.

If you take the two pass search, I have a feeling this will make acpi
never be able to convert Linux driver model.

If you really want to workaround the issue, I prefer have a blacklist or
something to let ACPI not use the _CID for your device, but please don't
mess the ACPI core itself.

Thanks,
Shaohua
