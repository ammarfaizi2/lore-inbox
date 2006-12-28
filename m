Return-Path: <linux-kernel-owner+w=401wt.eu-S932695AbWL1Aci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbWL1Aci (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 19:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWL1Aci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 19:32:38 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:36353 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932745AbWL1Ach (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 19:32:37 -0500
Message-ID: <459310A3.4060706@vmware.com>
Date: Wed, 27 Dec 2006 16:32:35 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Rene Herman <rene.herman@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] romsignature/checksum cleanup
References: <458EEDF7.4000200@gmail.com>  <458F20FB.7040900@gmail.com> <1167179512.16175.4.camel@localhost.localdomain>
In-Reply-To: <1167179512.16175.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> On Mon, 2006-12-25 at 01:53 +0100, Rene Herman wrote:
>   
>> Rene Herman wrote:
>>
>>     
>>> Use adding __init to romsignature() (it's only called from probe_roms() 
>>> which is itself __init) as an excuse to submit a pedantic cleanup.
>>>       
>> Hmm, by the way, if romsignature() needs this probe_kernel_address() 
>> thing, why doesn't romchecksum()?
>>     
>
> I assume it's all in the same page, but CC'ing Zach is easier than
> reading the code 8)
>   

Some hypervisors don't emulate the traditional physical layout of the 
first 1M of memory, so those pages might never get physical mappings 
established during the boot process, causing access to them to fault.  
Presumably, if the first page is there with a good signature, the entire 
ROM is mapped.  I think Jeremy added this for Xen, and it's harmless on 
native hardware.

Zach
