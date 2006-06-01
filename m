Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbWFAUHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbWFAUHM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 16:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbWFAUHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 16:07:12 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:31237 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030264AbWFAUHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 16:07:10 -0400
Message-ID: <447F48ED.6090202@vmware.com>
Date: Thu, 01 Jun 2006 13:07:09 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org,
       Ayaz Abdulla <aabdulla@nvidia.com>
Subject: Re: [PATCH] Allow TSO to be disabled for forcedeth driver
References: <447F3FB8.2010003@vmware.com> <20060601125359.10ca1f2b.akpm@osdl.org>
In-Reply-To: <20060601125359.10ca1f2b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Zachary Amsden <zach@vmware.com> wrote:
>   
>> TSO can cause performance problems in certain environments, and being 
>> able to turn it on or off is helpful for debugging network issues.  Most 
>> other network drivers that support TSO allow it to be toggled, so add 
>> this feature to forcedeth.  Tested by Harald Dunkel, who reported that 
>> this fixed his network performance issue with VMware.
>>
>>     
>
> (This is regarding
> http://www.vmware.com/community/thread.jspa?messageID=408893)
>
>
> Why does TSO-with-forcedeth make vmware networking slow?
>
> Is it specific to the forcedeth driver?
>   

No.  TSO is not good for bridged virtual networking in general, since 
even if the bridged networking module understood TSO, it would then have 
to split up any large packets into smaller packets to pass on to the 
guest virtual machine - or require that the guest virtual machine have 
and understand how to use a TSO compatible network interface as well.  
Both solutions are extremely problematic, and the easiest thing to do is 
just disable TSO.  It makes sense for any protocol bridge device, 
including some firewall configurations.

Zach
