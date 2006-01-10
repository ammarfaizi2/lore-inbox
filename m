Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWAJLEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWAJLEr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 06:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWAJLEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 06:04:47 -0500
Received: from amdext4.amd.com ([163.181.251.6]:51592 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S932109AbWAJLEq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 06:04:46 -0500
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Message-ID: <43C39431.6020308@amd.com>
Date: Tue, 10 Jan 2006 12:02:09 +0100
From: "Thomas Dahlmann" <thomas.dahlmann@amd.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Oliver Neukum" <oliver@neukum.org>
cc: linux-usb-devel@lists.sourceforge.net,
       "Jordan Crouse" <jordan.crouse@amd.com>, linux-mips@linux-mips.org,
       linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com
Subject: Re: [linux-usb-devel] [PATCH] UDC support for MIPS/AU1200 and
 Geode/CS5536
References: <20060109180356.GA8855@cosmic.amd.com>
 <200601092344.55988.oliver@neukum.org>
In-Reply-To: <200601092344.55988.oliver@neukum.org>
X-WSS-ID: 6FDD4BE53982923370-01-01
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oliver Neukum wrote:

>Am Montag, 9. Januar 2006 19:03 schrieb Jordan Crouse:
>  
>
>>>From the "two-birds-one-stone" department, I am pleased to present USB UDC
>>support for both the MIPS Au1200 SoC and the Geode CS5535 south bridge.  
>>Also, coming soon (in the next few days), OTG, which has been removed from
>>the usb_host patch, and put into its own patch (as per David's comments).
>>
>>This patch is against current linux-mips git, but it should apply for Linus's
>>tree as well.
>>
>>Regards,
>>Jordan
>>
>>    
>>
>+        VDBG("udc_read_bytes(): %d bytes\n", bytes);
>+
>+        /* dwords first */
>+        for (i = 0; i < bytes / UDC_DWORD_BYTES; i++) {
>+               *((u32*) (buf + (i<<2))) = readl(dev->rxfifo); 
>+        }
>
>Is there any reason you don't increment by 4?
>
>	Regards
>		Oliver
>
>
>
>  
>
The loop is for reading dwords only, so "i < bytes / UDC_DWORD_BYTES" cuts
off remaining 1,2 or 3 bytes which are handled by the next loop.
But you are right, incrementing by 4 may look better,  as

        for (i = 0; i < bytes - bytes % UDC_DWORD_BYTES; i+=4) {
               *((u32*) (buf + i)) = readl(dev->rxfifo); 
        }


Thanks,
Thomas

