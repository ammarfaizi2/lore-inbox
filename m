Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265526AbSJXQSg>; Thu, 24 Oct 2002 12:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265527AbSJXQSf>; Thu, 24 Oct 2002 12:18:35 -0400
Received: from fmr05.intel.com ([134.134.136.6]:58059 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S265526AbSJXQSc>; Thu, 24 Oct 2002 12:18:32 -0400
Message-ID: <72B3FD82E303D611BD0100508BB29735046DFF41@orsmsx102.jf.intel.com>
From: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
To: "'Greg KH'" <greg@kroah.com>
Cc: "'KOCHI, Takayoshi'" <t-kouchi@mvf.biglobe.ne.jp>,
       "Luck, Tony" <tony.luck@intel.com>,
       pcihpd-discuss@lists.sourceforge.net,
       linux ia64 kernel list <linux-ia64@linuxia64.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: PCI Hotplug Drivers for 2.5
Date: Thu, 24 Oct 2002 09:24:30 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

My answers are next to your comments.

thanks,
J.I.


> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Wednesday, October 23, 2002 10:10 PM
> To: Lee, Jung-Ik
> Cc: 'KOCHI, Takayoshi'; Luck, Tony;
> pcihpd-discuss@lists.sourceforge.net; linux ia64 kernel list;
> linux-kernel
> Subject: Re: PCI Hotplug Drivers for 2.5
> 
> 
> On Wed, Oct 23, 2002 at 09:33:09PM -0700, Lee, Jung-Ik wrote:
> > Greg,
> > 
> > Please find the attached ACPI based PCI Hotplug driver.
> 
> But the code you sent has all of the ACPI stuff not enabled, right?

ACPI is a must for PHP enumeration/configuration and resource management for
DIG64/ACPI compliant platforms. ACPI method is optional for controller/slot
operations(event management). intcphp driver conforms to ACPI resource
management. I didn't enable ACPI based event management for PHP since it is
optional and provides less feature than controller based solution - LED,
MRL, Bus/Adapter speeds/capabilities, etc.

> 
> As an example from your patch:
> 
> +enum php_ctlr_type phphpc_get_ctlr_type()
> +{
> +       return PCI;
> +}
> 
> It never returns any other type, so the ACPI or ISA sections of the
> driver will never get called.  Or am I missing something?
> 
This is because this release only addresses PCI version only. I can take
this out too, with ease :)

> >  intcphp:
> >     Php driver source for Compaq or compatible Intel Hotplug
> >     controllers on IA32 or DIG64-ACPI compliant IA64 platforms.
> 
> So this overloads the current Compaq driver?  It looks like this "new"
> driver will also handle all of the same controllers the current Compaq
> driver does, right?  If not, it sure looks like you are 
> accepting all of
> the same PCI ID values :)
> 
Probably, as PCI ID indicates :)

> >     intcphp driver is overhauled per your requirements:
> >     + Abstraction module is removed.
> >       It's now two modules driver like others.
> 
> Thank you for making this change, I appreciate it.
> 
> >     + typedefs are removed except callback function.
> 
> Thanks.
> 
> >     + LINUX_VERSION checks are removed.
> 
> And replaced with the odd BEFORE_2_5 check :)
> Please just rip these out and send a version that is only for the 2.5
> kernel.
> 
Ah, you noticed it.. OK (pain in my heart :))

> Some of your #ifdef CONFIG_IA64 should be moved to header files only
> (and probably documented why you really need to sleep extra 
> amounts for
> ia64 machines only.
> 
> What's the #ifdef WORK_QUEUE for?

Not used. Will take out.

> 
> > 	intcphp is much based on cpqphp driver but has been 
> modified to be
> > controller independent on DIG64/ACPI compliant IPF servers 
> as well as
> > non-ACPI based IA32 servers. Thus code looks similar but 
> integration is not
> > that easy and will take time and consents of affected 
> drivers owners.
> 
> The code looks _very_ similar.  In fact, at first glance it looks like
> almost a straight copy of the existing Compaq code.  Why not 
> just submit
> a patch against that driver that adds the extra functionality that you
> need for your hardware?  That would be much smaller, and decrease the
> amount of duplicated code in the kernel tree.
> 
> Also, why doesn't the ACPI PCI hotplug driver work for your machines?
> I've seen it work on a very wide range of processors (i386 and ia64),
> and manufacturers, and any specific issues with your hardware would
> probably be better addressed with patches to the existing ACPI driver.
> 
With some reasons such as what Tak described.

> > 	We understand there needs more integration and cleanup to make
> > common codes to pci_hotplug core as you indicated. This 
> task, however,
> > requires time and changes in every php driver with owners' 
> consensus on
> > common php controller/slot objects, while satisfying 
> requirements in the
> > near future. We look forward to discussing this with you and other
> > contributors.
> 
> Great, I do too.  Please, make a proposal about what to merge into the
> core.  I do NOT want to see another driver have to duplicate the PCI
> resource management code again without a very good reason for 
> doing it.
> 
> > 	Until then, please allow us to co-exist this driver.
> 
> There's no rush, let's work together to get this done properly.
> 
We need this driver as it's the only solution for DIG64 compliant IPF
platforms.
Can we work in parallel ? - Make this driver available and we all work
together for enhanced pci_hotplug core. Also I'll talk with cpqphp owner
over the integration of the two.

> thanks,
> 
> greg k-h
> 
