Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265505AbSJaXwd>; Thu, 31 Oct 2002 18:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265512AbSJaXwd>; Thu, 31 Oct 2002 18:52:33 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:18963 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265505AbSJaXv3>;
	Thu, 31 Oct 2002 18:51:29 -0500
Date: Thu, 31 Oct 2002 15:54:57 -0800
From: Greg KH <greg@kroah.com>
To: "KOCHI, Takayoshi" <t-kouchi@mvf.biglobe.ne.jp>
Cc: andrew.grover@intel.com, jung-ik.lee@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: bare pci configuration access functions ?
Message-ID: <20021031235457.GF10689@kroah.com>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A493@orsmsx119.jf.intel.com> <20021031221136.GC10689@kroah.com> <20021101083717.IAAOC0A82650.6C9EC293@mvf.biglobe.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021101083717.IAAOC0A82650.6C9EC293@mvf.biglobe.ne.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 03:37:16PM -0800, KOCHI, Takayoshi wrote:
> 
> On Thu, 31 Oct 2002 14:11:36 -0800
> Greg KH <greg@kroah.com> wrote:
> 
> > But even then, you are building up a few pci structures yourself to talk
> > to the pci device.  In looking at the few places you call this function,
> > is there any reason that acpi_ex_pci_config_space_handler() can't just
> > call pci_bus_* itself, instead of having to go through
> > acpi_os_read_pci_configuration()?  If so, the one other usage of the
> > acpi_os_read_pci_configuration() can cause that function to be
> > simplified a lot.
> 
> That's because of Linux port of ACPI CA structure.
> ACPI CA divides the acpi driver into OS independent part and os dependent
> part.  acpi_ex_pci_config_space_handler exists in OS-independent
> part and acpi_os_read_pci_configuration exists in OS-dependent
> part.  The OS independent part is shared with other OSes, while
> OS dependent part (acpi_os_xxx functions) are Linux specific.

Ok, if you want to drag that baggage around for forever, fine.  But
don't force me to change anything in the pci core to enable that baggage
to stay :)

> That's the way ACPI driver designers took and Linux can benefit
> from other OS's feedback in OS-independent part.

Can I ask if any of the development for other OSs has actually helped
Linux development?  I'm just curious.

And isn't the ACPI core development basically finished, so that now we
can start to do these OS dependent optimizations to allow the ACPI code
base to start to shrink and move towards looking more like the rest of
the kernel code, instead of looking like "something that got run through
a Linux kernelizer style generator"?

> > Anyway, this is a nice diversion from the real problem here, for 2.4,
> > should I just backport the pci_ops changes which will allow pci
> > hotplugging to work again on ia64, or do we want to do something else?
> 
> It would be great if we had the same 2.5 functions in 2.4.

It would be, but as I just said in a different response, it's a _big_
change.  I can't just go breaking different arch's with impunity as I've
been doing in 2.5 :)

thanks,

greg k-h
