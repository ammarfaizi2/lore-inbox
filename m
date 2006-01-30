Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWA3Q71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWA3Q71 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 11:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbWA3Q71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 11:59:27 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:55994 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S964781AbWA3Q70
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 11:59:26 -0500
Message-ID: <43DE45A4.6010808@us.ibm.com>
Date: Mon, 30 Jan 2006 11:58:12 -0500
From: "Mike D. Day" <ncmike@us.ibm.com>
User-Agent: Thunderbird 1.5 (Macintosh/20051201)
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Greg KH <greg@kroah.com>, xen-devel@lists.xensource.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] Re: [PATCH 2.6.12.6-xen] sysfs attributes for xen
References: <43DAD4DB.4090708@us.ibm.com> <1138637931.19801.101.camel@localhost.localdomain>
In-Reply-To: <1138637931.19801.101.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
 
> What are the actual types of the values that come back from the
> 
> 	HYPERVISOR_xen_version(XENVER_version, NULL)
> call?  If they are really 8-bit or 16-bit values, it might be nice to
> call that out and use some of the kernel types like u8 or u16.  In fact,
> it might even be worth it to have a function wrap that up.

return is int, but the ranges are small enough for a u8, so a wrap might be good. ret == 0 is ESUCCESS _unless_ you are calling HYPERVISOR_xen_version, in which case ret == version. 
  
> Silly idea: you _could_ have separate files for the major and minor.
> Are they something that a userspace program might commonly have to parse
> out?  Is the patch trying to save a potential hcall by outputting them
> both at once?

no, this hypercall is not in any performance path and it also returns major ver and minor ver embedded into the returned int. Good suggestion and no problem calling repeatedly (within reason). 
 
> Where does that 1024 come from?  Is it a guarantee from Xen that it will
> never fill more than 1k?  I know it is a long shot, but what if the page
> size is less than 1k?  Would this function have strange results?

Per the xen headers, this particular hcall option returns a typedef char[1024] thingy_t (which is simply a char [1024] in the patch). Yes, if the page size is < 1024 there is a problem. So a check against PAGE_SIZE may be prudent. 


I'm rewriting based on Greg's and your feedback,

thanks again, 

Mike

-- 

