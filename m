Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbVKOEE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbVKOEE0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 23:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVKOEE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 23:04:26 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:17677 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932361AbVKOEEZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 23:04:25 -0500
Message-ID: <43795E47.70507@vmware.com>
Date: Mon, 14 Nov 2005 20:04:23 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rohit Seth <rohit.seth@intel.com>
Cc: akpm@osdl.org, sfr@canb.auug.org.au, mm-commits@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>, sfr@linuxcare.com.au,
       david@lechnyr.com, kontakt@hanno.de
Subject: Does anyone undefine APM_RELAX_SEGMENTS?
References: <200511100824.jAA8O0fu008792@shell0.pdx.osdl.net> <1132024003.6760.16.camel@akash.sc.intel.com>
In-Reply-To: <1132024003.6760.16.camel@akash.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2005 04:04:23.0231 (UTC) FILETIME=[A9767CF0:01C5E999]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth wrote:

>On Thu, 2005-11-10 at 00:23 -0800, akpm@osdl.org wrote:
>  
>
>>The patch titled
>>
>>     x86: Always relax segments
>>
>>has been added to the -mm tree.  Its filename is
>>
>>     x86-always-relax-segments.patch
>>
>>
>>From: Zachary Amsden <zach@vmware.com>
>>
>>APM BIOSes have many bugs regarding proper representation of the appropriate
>>segment limits for calling the BIOS.  By default, APM_RELAX_SEGMENTS is always
>>turned on to support running the APM BIOS on these buggy machines.  Keeping
>>64k limits poses very little danger to the kernel, because the pages where the
>>APM BIOS is located will always be in low physical memory BIOS areas, which
>>should already be marked reserved, and only buggy BIOSes would possibly
>>overstep the segment bounds with writes to data anyway.
>>
>>Since forcing stricter limits breaks many machines and is not default
>>behavior, it seems reasonable to deprecate the older code which may cause APM
>>BIOS to fault.
>>
>>    
>>
>
>But I presume it make some other machines to work?
>  
>

It would make the APM thread panic on machines with broken APM BIOS - 
which is not very useful except for proving a BIOS bug.  But APM is 
inherently safer than PnP, since there is no transfer segment which can 
corrupt arbitrary kernel memory.

In the history of its introduction, I can not find a single distribution 
or use which undefines this macro.  If anyone knows otherwise, please 
advise.

Zach
