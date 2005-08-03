Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbVHCQzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbVHCQzj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 12:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262349AbVHCQzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 12:55:39 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:1526 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262347AbVHCQzZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 12:55:25 -0400
Message-ID: <42F0F6DD.6070205@mvista.com>
Date: Wed, 03 Aug 2005 09:54:53 -0700
From: Mark Bellon <mbellon@mvista.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH]  IDE disks show invalid geometries in /proc/ide/hd*/geometry
References: <Pine.LNX.4.10.10508030018390.21865-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10508030018390.21865-100000@master.linux-ide.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:

>Did you read ATA-1 through ATA-7 to understand all the variations?
>  
>
Regardless of all of the geometry returns by the drives and their ATA 
compliance, the existing code will fail for some drives and return 
values. For instance, the existing code attempts to "fix up" LBA 48 
fails to handle LBA 28. In both cases the "fix up" code appears errant - 
it doesn't create a complete, valid geometry.

My patch attempts to preserve the flow and side effects of the existing 
code while handling all of the boundary cases. Given the way the 
original code appears to read one should be able to "fix up" things 
without regard for the ATA compliance of a drive.

It might help to read the code before and after my patch is applied. The 
explaination and patch alone don't make it easy to see what I think is a 
simple fix.

mark

>On Tue, 2 Aug 2005, Mark Bellon wrote:
>
>  
>
>>The ATA specification tells large disk drives to return C/H/S data of 
>>16383/16/63 regardless of their actual size (other variations on this 
>>return include 15 heads and/or 4092 cylinders). Unfortunately these CHS 
>>data confuse the existing IDE code and cause it to report invalid 
>>geometries in /proc when the disk runs in LBA mode.
>>
>>The invalid geometries can cause failures in the partitioning tools; 
>>partitioning may be impossible or illogical size limitations occur. This 
>>also leads to various forms of human confusion.
>>
>>I attach a patch that fixes this problem while strongly attempting to 
>>not break any existing side effects and await any comments.
>>
>>mark
>>
>>Signed-off-by: Mark Bellon <mbellon@mvista.com>
>>
>>
>>    
>>
>
>  
>

