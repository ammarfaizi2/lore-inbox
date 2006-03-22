Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932801AbWCVVgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932801AbWCVVgJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932800AbWCVVgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:36:09 -0500
Received: from sccrmhc13.comcast.net ([63.240.77.83]:4771 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932799AbWCVVgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:36:07 -0500
Message-ID: <4421C33C.9030408@acm.org>
Date: Wed, 22 Mar 2006 15:35:56 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
CC: Greg KH <greg@kroah.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Yani Ioannou <yani.ioannou@gmail.com>
Subject: Re: [PATCH] Try 2, Fix release function in IPMI device model
References: <20060322204501.GA21213@i2.minyard.local>	 <20060322210820.GA12518@kroah.com> <d120d5000603221318n7b4d664eh3cafc9260f6e12e@mail.gmail.com>
In-Reply-To: <d120d5000603221318n7b4d664eh3cafc9260f6e12e@mail.gmail.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:

>On 3/22/06, Greg KH <greg@kroah.com> wrote:
>  
>
>>On Wed, Mar 22, 2006 at 02:45:01PM -0600, Corey Minyard wrote:
>>    
>>
>>>Ok, one more try.  Russell, I assume you mean to use
>>>platform_device_alloc(), which seems to do what you suggested.
>>>And I assume the driver_data is the way to store whatever you
>>>need, instead of using the container_of() macro.
>>>
>>>Arjun, Russell, thanks for the info.
>>>
>>>Now the patch...
>>>
>>>Arjun van de Ven pointed out that the changeover to the driver model
>>>in the IPMI driver had some bugs in it dealing with the release
>>>function and cleanup.  Then Russell King pointed out that you can't
>>>put release functions in the same module as the unregistering code.
>>>      
>>>
>>Yes you can, you just have to properly set up the module attribute
>>owners and it will work just fine.
>>
>>    
>>
>
>No, not really. You can only do that if _all_ sysfs attributes for the
>object are handled in your driver which is rarely the case (dev,
>/power/* attributes, etc).
>  
>
I don't see an owner field in the device structure.  So you are
saying that if the same module owns the device_driver structure,
it is safe, but if not it is not safe.

-Corey
