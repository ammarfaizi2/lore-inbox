Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVFORyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVFORyV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 13:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVFORyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 13:54:21 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:46023 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261248AbVFORyR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 13:54:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SeYEvgk/2VfY5FgjI3LyT0Q3nJz0JFG2RIKrfKzpxlDdZbI60ULFMiFi5bKkaXFX8VF/28c1DAJ2Qot7Rq5BTZ3ktkklQXUgEfUglLXbhaY6AeLB1vThqm9H4C7P4o3zMFpD7JskiO2u+AhNJRuMoH+ccgXVMzSsLbaQO8ZILT0=
Message-ID: <9e47339105061510547ea7d2f0@mail.gmail.com>
Date: Wed, 15 Jun 2005 13:54:16 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: Fwd: hpet patches
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <88056F38E9E48644A0F562A38C64FB6004FB6BED@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <88056F38E9E48644A0F562A38C64FB6004FB6BED@scsmsx403.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/05, Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com> wrote:
> The specification for ICH5 has the details about this address
> http://www.intel.com/design/chipsets/datashts/25251601.pdf (Chapter 17).
> We need to look at specific device address to figure out the HPET base
> address in this case.

The ICH5 fix up needs to look something like this:
PCI_DEVICE_ID_INTEL_82801EB_0 is the PCI ID for the LPC device.

ACPI_FIXUP(INTEL, PCI_DEVICE_ID_INTEL_82801EB_0, hpet_ich5_fixup)
hpet_ich5_fixup()
{
     pci_bios_find_device(PCI_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0, ...)
     pci_bios_read(device, GENERAL_CONTROL_REGISTER, ..)
     Check bit 17 and see if it is enabled
     use bit 15:16 to set hpet_address to one of the four addresses
}

It would be more complicated to try and turn it on if it is turned
off. Mine is turned on at boot even though it has no ACPI entry. A
routine like this should at least get things started.

-- 
Jon Smirl
jonsmirl@gmail.com
