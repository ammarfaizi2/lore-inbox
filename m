Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270750AbTGNRZf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 13:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270748AbTGNRWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 13:22:45 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:47246 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S270700AbTGNRVj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 13:21:39 -0400
Message-ID: <3F12E8F0.5020107@rackable.com>
Date: Mon, 14 Jul 2003 10:31:28 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Ruth.Ivimey-Cook@ivimey.org,
       Chad Kitching <CKitching@powerlandcomputers.com>,
       Steven Dake <sdake@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: IDE/Promise 20276 FastTrack RAID Doesn't work in 2.4.21, patchattached
 to fix
References: <Pine.SOL.4.30.0307121754050.19333-100000@mion.elka.pw.edu.pl> <200307121801.03776.ruth@ivimey.org>
In-Reply-To: <200307121801.03776.ruth@ivimey.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jul 2003 17:36:27.0685 (UTC) FILETIME=[744FE550:01C34A2E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruth Ivimey-Cook wrote:

>On Saturday 12 Jul 2003 5:14 pm, Bartlomiej Zolnierkiewicz wrote:
>  
>
>>I think you just need "pdc_ide=0,force" and "pdc_ide=0,noforce".
>>No need to complicate things.
>>Remember that ataraid is only software RAID driver and pdc202xx_new
>>is a chipset driver.
>>

  Doesn't the following already work "ide2=0 ide3=0 ...." for the 
promise binary driver?

>
>I am not forgetting, but I don't like this idea of 'force' -- it instantly 
>raises the question 'force what' and then you're in the quagmire again.
>
>Better to tell the kernel what you want and let the kernel worry about how to 
>make it happen.
>
>So the "pdc_ide2=jbod"  would be scanned and interpreted as a request to 
>activate ('force') the drive into IDE mode and not enable any ataraid (jbod 
>==> just disks),
>
>while "pdc_ide3=promise" would let the drive state be, and make the kernel do 
>a "modprobe promise-ft" (or whatever it's called) to load the rest of the 
>driver, as is done for 'scsi-hostadapter'. [Would you ever have to force a 
>promise chip into promise-raid mode?].
>

  This is getting really complex.  Weren't we trying to make things 
simple?  The simple solution is to have the single option, and let user 
space (initrd) determine if you want to load the pdcraid driver. 

>
>Do you see what I mean?
>
>If you prefer, the string could be "pdc=ide2:ide, ide3:ataraid".
>
>  
>
>>jbod/raid should be managed by ataraid driver not ide or pdc202xx_new.
>>    
>>
>
>I was using jbod as just that, not as meaning raid-0 or similar. Perhaps I 
>should have been clearer. So you've a choice of (just IDE), (RAID via 
>ataraid) and (RAID via Promise)
>
>  
>

  No you really have only 2 options.
1)Let linux see the ide controller.
2)Don't then linux see the ide controller.

#1 Will only see ataraid partitions if there exists a promise raid 
configuration, and the pdcraid driver is loaded.

>
>  
>
>>>Should I think about coding this?
>>>      
>>>
>>No, think about porting ataraid and pdcraid to 2.5 first.
>>    
>>
>
>pdcraid == ataraid module for PDC?? Haven't looked at the src yet.
>  
>
  Yes unless you insert the pdcraid module.  Linux will only see the raw 
drives.  Once you insert pdcraid you can see the raid devices, and raw 
disks.  Which can cause major issues at times.

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


