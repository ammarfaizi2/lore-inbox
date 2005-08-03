Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVHCVnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVHCVnc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 17:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVHCVnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 17:43:32 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:53731 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S261522AbVHCVnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 17:43:31 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: matthieu castet <castet.matthieu@free.fr>
Subject: Re: [ACPI] Re: [PATCH] PNPACPI: fix types when decoding ACPI resources [resend]
Date: Wed, 3 Aug 2005 15:41:53 -0600
User-Agent: KMail/1.8.1
Cc: acpi-devel@lists.sourceforge.net, Shaohua Li <shaohua.li@intel.com>,
       Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org
References: <200508020955.54844.bjorn.helgaas@hp.com> <200508030920.13450.bjorn.helgaas@hp.com> <42F1343B.70707@free.fr>
In-Reply-To: <42F1343B.70707@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508031541.53777.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 August 2005 3:16 pm, matthieu castet wrote:
> Bjorn Helgaas wrote:
>  > On Tuesday 02 August 2005 7:01 pm, Shaohua Li wrote:
>  >>Did you have plan to remove other
>  >>legacy acpi drivers?
>  > No, I didn't -- which ones are you thinking about?  Looking at
>  > the callers of acpi_bus_register_driver(), I see:
> looking for METHOD_NAME__CRS is more acurate.

I didn't see any new ones when I looked for METHOD_NAME__CRS.

>  > 	drivers/char/hpet.c
>  > 		This probably should be converted to PNP.  I'll
>  > 		look into doing this.
> IIRC, I am not sure that the pnp layer was able to pass the 64 bits 
> memory adress for hpet correctly. But it would be nice if it works.

You're right, this was broken.  But I've been pushing a PNPACPI
patch to fix this.

> There was an extention of a floppy driver in order to use acpi in -mm, 
> but it seems to have been dropped.

Yeah, I did that, and it was a huge mistake.  The point was to avoid
blind probing for the device, but my concern was for ia64, and no ia64
boxes have floppy, so it's much easier to just not build the driver.

> PS : I saw in acpi ols paper that you plan once all dupe acpi drivers 
> will be removed to register again the pnp device in acpi layer. Do you 
> plan to add more check and for example add only device that have a CRS 
> in pnp layer ?

If you mean the last paragraph of section 6, I don't really understand
it.  But it mentions 8250_acpi.c as an obstacle, and I do know that we
are very close to being able to remove that.  I've already posted two
patches (one to PNPACPI to fix the 64-bit address problem, and one to
8250_pnp to add support for MMIO UARTs).  Once those are accepted, we
should be able to remove 8250_acpi.c.  I think only ia64 really relies
on it anyway.

> PPS : is there any plan to integrate 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111827568001255&w=2

I'm afraid I don't know anything about this one.
