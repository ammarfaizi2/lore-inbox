Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262502AbTCRQPk>; Tue, 18 Mar 2003 11:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262504AbTCRQPk>; Tue, 18 Mar 2003 11:15:40 -0500
Received: from portal.beam.ltd.uk ([62.49.82.227]:51074 "EHLO beam.beamnet")
	by vger.kernel.org with ESMTP id <S262502AbTCRQPf>;
	Tue, 18 Mar 2003 11:15:35 -0500
Message-ID: <3E7748A2.2030604@beam.ltd.uk>
Date: Tue, 18 Mar 2003 16:26:10 +0000
From: Terry Barnaby <terry@beam.ltd.uk>
Organization: Beam Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: "Cress, Andrew R" <andrew.r.cress@intel.com>
CC: linux-kernel@vger.kernel.org, support@seagate.com
Subject: Re: Reproducible SCSI Error with Adaptec 7902 & ST336607LW
References: <A5974D8E5F98D511BB910002A50A66470580D6D7@hdsmsx103.hd.intel.com>
In-Reply-To: <A5974D8E5F98D511BB910002A50A66470580D6D7@hdsmsx103.hd.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

We don't have a SCSI analyzer, so cannot do this bit. However we
know that the Adaptec AIC79XX driver curred this from 1.1.0 to 1.3.4
and that 1.3.4 is still indicating an error. I presume that some
error condition was not handled by the driver correctly and this
tiggered the disk lock up. Maybe a look at the changes could determine
the condition that resulted in the error.

However, the disks hardware should respond to a hardware RESET no
matter what the firmware is doing. This could be due to use of
FPGA's, with faulty bit files, which implement the hardware RESET ...

My easiest, and cheapest, work around is to buy another manufacturers
drive (In fact in our immediate use a modified Linux driver will 
probably suit). But, I would like to feed back the problem to save 
others wasting their time on this or having nasty system errors in the 
future.

My issues are:

1. Do Seagate consider that drives not responding to RESET in some
	cases is OK or is a bug. My responce from them indicates
	the former. And I would like, as a customer, to feed back that
	this is not acceptable.

2. I would like to feed back the existance of the fault to a higher
	level Seagate support enginneer.

Does anyone know how best to communicate with Seagate to achieve this ?

Cheers

Terry

Cress, Andrew R wrote:
> Terry,
> 
>>From your description in (1) below it sounds like the disk firmware did go
> out to lunch.
> Disk firmware is complex, and there are always possibilities that it can
> hang/crash so that it won't respond, especially since a new disk model comes
> out every 9-12 months.  
> 
> To get a disk firmware problem escalated you will need to gather some
> evidence:
>   1) The current firmware level (you have this already)
>   2) The mode pages of the drive (you can use sgmode or other tools to
> get/set these)
>      See http://scsirastools.sourceforge.net for sgmode
>      One thing to check, is whether SMART on or off has an effect (page 1c
> 0a 88 means completely off).  
>      SMART processing on the drive runs in background on the disk and can
> cause strange errors.
>   3) A SCSI trace of the problem (requires a SCSI analyzer)
>      If you don't have a SCSI analyzer, the bug conditions would have to be
> very well-defined so 
>      that it could be reproduced readily by Seagate.
> 
> Hopefully you can devise a workaround by tweaking the disk mode pages, since
> reporting, analyzing, and producing a new disk firmware version would take
> longer.
> 
> Andy
> 
> -----Original Message-----
> From: Terry Barnaby [mailto:terry@beam.ltd.uk] 
> Sent: Tuesday, March 18, 2003 4:38 AM
> To: Cress, Andrew R
> Cc: 'Ingo Oeser'; Michael Madore; Justin T. Gibbs;
> linux-kernel@vger.kernel.org
> Subject: Re: Reproducible SCSI Error with Adaptec 7902
> 
> 
> Hi Andy,
> 
> We have just updated to the latest driver 1.3.4. This has stopped the
> drive locking up, but we are now getting nasty SCSI error reports
> in /var/log/messages. Will continue to delve into this.
> 
> However, what ever the fault that triggers our drive to lock-up, the
> drive certainly locks up. It locks up with LED on and will not respond
> to a SCSI bus reset. We need to power cycle the system to get the drive
> working again. We have tried two Seagate ST336607LW drives both exibit
> the same behaviour. It appears to only happen when Linux is running in
> SMP mode and when the drive is running in packetized mode.
> 
> So there is certainly the possibility of the Seagate ST336607LW not 
> responding to resets. This may be a firmware fault so we have talked
> to Seagate about the issue. The statement is the result of our direct 
> question:
> 
> 
>>I realise that the problem could be due to the Linux SCSI driver, the
> 
> Motherboard SCSI controller, the SCSI lead or the drive. We are used to
> 
>>tracking down such nasty problems. However, I have one firm pointer:
>>
>>1. Once the drive is locked up, with its LED on, a SCSI bus reset will
>>    not clear the drive. A full poweroff/poweron cycle is needed.
>>
>>So I ask again, is there a case where the drive will not respond to a
>>SCSI bus reset ? 
> 
> 
> Is there any way of getting this information to higher level Seagate 
> support ?
> 
> Terry
> 
> 
> Cress, Andrew R wrote:
> 
>>Ingo,
>>
>>Our testing with that drive (same firmware, using same aic7902 chipset)
> 
> has
> 
>>not shown any problems like this.  However, we were using a later aic79xx
>>driver versions (1.3.x).  That upgrade should be the first step.
>>
>>I wouldn't get too excited about the statement by a level-1 Seagate
> 
> support
> 
>>guy, probably just a blanket statement when they want to disclaim
>>responsibility.  
>>
>>Andy
>>
>>-----Original Message-----
>>From: Ingo Oeser [mailto:ingo.oeser@informatik.tu-chemnitz.de] 
>>Sent: Saturday, March 15, 2003 8:12 AM
>>To: Terry Barnaby
>>Cc: Michael Madore; Justin T. Gibbs; linux-kernel@vger.kernel.org
>>Subject: Re: Reproducible SCSI Error with Adaptec 7902
>>
>>
>>On Fri, Mar 14, 2003 at 04:17:59PM +0000, Terry Barnaby wrote:
>>
>>
>>>The Seagate ST336607LW has firmware: 0004.
>>>Seagate have stated to me that this is the latest.
>>>They have also stated to me:
>>>
>>> Issuing an unrecognized or illegal command to the drive can cause the
>>> drive to go into a hardware fault mode where it will no longer respond,
>>> and may or may not respond to a SCSI BUS reset. It seems, in this case,
>>> the drive will no longer respond to any commands issued by the
>>> controller.
>>>
>>>Is this "feature" now common on SCSI drives ????
>>
>>
>>Could we add a KERN_WARNING printk in sd.c quoting/referencing
>>this message on inquiry detecting this device? 
>>
>>So sysadmins who are used to SCSI being robust could return the
>>drive to their vendors in exchange to a drive working along the
>>SCSI specs after reading this message.
>>
>>Thanks in the name of the sysadmins.
>>
>>Regards
>>
>>Ingo Oeser
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
> 
> 

-- 
Dr Terry Barnaby                     BEAM Ltd
Phone: +44 1454 324512               Northavon Business Center, Dean Rd
Fax:   +44 1454 313172               Yate, Bristol, BS37 5NH, UK
Email: terry@beam.ltd.uk             Web: www.beam.ltd.uk
BEAM for: Visually Impaired X-Terminals, Parallel Processing, Software
                       "Tandems are twice the fun !"

