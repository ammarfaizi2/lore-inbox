Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131563AbRC0Uhk>; Tue, 27 Mar 2001 15:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131564AbRC0Uha>; Tue, 27 Mar 2001 15:37:30 -0500
Received: from mout03.kundenserver.de ([195.20.224.218]:2333 "EHLO
	mout03.kundenserver.de") by vger.kernel.org with ESMTP
	id <S131563AbRC0UhY>; Tue, 27 Mar 2001 15:37:24 -0500
Date: Tue, 27 Mar 2001 22:09:51 +0200
From: Alex Riesen <vmagic@users.sourceforge.net>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI power-off doesn't work on Asus CUV4X (VIA Apollo 133)
Message-ID: <20010327220951.A433@steel>
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE7B2@orsmsx35.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE7B2@orsmsx35.jf.intel.com>; from andrew.grover@intel.com on Mon, Mar 26, 2001 at 10:35:33AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
BTW, ACPI in ac20 doesn't work for me either :(
Alex

On Mon, Mar 26, 2001 at 10:35:33AM -0800, Grover, Andrew wrote:
> > From: Ingo Oeser [mailto:ingo.oeser@informatik.tu-chemnitz.de]
> > > > As i recompiled 2.4.2-ac20 with ACPI support
> > > > the system cannot switch itself off.
> > > > I get a message "Couldn't switch to S5" if
> > > > try to call reboot(2).
> > > > At load it shows that the mode is supported.
> > > 
> > > Same with AMR P6BAP-AP and P6VAP-AP () mainboards.
> 
> > > #define APCI_DEBUG 1 has NO effect on verbosity of messages :-(
> 
> The ACPI version in the kernel has debug messages stripped, for historical
> reasons. There is a non-stripped version available at
> http://developer.intel.com/technology/iapc/acpi/downloads.htm but this also
> includes other new code, which may or may not be what you want.
> 
> > The BIG Problem is: This is an embedded machine, so I cannot
> > attach all the funny debug tools. The most thing I can do is
> > printk and evtl. ikdb. I have only 16MB flash disk on this
> > machine and it is full already :-(
> 
> Either try the version on the website, or make this change and see if it
> helps:
> 
> 	drivers/acpi/hardware/hwsleep.c (at the bottom) :
> 
> 	acpi_hw_register_write(ACPI_MTX_LOCK, PM1_a_CONTROL, PM1_acontrol);
> 	acpi_hw_register_write(ACPI_MTX_LOCK, PM1_b_CONTROL, PM1_bcontrol);
> 	acpi_hw_register_write(ACPI_MTX_LOCK, PM1_CONTROL,     <-- remove
> these
> 		(1 << acpi_hw_get_bit_shift (SLP_EN_MASK)));     <--

