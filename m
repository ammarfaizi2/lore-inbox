Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269650AbTGJWJn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 18:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269652AbTGJWJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 18:09:42 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:334 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S269650AbTGJWIK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 18:08:10 -0400
Message-ID: <3F0DE61B.1020207@rackable.com>
Date: Thu, 10 Jul 2003 15:18:03 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chad Kitching <CKitching@powerlandcomputers.com>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Steven Dake <sdake@mvista.com>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org, frankt@promise.com
Subject: Re: IDE/Promise 20276 FastTrack RAID Doesn't work in 2.4.21, patchattached
 to fix
References: <18DFD6B776308241A200853F3F83D507279B@pl6w2kex.lan.powerlandcomputers.com>
In-Reply-To: <18DFD6B776308241A200853F3F83D507279B@pl6w2kex.lan.powerlandcomputers.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jul 2003 22:22:50.0639 (UTC) FILETIME=[CC7F99F0:01C34731]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chad Kitching wrote:

>I don't know.  That seemed to have changed the option from merely mystifying to down right confusing.  By that wording, does that feature override it into being a plain IDE controller, or an IDE RAID controller?  The new name seems to imply the former, while the mentions of ataraid suggest the latter.
>
>Despite the grammatical errors, pdc202xx.c's comments perhaps describe it better.
>* Linux kernel will misunderstand FastTrak ATA-RAID series as Ultra
>* IDE Controller, UNLESS you enable "CONFIG_PDC202XX_FORCE"
>* That's you can use FastTrak ATA-RAID controllers as IDE controllers.
>  
>

  I stopped reading the comments as they made my brain hurt more than 
reading the ide driver code;-)

>If this is true, may I suggest something more along the lines of:
>
>Ignore FastTrak BIOS and configure controller for RAID
>CONFIG_PDC202XX_FORCE
>  Forces the driver to use the ATA-RAID capabilities, overriding the
>  BIOS configuration of the controller. Do not enable if you are
>  using Promise's binary module.  This option is compatible with the 
>  ataraid driver.
>

  This is completely wrong in my experience.  In many configs linux's 
ide driver will ignore the controller entirely without  
CONFIG_PDC202XX_FORCE.  In these cases you can't use the disk as either 
ide disks, or ataraid disks.  (Keep in mind you can access the raw disk 
even if ataraid is loaded.)  This seems to be true of the enbedded 
promise controllers found on intel and tyan boards.  A few newer intel 
boards will allow you to toggle between ataraid, and ide modes in the 
bios.  In this case you don't need CONFIG_PDC202XX_FORCE to see the drives.

>
>If the Linux driver has the same limitation in regards to using CD-ROM drives on the controller while it's in RAID mode as the Windows drivers do, it may be useful to mention the fact that the option is incompatible with CD-ROM drives attached to the controller.
>
>Of course, maybe it means the complete opposite, and I'm reading everything wrong, in which case, there are some comments you may want to fix, too.
>
>-----Original Message-----
>From: Samuel Flory
>Sent: July 10, 2003 4:11 PM
>Subject: Re: IDE/Promise 20276 FastTrack RAID Doesn't work in 2.4.21,
>patchattached to fix
>
>
>Bartlomiej Zolnierkiewicz wrote:
>
>  
>
>>Hi,
>>
>>Do you have "Special FastTrak Feature" enabled?
>>    
>>
>  
>Can we change the option to something that makes sense.  I get the 
>feeling no one understands what it does at 1st glance.  This is the 2nd 
>time I've seen a patch like this. 
>  
>


-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


