Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbVHQUb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbVHQUb6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 16:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVHQUb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 16:31:58 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:60411 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1751252AbVHQUb6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 16:31:58 -0400
Message-ID: <43039E57.2020607@mvista.com>
Date: Wed, 17 Aug 2005 15:30:15 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Martuccelli <peterm@redhat.com>
CC: Bjorn Helgaas <bjorn.helgaas@hp.com>, len.brown@intel.com, akpm@osdl.com,
       linux-kernel@vger.kernel.org, minyard@mvista.com
Subject: Re: [PATCH 2.6.12.4] ACPI oops during ipmi_si driver init
References: <200508121944.j7CJiifE005958@redrum.boston.redhat.com>	 <200508151613.10389.bjorn.helgaas@hp.com> <1124225401.7130.797.camel@redrum.boston.redhat.com>
In-Reply-To: <1124225401.7130.797.camel@redrum.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Martuccelli wrote:

>On Mon, 2005-08-15 at 18:13, Bjorn Helgaas wrote:
>  
>
>>On Friday 12 August 2005 1:44 pm, Peter Martuccelli wrote:
>>    
>>
>>>Stumbled into this problem working on the ipmi_si driver.  When the
>>>ipmi_si driver initialization fails the acpi_tb_get_table 
>>>call, after rsdt_info has been allocated, acpi_get_firmware_table()
>>>will oops trying to reference off rsdt_info->pointer in the cleanup
>>>code.
>>>      
>>>
>>I don't know whether the ACPI patch is correct or desirable, but
>>I think the ipmi_si ACPI discovery is bogus (it was probably
>>written before the current ACPI and PNPACPI driver registration
>>interfaces were stable).
>>
>>Currently, ipmi_si uses the static SPMI table to locate the
>>device.  But the static table should only be used if we need
>>the device very early, before the ACPI namespace is available.
>>
>>I don't think we use the device early, so we should use
>>pnp_register_driver() to claim the appropriate PNP IDs.
>>Or we might have to use acpi_bus_register_driver() since
>>it looks like it uses ACPI-specific features like GPEs.
>>    
>>
>Adding in Corey to the discussion regarding ipmi_si initialization,
>waiting on Len to decide on the ACPI fix.
>  
>
I couldn't find any documentation on how the ACPI interfaces work, so 
I'm kind of in the dark.

Basically, the IPMI system interface needs information from a specific 
IPMI table to know how to configure itself.  Those tables can reference 
GPEs, so the driver can use those (though AFAIK it has never been tested).

 From spending 30 minutes searching and looking at things, I have no 
idea how to tie this in.  Can you point me to some docs?  Or do I have 
to spend hours digging?

-Corey
