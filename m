Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268774AbUHLVAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268774AbUHLVAo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268785AbUHLVAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:00:43 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:32131 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S268774AbUHLVAU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:00:20 -0400
Message-ID: <411BDB25.8070503@tmr.com>
Date: Thu, 12 Aug 2004 17:03:33 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: V13 <v13@priest.com>
CC: Martin Mares <mj@ucw.cz>, Joerg Schilling <schilling@fokus.fraunhofer.de>,
       axboe@suse.de, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <20040806231529.GA9997@ucw.cz><20040806231529.GA9997@ucw.cz> <200408071331.38793.v13@priest.com>
In-Reply-To: <200408071331.38793.v13@priest.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

V13 wrote:
> On Saturday 07 August 2004 02:15, Martin Mares wrote:
> 
>>Hello!
>>
>>
>>>Let me lead you to the right place to look for:
>>>
>>>	The CAM interface (which is from the SCSI standards group)
>>>	usually is implemeted in a way that applications open /dev/cam and
>>>	later supply bus, target and lun in order to get connected
>>>	to any device on the system that talks SCSI.
>>>
>>>Let me repeat: If you believe that this is a bad idea, give very good
>>>reasons.
>>
>>There is one: hotplug. The physical topology of buses where all the
>>SCSI-like devices (being it ATAPI devices, iSCSI, USB disks or other such
>>beasts) are connected is too complex, so every attempt to map them to the
>>(bus, target, lun) triplets in any sane way is destined to fail.
> 
> 
> Just to add on this, how is someone supposed to distinguish between two 
> identical USB recorders using the scanbus/X:Y:Z method? I suppose he'll have 
> to try writting to both drives each time he replugs them instead of 
> having /dev/cdr-red /dev/cdr-blue or something similar using hotplug/udev.

cat /proc/scsi/usb-storage/*

There is a utility (name escapes me) which allows binding of a NIC to a 
name by MAC address, it would be nice to be able to bind by serial 
number for IDE/SCSI/USB devices. However, until you do that, a simple 
script to create a few symlinks after discovery will solve your problem. 
Doesn't bug me enough to bother, but that's how.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
