Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132539AbRCZShD>; Mon, 26 Mar 2001 13:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132540AbRCZSgo>; Mon, 26 Mar 2001 13:36:44 -0500
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:18126 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S132539AbRCZSgi>; Mon, 26 Mar 2001 13:36:38 -0500
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE7B2@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Ingo Oeser'" <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Alex Riesen <vmagic@users.sourceforge.net>, linux-kernel@vger.kernel.org,
        "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: RE: ACPI power-off doesn't work on Asus CUV4X (VIA Apollo 133)
Date: Mon, 26 Mar 2001 10:35:33 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ingo Oeser [mailto:ingo.oeser@informatik.tu-chemnitz.de]
> > > As i recompiled 2.4.2-ac20 with ACPI support
> > > the system cannot switch itself off.
> > > I get a message "Couldn't switch to S5" if
> > > try to call reboot(2).
> > > At load it shows that the mode is supported.
> > 
> > Same with AMR P6BAP-AP and P6VAP-AP () mainboards.

> > #define APCI_DEBUG 1 has NO effect on verbosity of messages :-(

The ACPI version in the kernel has debug messages stripped, for historical
reasons. There is a non-stripped version available at
http://developer.intel.com/technology/iapc/acpi/downloads.htm but this also
includes other new code, which may or may not be what you want.

> The BIG Problem is: This is an embedded machine, so I cannot
> attach all the funny debug tools. The most thing I can do is
> printk and evtl. ikdb. I have only 16MB flash disk on this
> machine and it is full already :-(

Either try the version on the website, or make this change and see if it
helps:

	drivers/acpi/hardware/hwsleep.c (at the bottom) :

	acpi_hw_register_write(ACPI_MTX_LOCK, PM1_a_CONTROL, PM1_acontrol);
	acpi_hw_register_write(ACPI_MTX_LOCK, PM1_b_CONTROL, PM1_bcontrol);
	acpi_hw_register_write(ACPI_MTX_LOCK, PM1_CONTROL,     <-- remove
these
		(1 << acpi_hw_get_bit_shift (SLP_EN_MASK)));     <--


Regards -- Andy

