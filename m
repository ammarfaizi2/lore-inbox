Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVCMW7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVCMW7W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 17:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVCMW7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 17:59:22 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:34690 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261384AbVCMW7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 17:59:17 -0500
Message-ID: <4234C5C2.8000109@acm.org>
Date: Sun, 13 Mar 2005 16:59:14 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add sysfs support to the IPMI driver
References: <4233C834.40903@acm.org> <20050313052011.GA18089@kroah.com>
In-Reply-To: <20050313052011.GA18089@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Sat, Mar 12, 2005 at 10:57:24PM -0600, Corey Minyard wrote:
>  
>
>>The IPMI driver has long needed to tie into the device model (and I've 
>>long been hoping someone else would do it).  I finally gave up and spent 
>>the time to learn how to do it.  I think this is right, it seems to work 
>>on on my system.
>>    
>>
>
>Looks good.  One minor question:
>
>  
>
>>+
>>+	snprintf(name, sizeof(name), "ipmi%d", if_num);
>>+	class_simple_device_add(ipmi_class, dev, NULL, name);
>>    
>>
>
>What do ipmi class devices live on?  pci devices?  i2c devices?
>platform devices?  Or are they purely virtual things?
>  
>
Good question.  I struggled with this for a little while and decided the 
class interface was important to have in first and I'd figure out the 
rest later.  They live in different places depending on the particular 
low-level interface.  Some live on the I2C bus (and will show up there 
in sysfs with the I2C driver).  Some live on the ISA bus, some are 
memory-mapped, some are on the PCI bus (though there is not a driver for 
PCI support yet), and some sit on the end of a serial port (driver is in 
the works).  I know, it's a mess, but there's not much I can do about 
these crazy hardware manufacturers.

I wasn't sure where to handle all this.  The I2C and PCI bus side of 
things should be handled.  However, the others probably need to sit 
someplace on a bus, right?  That should probably be handled in the 
low-level code that actually knows where the hardware sits.

Thanks,

-Corey
