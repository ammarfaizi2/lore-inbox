Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWERNEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWERNEO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 09:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWERNEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 09:04:14 -0400
Received: from fmr19.intel.com ([134.134.136.18]:42666 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751361AbWERNEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 09:04:14 -0400
Message-ID: <446C70A8.5050909@linux.intel.com>
Date: Thu, 18 May 2006 06:03:36 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: konradr@us.ibm.com
CC: linux-kernel@vger.kernel.org, konradr@redhat.com
Subject: Re: [patch] Ignore MCFG if the mmconfig area isn't reserved in the
 e820 table.
References: <200605172153.35878.konradr@us.ibm.com>
In-Reply-To: <200605172153.35878.konradr@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Konrad Rzeszutek wrote:
>> Hi,
>> There have been several machines that don't have a working MMCONFIG,
>> often because of a buggy MCFG table in the ACPI bios. This patch adds a
>> simple sanity check that detects a whole bunch of these cases, and when
>> it detects it, linux now boots rather than crash-and-burns. 
>> [snip]
> 
> Arjan,
> 
> I am not sure if your analysis and your solution to the problem is correct. 
> It was my understanding that any memory NOT defined in the E820 tables 
> is NOT considered system memory. Therefore memory addresses defined in the 
> ACPI MCFG table do not have to show up in the E820 table.

the problem is that Linux considers these 'free game' and will happily put
something like IO windows for cardbus cards there.

> Also the ACPI spec v3.0 (pg 405 of PDF, section 14.2, titled:
> "E820 Assumptions and Limitations") agrees with this:
> 
> "The BIOS does not return a range description for the memory mapping
> of PCI devices, ISA Option ROMs, and the ISA PNP cards because the OS
> has mechanisms available to detect them."

MCFG is none of these...

> If this is not a specification issue, I was wondering if perhaps for the 
> machines you refer to, their BIOS bug is that the E820 have memory ranges
> which also encompass what MMCONF points to?

no their bug is mostly that MCFG is garbage in those bioses. It points plain to
the wrong place. They even reserved the correct range, just pointed mcfg at the
wrong place.


