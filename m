Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265139AbUELSuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbUELSuf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 14:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265165AbUELSuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 14:50:35 -0400
Received: from [213.91.247.3] ([213.91.247.3]:60945 "EHLO l.himel.bg")
	by vger.kernel.org with ESMTP id S265139AbUELStx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:49:53 -0400
Message-ID: <40A270D6.1070802@prostak.org>
Date: Wed, 12 May 2004 21:45:42 +0300
From: dobrev <dobrev666@prostak.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Craig Bradney <cbradney@zip.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
References: <409F4944.4090501@keyaccess.nl> <1084280198.9420.5.camel@amilo.bradney.info> <40A0FB04.1000902@prostak.org> <200405122007.46784.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200405122007.46784.bzolnier@elka.pw.edu.pl>
Content-Type: multipart/mixed;
 boundary="------------060400080202040007090006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060400080202040007090006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Bartlomiej Zolnierkiewicz wrote:

>On Tuesday 11 of May 2004 18:10, dobrev wrote:
>  
>
>>Craig Bradney wrote:
>>    
>>
>>>On Tue, 2004-05-11 at 13:24, Rene Herman wrote:
>>>      
>>>
>>>>Bartlomiej Zolnierkiewicz wrote:
>>>>        
>>>>
>>>>>Rene, can you send me copies of /proc/ide/hda/identify and
>>>>>/proc/ide/hdc/identify?
>>>>>          
>>>>>
>>>>Sure, attached. Quite sure you wanted hdc though? That's a DVD-ROM.
>>>>
>>>>        
>>>>
>>>>>I still would like to know why these drives don't accept flush cache
>>>>>commands (or it is a driver's bug?).
>>>>>          
>>>>>
>>>>No idea I'm afraid. Seems at least new Maxtor drives are affected. Both
>>>>the "120P0" (120G, 8M cache) and "L0" (120G, 2M cache) were reported in
>>>>this thread.
>>>>        
>>>>
>>>At a guess the 80P0 drives will also be affected (80G, 8mb cache), but
>>>as yet I havent tried 2.6.6 on the boxes with them. Tonight if theres
>>>time.
>>>
>>>Craig
>>>      
>>>
>>I have Maxtor 6Y060L0 and is also affected. Now I am with 2.6.5.
>>    
>>
>
>Please see http://bugme.osdl.org/show_bug.cgi?id=2672
>  
>

Yes, I know.

>  
>
>>SvrWks IDE controller also have problems with 2.6.6 because the drive
>>works in mdma2 mode.
>>When in 2.6.5 the transfer mode is udma2.
>>    
>>
>
>UDMA2 on OSB4?  Weird.
>
>from serverwoks.c:
>
>	/* If we are about to put a disk into UDMA mode we screwed up.
>	   Our code assumes we never _ever_ do this on an OSB4 */
>
>	if(dev->device == PCI_DEVICE_ID_SERVERWORKS_OSB4 &&
>		drive->media == ide_disk && speed >= XFER_UDMA_0)
>			BUG();
>
>I need more data: .config (2.6.5/2.6.6) and full dmesg output (2.6.5/2.6.6).
>  
>

Yes, it's a OSB4.
I attached files you need. .config is the same.
The problem is that when in 2.6.6 hdparm  reports that the drive is much 
slower than 2.6.5
2.6.6 => 13 MB/s
2.6.5 => 23 MB/s
When I  remove the code related to serverworks.c (see bellow) in 
patch-2.6.6 transfer is like 2.6.5.

>  
>
>>Probably because of this (from patch-2.6.6):
>>diff -Nru a/drivers/ide/pci/serverworks.c b/drivers/ide/pci/serverworks.c
>>--- a/drivers/ide/pci/serverworks.c     Sun May  9 19:33:36 2004
>>+++ b/drivers/ide/pci/serverworks.c     Sun May  9 19:33:36 2004
>>@@ -472,7 +472,9 @@
>>                                int dma = config_chipset_for_dma(drive);
>>                                if ((id->field_valid & 2) && !dma)
>>                                        goto try_dma_modes;
>>-                       }
>>+                       } else
>>+                               /* UDMA disabled by mask, try other DMA
>>modes */+                               goto try_dma_modes;
>>                } else if (id->field_valid & 2) {
>> try_dma_modes:
>>                        if ((id->dma_mword & hwif->mwdma_mask) ||
>>    
>>





--------------060400080202040007090006
Content-Type: application/x-tar;
 name="attach.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="attach.tar.gz"

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
/wM0t1JxAMgAAA==
--------------060400080202040007090006--

