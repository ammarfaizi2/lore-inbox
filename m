Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263254AbSITSlb>; Fri, 20 Sep 2002 14:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263274AbSITSlb>; Fri, 20 Sep 2002 14:41:31 -0400
Received: from dyn-212-129-50-216.ppp.tiscali.fr ([212.129.50.216]:35084 "EHLO
	calvin.paulbristow.lan") by vger.kernel.org with ESMTP
	id <S263254AbSITSla>; Fri, 20 Sep 2002 14:41:30 -0400
Message-ID: <3D8B6C96.6080406@paulbristow.net>
Date: Fri, 20 Sep 2002 20:44:38 +0200
From: Paul Bristow <paul@paulbristow.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miles Lane <miles.lane@attbi.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dont understand hdc=ide-scsi behaviour.
References: <200209192108.g8JL8iT6010419@orion.dwf.com>	 <200209201646.00202.bhards@bigpond.net.au> <1032533179.4526.102.camel@firehose.megapathdsl.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the line
    hdc=ide-scsi hdd=ide-floppy

and all should be well, even if using ide-floppy as a module

Miles Lane wrote:

>On Thu, 2002-09-19 at 23:46, Brad Hards wrote:
>  
>
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>On Fri, 20 Sep 2002 07:08, Reg Clemens wrote:
>>    
>>
>>>I dont understand the behaviour of kernel 2.4.18 (and probably all others)
>>>when I put the line
>>>		hdc=ide-scsi
>>>on the load line.
>>>
>>>I would EXPECT to get the ide-scsi driver for hdc (my cdwriter) but instead
>>>get it for BOTH hdc and hdd, the cdwriter and the zip drive.
>>>
>>>After starting this way (with hdc=ide-scsi), I find that
>>>	/dev/cdrom2 -> /dev/scd0
>>>and that to access the zip drive I have to use /dev/sda1 (or /dev/sda4)
>>>      
>>>
>>There are two slightly different things happening, I think.
>>
>>1. When you say hdc=ide-scsi, you are telling the IDE system that you don't 
>>want to use the normal IDE interfaces to userland (such as ide-cdrom), but 
>>instead want all access to this device to be accessed through the SCSI 
>>midlayer (and associated SCSI interfaces, like the sg and scd drivers). So 
>>ide-scsi becomes the driver, instead of ide-cdrom. You should be able to see 
>>this in /proc/ide/hdc/driver
>>
>>2. ide-scsi is greedy, and will grab any IDE device without a driver. ATAPI 
>>floppy devices (hopefully) like your zip drive need the IDE floppy device 
>>driver, which is probably not loaded. What does CONFIG_BLK_DEV_IDEFLOPPY 
>>equal in your kernel config?
>>    
>>
-- 

Paul

Email:	paul@paulbristow.net
Web:	http://paulbristow.net
ICQ:	11965223


