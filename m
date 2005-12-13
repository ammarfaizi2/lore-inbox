Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbVLMTEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbVLMTEK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 14:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbVLMTEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 14:04:10 -0500
Received: from fmr17.intel.com ([134.134.136.16]:22914 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932609AbVLMTEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 14:04:08 -0500
Date: Tue, 13 Dec 2005 11:07:27 -0800
From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
Message-Id: <20051213110727.2bef7d80.randy_d_dunlap@linux.intel.com>
In-Reply-To: <20051213182651.GA14645@srcf.ucam.org>
References: <20051208030242.GA19923@srcf.ucam.org>
	<20051213101417.13fdb14c.randy_d_dunlap@linux.intel.com>
	<20051213182651.GA14645@srcf.ucam.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
X-Face: "}I"O`t9.W]b]8SycP0Jap#<FU!b:16h{lR\#aFEpEf\3c]wtAL|,'>)%JR<P#Yg.88}`$#
 A#bhRMP(=%<w07"0#EoCxXWD%UDdeU]>,H)Eg(FP)?S1qh0ZJRu|mz*%SKpL7rcKI3(OwmK2@uo\b2
 GB:7w&?a,*<8v[ldN`5)MXFcm'cjwRs5)ui)j
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2005 18:26:51 +0000
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> On Tue, Dec 13, 2005 at 10:14:17AM -0800, Randy Dunlap wrote:
> 
> > 7.  Most important:  What good does the ACPI interface do/add?
> >     What I mean is that acpi_get_child() in scsi_acpi_find_channel()
> >     always returns a handle value of 0, so it doesn't get us
> >     any closer to determining the ACPI address (_ADR) of the SATA
> >     devices.  The acpi_get_devices() technique in my patch (basically
> >     walking the ACPI namespace, looking at all "devices") is the
> >     only way that I know of doing this, but I would certainly
> >     like to find a better way.
> 
> When the PCI bus is registered, acpi walks it and finds the appropriate 
> acpi handle for each PCI device. This is shoved in the 
> firmware_data field of the device structure. Later on, we register the 
> scsi bus. As each item on the bus is added, the acpi callback gets 
> called. If it's not an endpoint, scsi_acpi_find_channel gets called. 
> We're worried about the host case. The host number will correspond to 
> the appropriate _ADR underneath the PCI device that the host is on, so 
> we simply get the handle of the PCI device and then ask for the child 
> with the appropriate _ADR. That gives us the handle for the device, and 
> returning that sticks it back in the child's firmware_data field.
> 
> At least, that's how it works here. If acpi_get_child always returns 0 
> for you, then it sounds like something's going horribly wrong. Do you 
> have a copy of the DSDT?

Thanks for the explanation.
The 136 KB DSDT is at:
  http://www.xenotime.net/linux/SATA/acpitbl.out .

---
~Randy
