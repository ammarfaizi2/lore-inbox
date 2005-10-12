Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751535AbVJLUIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbVJLUIn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 16:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbVJLUIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 16:08:43 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:6063 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S1751537AbVJLUIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 16:08:42 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: Re: [PATCH 1/3] hpet: allow fixed_mem32 ACPI resource type
Date: Wed, 12 Oct 2005 14:08:32 -0600
User-Agent: KMail/1.8.2
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       venki <venkatesh.pallipadi@intel.com>, bob.picco@hp.com,
       Adam Belay <ambx1@neo.rr.com>
References: <20051012115814.1d367a94.randy_d_dunlap@linux.intel.com>
In-Reply-To: <20051012115814.1d367a94.randy_d_dunlap@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510121408.32163.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 October 2005 12:58 pm, Randy Dunlap wrote:
> Allow the ACPI HPET description table to use a resource type
> of FIXED_MEM32 for the HPET reource.  Use the fixed resoure
> size of 1 KB for the HPET resource as per the HPET spec.

I have a patch in my tree to convert HPET from an ACPI
driver to a PNP driver, using PNPACPI.  That should take
care of issues like this.

But my patch is waiting on some PNP work by Adam to allow
PNPACPI devices to have more than 2 IRQs.

In the meantime, I think your patch is fine.

> +#define HPET_RANGE_SIZE		1024	/* from HPET spec */

Out of curiosity, why do you need this?  ACPI_RSTYPE_FIXED_MEM32
contains a length field, and my patch uses it.  Did you run
into some firmware that supplies incorrect information about the
size of the HPET MMIO area?

Another minor HPET nit I fixed is that it currently doesn't
use request_mem_region().  I did it in PNP terms, so it's
waiting on Adam's work, but maybe it'd be worth an interim
patch until that's ready.
