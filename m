Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274299AbRJaWUS>; Wed, 31 Oct 2001 17:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274789AbRJaWUI>; Wed, 31 Oct 2001 17:20:08 -0500
Received: from air-1.osdl.org ([65.201.151.5]:34578 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S274299AbRJaWTy>;
	Wed, 31 Oct 2001 17:19:54 -0500
Date: Wed, 31 Oct 2001 14:20:13 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@osdlab.pdx.osdl.net>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
cc: "Grover, Andrew" <andrew.grover@intel.com>, <linux-kernel@vger.kernel.org>
Subject: RE: 2xQ: Is PM + ACPI but /no/ APM a valid configuration? Interru 
 pts enabled in APM set power state?
In-Reply-To: <284303687.1004565440@[195.224.237.69]>
Message-ID: <Pine.LNX.4.33.0110311413430.11035-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Admittedly, I don't know much about APM, though I may have some general
insight..

> No PM, no ACPI, no APM
>
> suspend works - i.e. doesn't crash on resume,
> but 'dumbly' and doesn't restore some PCI states
> (unsurprising), clock, etc., and no /proc/apm
> etc.

/proc/apm is created by the APM driver.

Many drivers have

#ifdef CONFIG_PM

around power management functionality, so you're not going to get that if
none of these are enabled. Even if CONFIG_PM, it's not going to be called
unless APM is up and running.

The BIOS is supposed to restore all the PCI config space, but we all know
how well the BIOS does what it's supposed to reliably.

> PM, no ACPI, no APM
>
> this seems to work, but debugging the power management
> stuff suggests that the PCI drivers are never sent
> suspend or resume events, which is causing the
> crashes below.

The suspend resume events are triggered by the APM subsystem. You won't
get them without it.

> PM, ACPI, no APM
>
> Suspend buttons (all of them) & closing laptop
> lid no longer do anything. As there's no apm support,
> apm -s doesn't work either, so impossible to test
> suspend.

The suspend buttons and lid switch are controlled via GPEs. IIRC, all the
GPEs are disabled by ACPI. If they're not, I know there are no handlers
for them ATM.

ACPI suspend has not been implemented fully yet, so you're not going to
get good results anyway..

	-pat

