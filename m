Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265545AbSJXQnF>; Thu, 24 Oct 2002 12:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265544AbSJXQmL>; Thu, 24 Oct 2002 12:42:11 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:62736 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265543AbSJXQlz>;
	Thu, 24 Oct 2002 12:41:55 -0400
Date: Thu, 24 Oct 2002 09:46:30 -0700
From: Greg KH <greg@kroah.com>
To: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
Cc: "'KOCHI, Takayoshi'" <t-kouchi@mvf.biglobe.ne.jp>,
       "Luck, Tony" <tony.luck@intel.com>,
       pcihpd-discuss@lists.sourceforge.net,
       linux ia64 kernel list <linux-ia64@linuxia64.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI Hotplug Drivers for 2.5
Message-ID: <20021024164629.GF22654@kroah.com>
References: <72B3FD82E303D611BD0100508BB29735046DFF41@orsmsx102.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72B3FD82E303D611BD0100508BB29735046DFF41@orsmsx102.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 09:24:30AM -0700, Lee, Jung-Ik wrote:
> 
> ACPI is a must for PHP enumeration/configuration and resource management for
> DIG64/ACPI compliant platforms. ACPI method is optional for controller/slot
> operations(event management). intcphp driver conforms to ACPI resource
> management. I didn't enable ACPI based event management for PHP since it is
> optional and provides less feature than controller based solution - LED,
> MRL, Bus/Adapter speeds/capabilities, etc.

But as the code you sent me isn't enabled for ACPI, I don't see how it
ties into the existing Compaq based PCI driver.  How does this work?
Are you trying to have 1 driver handle both the PCI and ACPI
functionality?

> > As an example from your patch:
> > 
> > +enum php_ctlr_type phphpc_get_ctlr_type()
> > +{
> > +       return PCI;
> > +}
> > 
> > It never returns any other type, so the ACPI or ISA sections of the
> > driver will never get called.  Or am I missing something?
> > 
> This is because this release only addresses PCI version only. I can take
> this out too, with ease :)

As this means there is a lot of "dead code" in the driver, you should
take all of it out.

> > >  intcphp:
> > >     Php driver source for Compaq or compatible Intel Hotplug
> > >     controllers on IA32 or DIG64-ACPI compliant IA64 platforms.
> > 
> > So this overloads the current Compaq driver?  It looks like this "new"
> > driver will also handle all of the same controllers the current Compaq
> > driver does, right?  If not, it sure looks like you are 
> > accepting all of
> > the same PCI ID values :)
> > 
> Probably, as PCI ID indicates :)

Ok, no, I will not accept this driver then, as you are duplicating the
entire Compaq driver.  Just provide a patch for the existing driver with
your new functionality.

> > >     + LINUX_VERSION checks are removed.
> > 
> > And replaced with the odd BEFORE_2_5 check :)
> > Please just rip these out and send a version that is only for the 2.5
> > kernel.
> > 
> Ah, you noticed it.. OK (pain in my heart :))

Hm, directly trying to sneak something by me, by just renaming a
#define.  Not nice. :(

> We need this driver as it's the only solution for DIG64 compliant IPF
> platforms.
> Can we work in parallel ? - Make this driver available and we all work
> together for enhanced pci_hotplug core.

No, does your driver _have_ to be in the 2.5 kernel tree right now for
some reason?  Can't anyone who _has_ to have PCI Hotplug support for
these types of machines (and I don't think there are any types of these
machines currently shipping, right?  And they wouldn't be running a 2.5
kernel on them, right?) just grab your driver if they really need it?

> Also I'll talk with cpqphp owner over the integration of the two.

You're talking to him :)

thanks,

greg k-h
