Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264821AbSJOVBl>; Tue, 15 Oct 2002 17:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264824AbSJOVBO>; Tue, 15 Oct 2002 17:01:14 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:49653 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S264821AbSJOU7V>; Tue, 15 Oct 2002 16:59:21 -0400
Message-ID: <3DAC839F.7060301@mvista.com>
Date: Tue, 15 Oct 2002 14:07:43 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Michael Clark <michael@metaparadigm.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] [PATCHES] Advanced TCA Hotswap Support in Linux Kernel
References: <3DAB1007.6040400@mvista.com> <20021015052916.GA11190@kroah.com> <3DAC52A7.907@mvista.com> <3DAC685B.9070102@metaparadigm.com> <3DAC6C7B.1080205@mvista.com> <20021015203423.GI15864@kroah.com> <3DAC7EAA.5020408@mvista.com> <20021015205402.GL15864@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Greg KH wrote:

>On Tue, Oct 15, 2002 at 01:46:34PM -0700, Steven Dake wrote:
>  
>
>>The data/telecoms I've talked to require disk hotswap times of less then 
>>20 msec from notification of hotwap to blue led (a light used to 
>>indicate the device can be removed).  They would like 10 msec if it 
>>could be done.  This is because of how long it takes on a surprise 
>>extraction for the hardware to send the signal vs the user to disconnect 
>>the hardware.
>>    
>>
>
>But what starts the "notification of hotswap"?  Is this driven by the
>user somehow, or is it a hardware event that happens out of the blue?
>  
>
In the case of Advanced TCA, an IPMI message is sent to the CPU blade 
indicating the hotswap button is pressed on the front panel of a disk 
blade.  The hotswap manager software unmaps the GA address, removes the 
device from the linux kernel via the scsi-hotswap-main stuff, and sends 
another IPMI message to the disk node telling it to light its "blue 
led".  The user removes the disk.  Insertion is easier.

In this case, the hotswap button on the front panel is used to indicate 
a hotswap event.  There is talk of making the removal of the board 
indicate a hotswap event (surprise extraction) because the technicians 
don't wait for the blue led to remove the boards occasionally and the 
system should be able to handle this use case.

>>For legacy systems such as SAFTE hotswap, polling through sg at 10 msec 
>>intervals would be extremely painful because of all the context 
>>switches.  A timer scheduled every 10 msec to send out a SCSI message 
>>and handle a response if there is a hotswap event is a much better course.
>>    
>>
>
>What generates the hotswap event?
>  
>
In the case of SAFTE, a SCSI processor (ASIC) is polled by some polling 
interval about the state of the SAFTE (SCSI) backplane.  When the state 
changes, software generates a hotswap event and removes the device.

Thanks
-steve

>  
>

