Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265565AbSJXReE>; Thu, 24 Oct 2002 13:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265566AbSJXReE>; Thu, 24 Oct 2002 13:34:04 -0400
Received: from fmr02.intel.com ([192.55.52.25]:4823 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S265565AbSJXReC>; Thu, 24 Oct 2002 13:34:02 -0400
Message-ID: <72B3FD82E303D611BD0100508BB29735046DFF45@orsmsx102.jf.intel.com>
From: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
To: "'Greg KH'" <greg@kroah.com>
Cc: "'KOCHI, Takayoshi'" <t-kouchi@mvf.biglobe.ne.jp>,
       "Luck, Tony" <tony.luck@intel.com>,
       pcihpd-discuss@lists.sourceforge.net,
       linux ia64 kernel list <linux-ia64@linuxia64.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: PCI Hotplug Drivers for 2.5
Date: Thu, 24 Oct 2002 10:40:05 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Oct 24, 2002 at 09:24:30AM -0700, Lee, Jung-Ik wrote:
> > 
> > ACPI is a must for PHP enumeration/configuration and 
> resource management for
> > DIG64/ACPI compliant platforms. ACPI method is optional for 
> controller/slot
> > operations(event management). intcphp driver conforms to 
> ACPI resource
> > management. I didn't enable ACPI based event management for 
> PHP since it is
> > optional and provides less feature than controller based 
> solution - LED,
> > MRL, Bus/Adapter speeds/capabilities, etc.
> 
> But as the code you sent me isn't enabled for ACPI, I don't see how it
> ties into the existing Compaq based PCI driver.  How does this work?
> Are you trying to have 1 driver handle both the PCI and ACPI
> functionality?

Let me try again :)

**resource management**
Non-ACPI platforms uses $HRT/EBDA, pcibios_*(), SMBIOS, etc. for slot
enumeration/configuration.
DIG64/ACPI, and SHPC requires ACPI for this. IPF platforms only have ACPI
_CRS, _PRT, _HPP, _BBN, _STA, _ADR, _SUN, etc on the namespace for PHP, and
we have to use them. (as a side note, this functionality is common for other
hotplug-* as mentioned in first mail. No API will be common for
hotplug-everything, but functionality is common and has not to be
duplicated)

**event management in terms of controller/slot operations **
ACPI provides only _EJ0, _PS?, _STA, etc for slot operations but these are
not mandatory. That means, we can use either ACPI method or controller
driver.
intcphp driver has not enabled ACPI method based solution but uses
controller driver.
intcphp driver is also capable of performing ACPI method based solution
since it works on ACPI namespace. This is why acpiphp and intcphp could be
sharing resource management and event management.

> 
> > > As an example from your patch:
> > > 
> > > +enum php_ctlr_type phphpc_get_ctlr_type()
> > > +{
> > > +       return PCI;
> > > +}
> > > 
> > > It never returns any other type, so the ACPI or ISA 
> sections of the
> > > driver will never get called.  Or am I missing something?
> > > 
> > This is because this release only addresses PCI version 
> only. I can take
> > this out too, with ease :)
> 
> As this means there is a lot of "dead code" in the driver, you should
> take all of it out.

Well, I removed many dead codes from the base driver. This is not dead code
but needed to support other types.
However, if it's not acceptable, I'll remove them.


> Hm, directly trying to sneak something by me, by just renaming a
> #define.  Not nice. :(

No intention like that at all. Please regard this as bright side of
engineers simple version control w/ commonly used #ifdefs :)
Anyway, they'll be removed per your requirement.

> 
> > We need this driver as it's the only solution for DIG64 
> compliant IPF
> > platforms.
> > Can we work in parallel ? - Make this driver available and 
> we all work
> > together for enhanced pci_hotplug core.
> 
> No, does your driver _have_ to be in the 2.5 kernel tree right now for
> some reason?  Can't anyone who _has_ to have PCI Hotplug support for
> these types of machines (and I don't think there are any 
> types of these
> machines currently shipping, right?  And they wouldn't be 
> running a 2.5
> kernel on them, right?) just grab your driver if they really need it?
It's not my area to answer. It's product marketting. I do not want to skrew
marketting :)
We want the driver available before they compalint it :|
BTW, do we know how far is 2.6, even roughly ?

> 
> > Also I'll talk with cpqphp owner over the integration of the two.
> 
> You're talking to him :)

Ah. I now know why you are the one who talks about this :)
OK, then, I'll send you a patch against your cpqphp driver asap.

Thanks,
J.I.
 
