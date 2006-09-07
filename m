Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWIGPZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWIGPZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 11:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWIGPZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 11:25:59 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:43724 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932092AbWIGPZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 11:25:57 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Shaohua Li <shaohua.li@intel.com>
Subject: Re: one more ACPI Error (utglobal-0125): Unknown exception code:0xFFFFFFEA [Re: 2.6.18-rc4-mm3]
Date: Thu, 7 Sep 2006 09:25:49 -0600
User-Agent: KMail/1.9.1
Cc: kmannth@us.ibm.com, "Moore, Robert" <robert.moore@intel.com>,
       Len Brown <lenb@kernel.org>, Mattia Dongili <malattia@linux.it>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       linux acpi <linux-acpi@vger.kernel.org>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
References: <B28E9812BAF6E2498B7EC5C427F293A4E38B52@orsmsx415.amr.corp.intel.com> <1157573069.5713.24.camel@keithlap> <1157594624.2782.45.camel@sli10-desk.sh.intel.com>
In-Reply-To: <1157594624.2782.45.camel@sli10-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609070925.50145.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 September 2006 20:03, Shaohua Li wrote:
> On Thu, 2006-09-07 at 04:04 +0800, keith mannthey wrote:
> > On Wed, 2006-09-06 at 11:59 -0700, Moore, Robert wrote: 
> > > From one of the ACPI guys: 
> > >  
> > > > Get hid 
> > > > Look for driver 
> > > > If you find a match, load it 
> > > > If no match, get CID 
> > > > Look for driver 
> > > > If you find a match, load it 
> > > > If you did not find an hid or cid match, punt
> > 
> > I think this is what my patch is doing.
> > 
> > when looking for a driver: (acpi_bus_find_driver) 
> > I check against the HID  
> > return if found  
> > Then I check against the CID 
> > return if found 
> > else 
> > punt 
> > 
> > Any objections to pushing this into -mm and dropping the motherboard 
> > change?

> I'd prefer not take this way. The ACPI driver model is already mess
> enough, let's don't make it worse. We are converting the ACPI driver
> model to Linux driver model, this will make the attempt difficult.

I see that driver_bind() and driver_probe_device() don't mesh well
with the idea that multiple drivers might be able to claim a device,
because there doesn't seem to be a way to prioritize one driver
over another.  Is that the problem you're referring to?

If we decide that "try HID first, then try CID" is the right thing,
I think we should figure out how to make that work.  Maybe that
means extending the driver model somehow.

> We can let the motherboard driver not bind to your device (say we didn't
> register the motherboard driver, but just reserve the resource of the
> deivce). Is it ok to you? (I remember Bjorn said he wants to reserve the
> mem region of the device too).

My point was that ACPI tells us what resources the device uses,
and we should reserve all of them so we accurately model the system.

Reserving resources without registering the driver sounds like a hack
to work around broken behavior elsewhere, so I don't think it's a
good idea.

Bjorn
