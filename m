Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbVIXTkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVIXTkx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 15:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbVIXTkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 15:40:53 -0400
Received: from xenotime.net ([66.160.160.81]:50895 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750708AbVIXTkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 15:40:52 -0400
Date: Sat, 24 Sep 2005 12:40:50 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: acpi-support@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Supporting ACPI drive hotswap
Message-Id: <20050924124050.1955c290.rdunlap@xenotime.net>
In-Reply-To: <20050924164823.GA24351@srcf.ucam.org>
References: <20050924164823.GA24351@srcf.ucam.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2005 17:48:23 +0100 Matthew Garrett wrote:

> ACPI provides a mechanism for noting which devices can be hotswapped and 
> notifying the system that this has happened. Hotswappable devices are 
> tagged with a _RMV token. What effectively needs to be done is this:
> 
> 1) Find every device with an _RMV token, and install a notify handler 
> for it. This is fairly easy.
> 
> 2) On notification, check whether the device is present or absent. This 
> can be done by calling the _STA method - alternatively it could 
> presumably be done through the appropriate IDE or SCSI layer. I believe 
> that we now have code that allows binding of ACPI devices to appropriate 
> busses.
> 
> 3) If a device has been added, enumerate it and do appropriate messaging
> to userspace (for device node creation and so forth). This ought to be 
> relatively easy?
> 
> 4) If a device has been removed, we currently have problems. SATA 
> hotplugging is only supported on a subset of devices. The SATA laptop I 
> have here is an Intel ICH part, but uses the ata_piix driver (ahci won't 
> load) which isn't supposed to support hotswap. Unregistering devices in 
> the IDE layer has been broken for ages.

Do you know why the ahci driver won't load?
Are there any BIOS setup options for enabling AHCI native mode
vs. legacy or compatibility mode?

> Is there any point in working on the first three of these points until 
> point four is more reasonable? What actually needs to be done to improve 
> this?


---
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
