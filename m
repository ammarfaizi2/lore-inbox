Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264786AbSJOUiQ>; Tue, 15 Oct 2002 16:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264788AbSJOUiP>; Tue, 15 Oct 2002 16:38:15 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:61939 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S264786AbSJOUiM>; Tue, 15 Oct 2002 16:38:12 -0400
Message-ID: <3DAC7EAA.5020408@mvista.com>
Date: Tue, 15 Oct 2002 13:46:34 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Michael Clark <michael@metaparadigm.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] [PATCHES] Advanced TCA Hotswap Support in Linux Kernel
References: <3DAB1007.6040400@mvista.com> <20021015052916.GA11190@kroah.com> <3DAC52A7.907@mvista.com> <3DAC685B.9070102@metaparadigm.com> <3DAC6C7B.1080205@mvista.com> <20021015203423.GI15864@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The data/telecoms I've talked to require disk hotswap times of less then 
20 msec from notification of hotwap to blue led (a light used to 
indicate the device can be removed).  They would like 10 msec if it 
could be done.  This is because of how long it takes on a surprise 
extraction for the hardware to send the signal vs the user to disconnect 
the hardware.

For legacy systems such as SAFTE hotswap, polling through sg at 10 msec 
intervals would be extremely painful because of all the context 
switches.  A timer scheduled every 10 msec to send out a SCSI message 
and handle a response if there is a hotswap event is a much better course.

Thanks
-steve

Greg KH wrote:

>On Tue, Oct 15, 2002 at 12:28:59PM -0700, Steven Dake wrote:
>  
>
>>Safte polling in the kernel isn't inherently bad and could be tied into 
>>the hotplug mechanism.
>>
>>Making SAFTE hotswap available via SG would also work but system 
>>performance would be bad at small poll intervals (like 100 msec).
>>    
>>
>
>Is there a real nead to get hotplug notification any faster than that?
>
>And yes, it should all be done in userspace, whenever possible :)
>
>thanks,
>
>greg k-h
>
>
>
>  
>

