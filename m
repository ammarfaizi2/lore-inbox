Return-Path: <linux-kernel-owner+w=401wt.eu-S932200AbXAFUv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbXAFUv7 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 15:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbXAFUv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 15:51:59 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:45291 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200AbXAFUv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 15:51:58 -0500
Message-ID: <45A00BED.6030802@vmware.com>
Date: Sat, 06 Jan 2007 12:51:57 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
CC: linux-kernel@vger.kernel.org, ak@suse.de, chrisw@sous-sol.org,
       jeremy@xensource.com, rusty@rustcorp.com.au
Subject: Re: + paravirt-vmi-timer-patches.patch added to -mm tree
References: <200612152227.kBFMRNuQ002977@shell0.pdx.osdl.net>	 <1168106760.26086.222.camel@imap.mvista.com>  <45A00878.1000705@vmware.com> <1168116057.26086.227.camel@imap.mvista.com>
In-Reply-To: <1168116057.26086.227.camel@imap.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> On Sat, 2007-01-06 at 12:37 -0800, Zachary Amsden wrote:
>
>   
>>> There is already a dynamic tick (NO_HZ) system in the -mm tree .. Given
>>> that this implementation seems unnecessary. Why do you need another
>>> different system to do this?
>>>   
>>>       
>> We don't.  This was written before the dynamic tick code, and now they 
>> need to be merged.  Until then, they can safely coexist.
>>     
>
> So really this can't go upstream till that merge happens. What's
> preventing you from just directly using NO_HZ without changes?
>   

For one thing, the fact that it doesn't account for stolen time.  But 
mostly because going through the regular PIT / APIC timer paths has a 
lot of overhead.  So we need a separate timer device, and weaving this 
in with the local APIC timer dependency for SMP on i386 requires changes 
on top of NO_HZ.

Zach
