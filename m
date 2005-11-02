Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965248AbVKBVSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965248AbVKBVSO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 16:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965247AbVKBVSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 16:18:14 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:40364 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S965248AbVKBVSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 16:18:13 -0500
Message-ID: <43692D15.8060307@free.fr>
Date: Wed, 02 Nov 2005 22:18:13 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: matthieu castet <castet.matthieu@free.fr>
CC: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net, usbatm@lists.infradead.org
Subject: Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
References: <4363F9B5.6010907@free.fr> <20051101224510.GB28193@kroah.com> <43691E7E.5090902@free.fr>
In-Reply-To: <43691E7E.5090902@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

matthieu castet wrote:
> Hi Greg,
>>> +/*
>>> + * sometime hotplug don't have time to give the firmware the
>>> + * first time, retry it.
>>> + */
>>> +static int sleepy_request_firmware(const struct firmware **fw, 
>>> +        const char *name, struct device *dev)
>>> +{
>>> +    if (request_firmware(fw, name, dev) == 0)
>>> +        return 0;
>>> +    msleep(1000);
>>> +    return request_firmware(fw, name, dev);
>>> +}
>>
>>
>>
>> No, use the async firmware download mode instead of this.  That will
>> solve all of your problems.
>>
>>
> Thanks, but does userspace will retry if it fails the first time ?
> The device needs the firmware quickly and after 3-5 seconds without it, 
> it goes berserk.
> 
In request_firmware_nowait, when kernel_thread failed, where fw_work is 
freed ?
Aren't there a memleack ?

Matthieu

