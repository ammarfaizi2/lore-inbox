Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131555AbRC3RTT>; Fri, 30 Mar 2001 12:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131562AbRC3RTK>; Fri, 30 Mar 2001 12:19:10 -0500
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:58313 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S131555AbRC3RTE>; Fri, 30 Mar 2001 12:19:04 -0500
Message-ID: <4148FEAAD879D311AC5700A0C969E89006887716@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: pavel@suse.cz, sfr@canb.auug.org.au, twoller@crystal.cirrus.com,
   linux-kernel@vger.kernel.org
Subject: RE: Incorrect mdelay() results on Power Managed Machines x86
Date: Fri, 30 Mar 2001 09:17:14 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure what you mean by well-defined. Do you mean, does it have a
fixed address? No, it is relocatable. The ACPI driver can find it because
the base address is specified in the ACPI tables. After the ACPI driver is
loaded the driver could export a pmtimer read function. This is great except
that anything before ACPI load would be out of luck.

After reading a chipset datasheet (in this case for the ICH-2M) both the
8254 timers and the PM timer are driven off a 14.31818 MHz clock input - the
PM timer is that divided by 4 and the 8254 is that divided by 12.

Is there any way we could use the 8254 timer for a reliable udelay? Not as
accurate, but no ACPI dependency.

Regards -- Andy

> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> > I know on ACPI systems you are guaranteed a PM timer 
> running at ~3.57 Mhz.
> > Could udelay use that, or are there other timers that are 
> better (maybe
> > without the ACPI dependency)? 
> 
> We could use that if ACPI was present. It might be worth 
> exploring. Is this
> PM timer well defined for accesses  ?
