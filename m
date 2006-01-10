Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWAJGbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWAJGbX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 01:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWAJGbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 01:31:23 -0500
Received: from mail.dvmed.net ([216.237.124.58]:49093 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932077AbWAJGbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 01:31:22 -0500
Message-ID: <43C354B4.2070505@pobox.com>
Date: Tue, 10 Jan 2006 01:31:16 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Dave Dillow <dave@thedillows.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Adaptec 1420SA issues with MSI
References: <1136667984.2799.0.camel@obelisk.thedillows.org> <20060109221323.65f6987d.akpm@osdl.org>
In-Reply-To: <20060109221323.65f6987d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Andrew Morton wrote: > Andi says "It's more likely a
	hardware bug that needs to be handled by the > driver maintainer.
	sata_mv has an pci_enable_msi(). Hardware that reports > MSI capability
	but breaks when it's actually used is not unheard of." [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Andi says "It's more likely a hardware bug that needs to be handled by the
> driver maintainer.  sata_mv has an pci_enable_msi().  Hardware that reports
> MSI capability but breaks when it's actually used is not unheard of."


> It seems strange that pci_enable_msi() succeeded if the device is not
> MSI-capable?

Unfortunately this is not strange :(  People have been coding interrupt 
tests into MSI drivers -- shades of the early 90's -- because 
pci_enable_msi() does not fail for systems that do not support MSI. 
-Sometimes- it will fail as expected, if system does not support MSI, 
sometimes not.

For this case -- 32bit non-Intel mobo chipset -- the cause of the 
failure is likely the poor pci_enable_msi() test.

However, I know of at least one MSI-related sata_mv hardware bug that 
needs working around, but that only affects 64-bit.  Given that MSI 
works with this chip on other systems, I'm leaning towards blaming the 
system.

The following are reasonable workarounds:

* Add pci=nomsi kernel parameter... we really need this
* Add 'msi' module option to sata_mv

I'll try to get around to committing the errata to source code. 
Marvell's triple-layered vendor driver is GPL'd, so anyone can steal 
this task from me...

	Jeff


