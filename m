Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbUFBNnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUFBNnI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 09:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUFBNnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 09:43:08 -0400
Received: from [213.239.201.226] ([213.239.201.226]:41435 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S262954AbUFBNmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 09:42:42 -0400
Message-ID: <40BDDAD9.5070809@shadowconnect.com>
Date: Wed, 02 Jun 2004 15:49:13 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with ioremap which returns NULL in 2.6 kernel
References: <40BC788A.3020103@shadowconnect.com> <20040601142122.GA7537@havoc.gtf.org> <40BC9EF7.4060502@shadowconnect.com> <40BD1211.9030302@pobox.com> <40BD95EB.40506@shadowconnect.com> <40BDD4C9.5070602@pobox.com>
In-Reply-To: <40BDD4C9.5070602@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Jeff Garzik wrote:
>>> My preferred approach would be:  consider that the hardware does not 
>>> need the entire 0x8000000-byte area mapped.  Plain and simple.
>>> This is a "don't do that" situation, and that renders the other 
>>> questions moot :)  You should only be mapping what you need to map.
>> Okay, i'll let try it out with only 64MB.
> Why do you need 64MB, even?  :)

I don't know how much space i need :-D But why does the device set the 
size to 128MB then?

Also now both controllers where found, but the kernel crashes. It could 
be because the driver was never used with 2 controllers, but to be sure 
  i didn't make something wrong with the ioremap here is my patch.

--- a/drivers/message/i2o/i2o_core.c	2004-05-25 00:51:48.822275000 +0200
+++ b/drivers/message/i2o/i2o_core.c	2004-06-01 22:17:55.562844312 +0200
@@ -3664,6 +3664,8 @@
  	}
  	
  	size = dev->resource[i].end-dev->resource[i].start+1;	
+	if(size>67108864)
+		size = 67108864;
  	/* Map the I2O controller */
  	
  	printk(KERN_INFO "i2o: PCI I2O controller at 0x%08X size=%d\n", 
memptr, size);

	mem = (unsigned long)ioremap(memptr, size);


Simply set size lower :-) Or have i missed something?

Thanks for you help!


Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
