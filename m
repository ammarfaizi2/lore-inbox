Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbWFONXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbWFONXR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 09:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030401AbWFONXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 09:23:17 -0400
Received: from fmr18.intel.com ([134.134.136.17]:19926 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030302AbWFONXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 09:23:17 -0400
Message-ID: <44915E3C.5000608@linux.intel.com>
Date: Thu, 15 Jun 2006 06:18:52 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: Andi Kleen <ak@suse.de>, Brice Goglin <brice@myri.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: [RFC] PCI extended conf space when MMCONFIG disabled  because
 of e820
References: <200606150443_MC3-1-C283-D4F7@compuserve.com>
In-Reply-To: <200606150443_MC3-1-C283-D4F7@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> In-Reply-To: <p73ac8fqjix.fsf@verdi.suse.de>
> 
> On 15 Jun 2006 03:45:10 +0200, Andi Kleen wrote:
> 
>> Anyways I would say that if the BIOS can't get MCFG right then 
>> it's likely not been validated on that board and shouldn't be used.
> 
> According to Petr Vandrovec:
> 
>  ... "What is important (and checked) is address of MMCONFIG reported by MCFG
>  table...  Unfortunately code does not bother with printing that address :-(
>  
>  "Another problem is that code has hardcoded that MMCONFIG area is 256MB large. 
>  Unfortunately for the code PCI specification allows any power of two between 2MB 
>  and 256MB if vendor knows that such amount of busses (from 2 to 128) will be 
>  sufficient for system.  With notebook it is quite possible that not full 8 bits 
>  are implemented for MMCONFIG bus number."
> 
> 
> So here is a patch.  Unfortunately my system still fails the test because
> it doesn't reserve any part of the MMCONFIG area, but this may fix others.
> 
> Booted on x86_64, only compiled on i386.  x86_64 still remaps the max area
> (256MB) even though only 2MB is checked... but 2.6.16 had no check at all
> so it is still better.
> 
> 
> PCI: reduce size of x86 MMCONFIG reserved area check
> 
> 1.  Print the address of the MMCONFIG area when the test for that area
>     being reserved fails.
> 
> 2.  Only check if the first 2MB is reserved, as that is the minimum.
> 
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

Acked-by: Arjan van de Ven <arjan@linux.intel.com>

