Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030501AbWEYWiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbWEYWiO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 18:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030497AbWEYWiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 18:38:14 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29392 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030492AbWEYWiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 18:38:09 -0400
Date: Fri, 26 May 2006 00:17:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, Andreas Saur <saur@acmelabs.de>,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4-mm3 - kernel panic
Message-ID: <20060525221744.GA1671@elf.ucw.cz>
References: <CFF307C98FEABE47A452B27C06B85BB68AD7E1@hdsmsx411.amr.corp.intel.com> <1148583675.3070.41.camel@whizzy> <20060525221222.GA1608@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060525221222.GA1608@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 26-05-06 00:12:22, Pavel Machek wrote:
> Hi!
> 
> > > Does the panic go away with CONFIG_ACPI_DOCK=n?
> 
> > Can either Pavel or Andreas please try this little debugging patch and
> > send me the dmesg output?  Please enable the CONFIG_DEBUG_KERNEL option
> > in your .config as well so that I can get additional info.
> 
> Yep, you were right... this debugging patch helps.

...and docking +/- works, but it does not look like PCI in docking
station is properly connected:

May 26 00:13:25 amd log1n[1450]: ROOT LOGIN on `tty8'
May 26 00:13:27 amd kernel: ipw2200: version magic
'2.6.17-rc4-g81a95636-dirty SMP mod_unload PENTIUMIII REGPARM gcc-4.0'
should be '2.6.17-rc4-mm3 SMP preempt mod_unload PENTIUMIII REGPARM
gcc-4.0'
May 26 00:13:28 amd postfix/postfix-script: fatal: the Postfix mail
system is already running
May 26 00:13:57 amd kernel: ACPI Exception (acpi_bus-0070):
AE_NOT_FOUND, No context for object [f7fdc3d8] [20060310]
May 26 00:13:57 amd kernel: ACPI: docking
May 26 00:13:57 amd kernel: ACPI Exception (acpi_bus-0070):
AE_NOT_FOUND, No context for object [f7fdc3d8] [20060310]

(and that is it; I'd expect messages about detecting hp100 etc...)

I think my configuration is okay:

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_FAKE is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
CONFIG_HOTPLUG_PCI_IBM=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=y
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
