Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVFYTbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVFYTbi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 15:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVFYTbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 15:31:38 -0400
Received: from opersys.com ([64.40.108.71]:518 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261242AbVFYT3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 15:29:38 -0400
Message-ID: <42BDB338.9030800@opersys.com>
Date: Sat, 25 Jun 2005 15:40:40 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: "Hodle, Brian" <BHodle@harcroschem.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: FW: PROBLEM: Devices behind PCI Express-to-PCI bridge not mapped
References: <D9A1161581BD7541BC59D143B4A06294021FAA68@KCDC1>
In-Reply-To: <D9A1161581BD7541BC59D143B4A06294021FAA68@KCDC1>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hodle, Brian wrote:
> 	I am experiencing exactly the same problem. I am using an ASUS
> K8N-DL MB with the x86_64 kernel. My PCIX devices are not allocated
> correctly. I tried using the  'pci=routeirq' option to no avail. Disabling
> ACPI in the BIOS does not help the situation either. X will not use my PCIX
> for GLX since none of the  extra txture memory has been allocated! Anyone
> have any ideas?

I've got a K8N-DL here myself and it's got a bunch of issues, some of
which seem to be outside the realm of the OS. Like others have
mentioned, the NIC and USB are out of reach.

Just for reference:
- hda = DVD
- hdc = regular IDE drive
- sda = SATA drive
- video = ATI Radeon X300 (MSI-branded)

For quite some time, I struggled trying to get any FCx to install, but
they would all fail trying to mount the DVD on secondary IDE master.
Then I swapped a regular IDE drive I have on primary IDE master with
the DVD and then the install went through. Nevertheless, Linux still
can't deal with the secondary IDE, the HD produces DMA timeouts and
eventually the kernel just shuts down the DMA on hdc. It's worth
pointing out that winxp64 which used to boot when DVD was hdc, now
simply continues showing the progress bar forever (with the IDE drive
as hdc). It too doesn't like the secondary IDE. For now, the only way
to get a clean boot in either OS is to for me to disable secondary IDE
altogether.

In all cases, Linux just can't deal with the main SATA drive if it's
connected to the ck804. It used to just freeze loading sata_nv, now
it just stays there when printing info about the disk during boot.
The machine is still responding (ctrl-alt-del does get to the kernel),
but it can't finish the bootup process. Eventually, I had to plug
the sata to the Silicon Image controller to get it to work with
Linux. Unfortunately, winxp64 has got no problem with booting off a
SATA drive connected to the same ck804 :(

When vendor installed winxp64, they reported having to use an nvidia
video card instead of the ATI one, otherwise they couldn't install
the drivers for the chipset (ck804) for "some obscure reason", as
they said. I'm guessing they were just getting the same problems I
was seing with Linux. This could actually be a hint of a conflict
between the PCIe video card and the secondary IDE. Others I've
spoken to who have this board don't report problems on the secondary
IDE, but they don't have the same card on the PCIe.

I'm guessing this board is in need of a BIOS upgrade, but I've got
the latest one from ASUS and, as others mentioned, their tech
support is so-so.

... just thought I'd write this down for others who may be having
similar problems ...

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
