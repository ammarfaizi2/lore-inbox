Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265708AbSJXXqy>; Thu, 24 Oct 2002 19:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265701AbSJXXqy>; Thu, 24 Oct 2002 19:46:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64273 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265694AbSJXXqw>;
	Thu, 24 Oct 2002 19:46:52 -0400
Message-ID: <3DB887D5.5080500@pobox.com>
Date: Thu, 24 Oct 2002 19:52:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: Steven Dake <sdake@mvista.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] Advanced TCA SCSI Disk Hotswap
References: <200210242342.g9ONgGT04819@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

>>n Advanced TCA (what spawned this work) a button is pressed to
>>indicate  hotswap removal which makes for easy detection of hotswap
>>events.  This is why there are  kernel interfaces for removal and
>>insertion (so a kernel driver can be written to detect  the button
>>press and remove the devices from the os data structures and then
>>light a blue  led indicating safe for removal). 
>>    
>>
>
>OK, I understand what's going on now.  It's no different from those hotplug 
>PCI busses where you press the button and a second or so later the LED goes 
>out and you can remove the card.  10ms sounds rather a short maximum time for 
>a technician to wait for a light to go out....I suppose Telco technicians are 
>rather impatient.
>
>I really think you need to lengthen this interval.  The kernel is moving 
>towards this type of hotplug infrastructure which you can easily leverage (or 
>even help build), but it's definitely going to be mainly in user space.
>  
>


Caveat coder -- you also have to handle the case where the device is 
already gone, by the time you are notified of the hot-unplug event. 
 Some ejections are less friendly than others...  though from a SCSI 
standpoint, hopefully that case is easier -- error out all I/Os in 
flight, and unregister the host and device structures associated with 
the recently-removed host.  The devil, of course, is in the details ;-)

    Jeff




