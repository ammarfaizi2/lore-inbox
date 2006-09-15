Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWIOBw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWIOBw3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 21:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWIOBw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 21:52:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:57617 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1751440AbWIOBw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 21:52:28 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,166,1157353200"; 
   d="scan'208"; a="130743991:sNHT702360820"
Subject: Re: one more ACPI Error (utglobal-0125): Unknown exception 
	code:0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
From: Shaohua Li <shaohua.li@intel.com>
To: kmannth@us.ibm.com
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>,
       "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
       Mattia Dongili <malattia@linux.it>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       linux acpi <linux-acpi@vger.kernel.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1158256505.5660.22.camel@keithlap>
References: <B28E9812BAF6E2498B7EC5C427F293A4E38B52@orsmsx415.amr.corp.intel.com>
	 <4132.24.9.204.52.1157682479.squirrel@mail.cce.hp.com>
	 <1158110859.6047.27.camel@keithlap>
	 <200609130851.16028.bjorn.helgaas@hp.com>
	 <1158202876.20560.14.camel@sli10-conroe.sh.intel.com>
	 <1158256505.5660.22.camel@keithlap>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 09:52:02 +0800
Message-Id: <1158285122.20560.38.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-14 at 10:55 -0700, keith mannthey wrote:
> On Thu, 2006-09-14 at 11:01 +0800, Shaohua Li wrote:
> > On Wed, 2006-09-13 at 22:51 +0800, Bjorn Helgaas wrote:
> > > On Tuesday 12 September 2006 19:27, keith mannthey wrote:
> > > > On Thu, 2006-09-07 at 20:27 -0600, Bjorn Helgaas wrote:
> > > > > > On Thu, 2006-09-07 at 09:25 -0600, Bjorn Helgaas wrote:
> 
> > > I think that your SSDT is valid.  I can't point to a specific
> > > reference in the spec, but I think the "try _HID first, then try
> > > _CID" strategy is clearly the intent.  Otherwise, there would be
> > > no reason to separate _HID from _CID.
> > The spec actually doesn't mention PNP0C01/PNP0C02. It's hard to say this
> > is valid or invalid. 
> 
> Lets work on the assumption it is valid until someone points out in a
> spec that says it isn't. 
> 
> > The 'try _HID first then _CID' has another downside. It highly depends
> > on the driver is loaded first and then load the device. See motherboard
> > driver loads first and the mem hotplug driver isn't loaded, in this
> > situation if you scan the mem hotplug device, the mechanism will fail as
> > the two pass search will still bind motherboard driver to the device.
> Any solution depends on the mem hotplug device being loaded.  This
> doesn't appear to be _HID before _CID specific issue .  
> 
> > If you take the two pass search, I have a feeling this will make acpi
> > never be able to convert Linux driver model.
> 
> I am not trying to break forward work but what I do want is a solution
> to my problem. 
> 
> > If you really want to workaround the issue, I prefer have a blacklist or
> > something to let ACPI not use the _CID for your device, but please don't
> > mess the ACPI core itself.
> 
> My fist pass to fix the problem was I guess a hack of sorts that caused
> others problems (motherboard add return != 0 on unknown devices).  I
> don't want another Keith grown hack that breaks other people. 
> 
> Can you elaborate on what you think would be safe way to do what you
> propose since the ACPI core (can't/won't?) be fixed? I can imagine a
> couple of different ways to fix this but I would like some feedback
> before I go off and work on the 3rd pass of this fix. 
> 
> 1.  Make the memory device get scanned before the motherboard device
> somehow.  Implicitly reorder the devices in the list. Perhaps a priority
> sorted of sorts to have _HID device always before _CID devices during
> the scan? 
This will change the scan order of ACPI device, and sounds too hack to me.

> 2.  Have the motherboard device (if it finds the right acpi device type)
> hook into the memory device somehow. 
> 
> 3.  Some special blacklist of the motherboard device on my specific
> system. 
Either one of the two looks ok.

Thanks,
Shaohua
