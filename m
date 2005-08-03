Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbVHCVVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbVHCVVG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 17:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVHCVSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 17:18:51 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:3742 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S261512AbVHCVQ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 17:16:56 -0400
Message-ID: <42F1343B.70707@free.fr>
Date: Wed, 03 Aug 2005 23:16:43 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: acpi-devel@lists.sourceforge.net, Shaohua Li <shaohua.li@intel.com>,
       Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] Re: [PATCH] PNPACPI: fix types when decoding ACPI resources
 [resend]
References: <200508020955.54844.bjorn.helgaas@hp.com> <1123030861.2937.4.camel@linux-hp.sh.intel.com> <200508030920.13450.bjorn.helgaas@hp.com>
In-Reply-To: <200508030920.13450.bjorn.helgaas@hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Bjorn Helgaas wrote:
 > On Tuesday 02 August 2005 7:01 pm, Shaohua Li wrote:
 >

 >
 >>Did you have plan to remove other
 >>legacy acpi drivers?
 >
 >
 > No, I didn't -- which ones are you thinking about?  Looking at
 > the callers of acpi_bus_register_driver(), I see:
looking for METHOD_NAME__CRS is more acurate.
 >
 > 	arch/ia64/hp/common/sba_iommu.c
 > 		Probably can't be converted because it needs the
 > 		ACPI handle to extract a vendor-specific data
 > 		item from _CRS.
 >
 > 	drivers/char/hpet.c
 > 		This probably should be converted to PNP.  I'll
 > 		look into doing this.
IIRC, I am not sure that the pnp layer was able to pass the 64 bits 
memory adress for hpet correctly. But it would be nice if it works.

There are drivers/acpi/motherboard.c that done some stuff already handle 
by pnp/system.c.

There was an extention of a floppy driver in order to use acpi in -mm, 
but it seems to have been dropped.

 >
 > Then of course, there are a bunch of things in drivers/acpi/
 > (battery, button, fan, ec, etc).  I expect the reason they are
 > in drivers/acpi/ is because they need ACPI-specific functionality,
 > so they probably couldn't be converted to PNP.
yes.


Matthieu

PS : I saw in acpi ols paper that you plan once all dupe acpi drivers 
will be removed to register again the pnp device in acpi layer. Do you 
plan to add more check and for example add only device that have a CRS 
in pnp layer ?

PPS : is there any plan to integrate 
http://marc.theaimsgroup.com/?l=linux-kernel&m=111827568001255&w=2 that 
seem to fix some init problem ?
