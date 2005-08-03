Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262368AbVHCRj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbVHCRj3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 13:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbVHCRj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 13:39:29 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40951 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262368AbVHCRj2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 13:39:28 -0400
Message-ID: <42F100C8.8040700@mvista.com>
Date: Wed, 03 Aug 2005 10:37:12 -0700
From: Mark Bellon <mbellon@mvista.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] IDE disks show invalid geometries in /proc/ide/hd*/geometry
References: <42EFE547.3010206@mvista.com>	 <Pine.LNX.4.10.10508030018390.21865-100000@master.linux-ide.org> <58cb370e05080310195c244f72@mail.gmail.com>
In-Reply-To: <58cb370e05080310195c244f72@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

>Hi,
>
>The topic was discussed to death on linux-kernel.
>
>Mark, you need to fix your applications and stop using /proc/ide/hd*/geometry
>or/and HDIO_GET_GEO ioctl (which BTW your patch also affects).
>  
>
Fixing the applications I can understand but the patch still seems 
necessary, to me, so the
HDIO_GET_GEO returns "rational" values.

I tested  HDIO_GET_GEO and it returns the same broken values as go into 
/proc (no surprises) without my patch.

If a drive is in LBA mode (28 or 48 bit) the existing code doesn't 
always "fix up" the geometry properly for some value returns. It only 
tries with 48 bit mode and it fails there for some values.  My patch 
forces a complete geometry and appears (to me) to preserve the side 
efefcts of the existing code.

Am I missing something?

mark

>Bartlomiej
>
>On 8/3/05, Andre Hedrick <andre@linux-ide.org> wrote:
>  
>
>>Did you read ATA-1 through ATA-7 to understand all the variations?
>>
>>On Tue, 2 Aug 2005, Mark Bellon wrote:
>>
>>    
>>
>>>The ATA specification tells large disk drives to return C/H/S data of
>>>16383/16/63 regardless of their actual size (other variations on this
>>>return include 15 heads and/or 4092 cylinders). Unfortunately these CHS
>>>data confuse the existing IDE code and cause it to report invalid
>>>geometries in /proc when the disk runs in LBA mode.
>>>
>>>The invalid geometries can cause failures in the partitioning tools;
>>>partitioning may be impossible or illogical size limitations occur. This
>>>also leads to various forms of human confusion.
>>>
>>>I attach a patch that fixes this problem while strongly attempting to
>>>not break any existing side effects and await any comments.
>>>
>>>mark
>>>
>>>Signed-off-by: Mark Bellon <mbellon@mvista.com>
>>>
>>>
>>>      
>>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>>    
>>

