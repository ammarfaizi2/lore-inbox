Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWBURst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWBURst (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 12:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWBURst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 12:48:49 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:60609 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751193AbWBURss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 12:48:48 -0500
Message-ID: <43FB527B.5030404@us.ibm.com>
Date: Tue, 21 Feb 2006 12:48:43 -0500
From: "Mike D. Day" <ncmike@us.ibm.com>
User-Agent: Thunderbird 1.5 (Macintosh/20051201)
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: xen-devel@lists.xensource.com, lkml <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [ PATCH 2.6.16-rc3-xen 3/3] sysfs: export Xen hypervisor	attributes
 to sysfs
References: <43FB2642.7020109@us.ibm.com> <1140542130.8693.18.camel@localhost.localdomain>
In-Reply-To: <1140542130.8693.18.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> It could be:
> 
> +---sys
>         +---hypervisor
>                 +---type
> 		+---version
>                         +---major
>                         +---minor
>                         +---extra
> 

Yeah, the type file could be useful.

>> +static ssize_t extra_show(struct kobject * kobj,
>> +			  struct attribute * attr,
>> +			  char * page)
>> +{
>> +	char extra_ver[XENVER_EXTRAVERSION_LEN];
> 
> At 1k, this is a wee bit too big to be on the stack.  I'd just kmalloc
> it instead.

This particular constant is 16 bytes so I'll leave it as is. The other 
one (CAPABILTIES_INFO), which is 1k, I did kmalloc as you suggested.

>> +static void xen_compilation_destroy(void)
>> +{
>> +	sysfs_remove_group(c_kobj, &xen_compilation_group);
>> +	kobject_put(c_kobj);
>> +	return;
>> +}
> 
> Yup, this is another excellent function name.

I'll change the others to be as descriptive. Thanks,

Mike Day
