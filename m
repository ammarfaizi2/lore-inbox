Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbUAYJFn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 04:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbUAYJFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 04:05:43 -0500
Received: from dsl081-085-091.lax1.dsl.speakeasy.net ([64.81.85.91]:12162 "EHLO
	mrhankey.megahappy.net") by vger.kernel.org with ESMTP
	id S263800AbUAYJFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 04:05:40 -0500
Message-ID: <40138599.1030406@jpl.nasa.gov>
Date: Sun, 25 Jan 2004 01:00:09 -0800
From: Bryan Whitehead <driver@jpl.nasa.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.2-rc1-mm3] drivers/usb/storage/dpcm.c
References: <20040125050342.45C3E13A354@mrhankey.megahappy.net> <20040125084141.GA14215@one-eyed-alien.net>
In-Reply-To: <20040125084141.GA14215@one-eyed-alien.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dharm wrote:
> One message a day to report a particular bug is really enough.... :)
> 
> That said, I think it would be better to add the ifdef's instead of more
> substantial code changes.

No problemo, I was just getting my feet wet on small compiler warning 
fixes and the SubmitingPatches doc said ifdefs were from the devil. ;)

I'll sent a patch later sunday...

> 
> Matt
> 
> On Sat, Jan 24, 2004 at 09:03:42PM -0800, Bryan Whitehead wrote:
> 
>>In function dpcm_transport the compiler complains about ret not being used:
>>drivers/usb/storage/dpcm.c: In function `dpcm_transport':
>>drivers/usb/storage/dpcm.c:46: warning: unused variable `ret'
>>
>>ret is not used if CONFIG_USB_STORAGE_SDDR09 is not set. Instead of adding
>>more ifdef's to the code this patch puts ret to use for the other 2 cases in
>>the switch statement (case 0 and default).
>>
>>--- drivers/usb/storage/dpcm.c.orig     2004-01-24 20:51:40.631038904 -0800
>>+++ drivers/usb/storage/dpcm.c  2004-01-24 20:50:05.155553384 -0800
>>@@ -56,7 +56,8 @@ int dpcm_transport(Scsi_Cmnd *srb, struc
>>     /*
>>      * LUN 0 corresponds to the CompactFlash card reader.
>>      */
>>-    return usb_stor_CB_transport(srb, us);
>>+    ret = usb_stor_CB_transport(srb, us);
>>+    break;
>>  
>> #ifdef CONFIG_USB_STORAGE_SDDR09
>>   case 1:
>>@@ -72,11 +73,12 @@ int dpcm_transport(Scsi_Cmnd *srb, struc
>>     ret = sddr09_transport(srb, us);
>>     srb->device->lun = 1; us->srb->device->lun = 1;
>>  
>>-    return ret;
>>+    break;
>> #endif
>>  
>>   default:
>>     US_DEBUGP("dpcm_transport: Invalid LUN %d\n", srb->device->lun);
>>-    return USB_STOR_TRANSPORT_ERROR;
>>+    ret = USB_STOR_TRANSPORT_ERROR;
>>   }
>>+  return ret;
>> }
>>
>>--
>>Bryan Whitehead
>>driver@megahappy.net
>>
> 
> 


-- 
Bryan Whitehead
Email:driver@megahappy.net
WorkE:driver@jpl.nasa.gov
