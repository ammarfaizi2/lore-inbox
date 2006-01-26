Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWAZOLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWAZOLR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 09:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWAZOLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 09:11:17 -0500
Received: from fmr22.intel.com ([143.183.121.14]:33732 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932322AbWAZOLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 09:11:16 -0500
Date: Thu, 26 Jan 2006 06:10:35 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Ashok Raj <ashok.raj@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, ak@muc.de, ronald@hummelink.net,
       DiegoCG@teleline.es, venkatesh.pallipadi@intel.com,
       anil.s.keshavamurthy@intel.com
Subject: Re: Dont record local apic ids when they are disabled in MADT
Message-ID: <20060126061034.A12261@unix-os.sc.intel.com>
References: <20060126054842.A11917@unix-os.sc.intel.com> <200601261455.11981.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200601261455.11981.ak@suse.de>; from ak@suse.de on Thu, Jan 26, 2006 at 02:55:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 02:55:11PM +0100, Andi Kleen wrote:
> On Thursday 26 January 2006 14:48, Ashok Raj wrote:
> > Hi Andrew,
> > 
> > We had added additional_cpus=xx for x86_64, but apparently there were some
> > BIOSs that had duplicate apic ids when they were reported disabled.
> > 
> > It seems fair not to record them, this was causing some bad behaviour due to
> > the duplicate apic id. More details in the bugzilla recorded in the log.
> 
> This means CPU hotplug will require additional non existing code again - or who
> will set up the APIC IDs etc. for the new CPUs then?


The ACPI hotplug code already would refresh this apic id when the notify
for CPU hotplug is processed. 

Possibly we could add additional check to safegaurd buggy bios reporting 
bad apicid, as a safegaurd.  

The ACPI code when it processes a physical removal would remove this entry 
and replace with invalid id, and populate it when we process a physical 
hot-add.

(although i would say we tested this only on ia64 so far, the code is 
generic to x86_64 as well, but i havent gone around testing physical hotplug
via emulation patches we have internally)

> 
> An alternative might be to reject any entries that have the APIC ID of
> an existing entry. That would require that the entries are sorted with disabled
> after enabled
> (in the worst case Linux could sort again)
> 
> -Andi

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
