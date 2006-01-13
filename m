Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161182AbWAMKMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161182AbWAMKMd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 05:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161528AbWAMKMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 05:12:33 -0500
Received: from amdext4.amd.com ([163.181.251.6]:56206 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1161182AbWAMKMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 05:12:32 -0500
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Message-ID: <43C77C1D.3030702@amd.com>
Date: Fri, 13 Jan 2006 11:08:29 +0100
From: "Thomas Dahlmann" <thomas.dahlmann@amd.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Oliver Neukum" <oliver@neukum.org>
cc: linux-usb-devel@lists.sourceforge.net,
       "Jordan Crouse" <jordan.crouse@amd.com>, linux-mips@linux-mips.org,
       linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com
Subject: Re: [linux-usb-devel] [PATCH] UDC support for MIPS/AU1200 and
 Geode/CS5536
References: <20060109180356.GA8855@cosmic.amd.com>
 <200601092344.55988.oliver@neukum.org> <43C39431.6020308@amd.com>
 <200601101440.38853.oliver@neukum.org>
In-Reply-To: <200601101440.38853.oliver@neukum.org>
X-WSS-ID: 6FD9A39D3983386203-01-01
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:

>Am Dienstag, 10. Januar 2006 12:02 schrieb Thomas Dahlmann:
>  
>
>>Oliver Neukum wrote:
>>
>>    
>>
>>>Am Montag, 9. Januar 2006 19:03 schrieb Jordan Crouse:
>>> 
>>>
>>>      
>>>
>>>>>From the "two-birds-one-stone" department, I am pleased to present USB UDC
>>>>support for both the MIPS Au1200 SoC and the Geode CS5535 south bridge.  
>>>>Also, coming soon (in the next few days), OTG, which has been removed from
>>>>the usb_host patch, and put into its own patch (as per David's comments).
>>>>
>>>>This patch is against current linux-mips git, but it should apply for Linus's
>>>>tree as well.
>>>>
>>>>Regards,
>>>>Jordan
>>>>
>>>>   
>>>>
>>>>        
>>>>
>>>+        VDBG("udc_read_bytes(): %d bytes\n", bytes);
>>>+
>>>+        /* dwords first */
>>>+        for (i = 0; i < bytes / UDC_DWORD_BYTES; i++) {
>>>+               *((u32*) (buf + (i<<2))) = readl(dev->rxfifo); 
>>>+        }
>>>
>>>Is there any reason you don't increment by 4?
>>>
>>>	Regards
>>>		Oliver
>>>
>>>
>>>
>>> 
>>>
>>>      
>>>
>>The loop is for reading dwords only, so "i < bytes / UDC_DWORD_BYTES" cuts
>>off remaining 1,2 or 3 bytes which are handled by the next loop.
>>But you are right, incrementing by 4 may look better,  as
>>
>>        for (i = 0; i < bytes - bytes % UDC_DWORD_BYTES; i+=4) {
>>               *((u32*) (buf + i)) = readl(dev->rxfifo); 
>>        }
>>    
>>
>
>Not only will it look better, but it'll save you a shift operation.
>You might even compute start and finish values before the loop and
>save an addition in the body.
>
>	Regards
>		Oliver
>
>
>
>  
>
I have changed this for the next patch release. Thanks for the input !

Regards,
Thomas


