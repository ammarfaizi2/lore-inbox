Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932758AbWCVV1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932758AbWCVV1w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932761AbWCVV1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:27:52 -0500
Received: from sccrmhc14.comcast.net ([204.127.200.84]:62409 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S932758AbWCVV1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:27:51 -0500
Message-ID: <4421C154.9010308@acm.org>
Date: Wed, 22 Mar 2006 15:27:48 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Yani Ioannou <yani.ioannou@gmail.com>,
       greg@kroah.com
Subject: Re: [PATCH] Try 2, Fix release function in IPMI device model
References: <20060322204501.GA21213@i2.minyard.local> <d120d5000603221323t7c67b06epa02ed3269d3365b0@mail.gmail.com>
In-Reply-To: <d120d5000603221323t7c67b06epa02ed3269d3365b0@mail.gmail.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:

>On 3/22/06, Corey Minyard <minyard@acm.org> wrote:
>  
>
>> struct bmc_device
>> {
>>-       struct platform_device dev;
>>+       struct platform_device *dev;
>>       struct ipmi_device_id  id;
>>       unsigned char          guid[16];
>>       int                    guid_set;
>>-       int                    interfaces;
>>+
>>+       struct kref            refcount;
>>
>>    
>>
>
>Hi,
>
>I am confused as to why you need kref here. Just unregister/kfree
>memory occupied by your device structure after doing
>platform_device_unregister and that's it. platform code won't
>reference your memory and your attribute code should not be called
>from module exit code so everything shoudl be fine.
>  
>
This structure represents a "BMC", which is a microcontroller
that does managment functions.  There may be more than one
interface to a BMC, so the kref keeps track of all the interfaces
referencing the structure.

-Corey
