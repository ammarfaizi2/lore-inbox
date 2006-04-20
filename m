Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWDTKv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWDTKv1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 06:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWDTKv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 06:51:27 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:44135
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750719AbWDTKv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 06:51:26 -0400
Message-Id: <444783F2.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Thu, 20 Apr 2006 12:52:02 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <tom.l.nguyen@intel.com>, <linux-kernel@vger.kernel.org>,
       <discuss@x86-64.org>
Subject: Re: [discuss] Re: [i386, x86-64] ioapic_register_intr() and
	assign_irq_vector() questions
References: <443FE6E00200007800015D6E@emea1-mh.id2.novell.com> <200604142334.18923.ak@suse.de>
In-Reply-To: <200604142334.18923.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andi Kleen <ak@suse.de> 14.04.06 23:34:18 >>>
On Friday 14 April 2006 19:16, Jan Beulich wrote:
>> >> Looking at the call paths assign_irq_vector() can get called from, I
>> >> would think this function, namely as it's using static variables,
>> >> lacks synchronization - is there any (hidden) reason this is not
>> >> needed here?
>> 
>> >It is only called during system initialization which is single threaded. 
>> >If someone added ioapic hotplug they would need to do something about 
>> >this.
>> 
>> Hmm, as I looked through this I expected this to be possibly called also later, as it seems to be on paths
reachable
>> from exported functions (which clearly can be called only after the single-threaded phase is over.
>
>If it's not called from in tree modules we don't care. But should probably
>bunk the exports if they are not needed. Which ones were it?

acpi_register_gsi -> mp_register_gsi -> io_apic_set_pci_routing -> assign_irq_vector

acpi_register_gsi is being exported and called from drivers/char/8250_acpi.c.
acpi_register_gsi is also being called from acpi_pci_irq_enable, which in turn is being exported.
There appear to be more (eg through pnpacpi and hpet), but I think these are sufficient.

Jan
