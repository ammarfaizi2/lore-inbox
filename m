Return-Path: <linux-kernel-owner+w=401wt.eu-S932840AbWLSRLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932840AbWLSRLy (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 12:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932844AbWLSRLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 12:11:54 -0500
Received: from relay.gothnet.se ([82.193.160.251]:6835 "EHLO
	GOTHNET-SMTP2.gothnet.se" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932840AbWLSRLx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 12:11:53 -0500
X-Greylist: delayed 10780 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 12:11:53 EST
Message-ID: <4587F320.4020903@tungstengraphics.com>
Date: Tue, 19 Dec 2006 15:11:44 +0100
From: =?UTF-8?B?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas@tungstengraphics.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060921)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Dave Jones <davej@redhat.com>, Dave Airlie <airlied@linux.ie>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/2] agpgart - allow user-populated memory types.
References: <4579ADE3.6040609@tungstengraphics.com>	 <1165616236.27217.108.camel@laptopd505.fenrus.org>	 <1095.213.114.71.166.1165619148.squirrel@www.shipmail.org>	 <1166518064.3365.1188.camel@laptopd505.fenrus.org>	 <4587B47F.20008@tungstengraphics.com>	 <1166530649.3365.1237.camel@laptopd505.fenrus.org>	 <4587DF61.5020007@tungstengraphics.com> <1166533877.3365.1244.camel@laptopd505.fenrus.org>
In-Reply-To: <1166533877.3365.1244.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-BitDefender-Scanner: Mail not scanned due to license constraints
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, 2006-12-19 at 13:47 +0100, Thomas Hellström wrote:
>   
>> Arjan van de Ven wrote:
>>
>>     
>>>> A short background:
>>>> The current code uses vmalloc only. The potential use of kmalloc was 
>>>> introduced
>>>> to save memory and cpu-speed.
>>>> All agp drivers expect to see a single memory chunk, so I'm not sure we 
>>>> want to have an array of pages. That may require rewriting a lot of code.
>>>>    
>>>>
>>>>         
>>> but if it's clearly the right thing.....
>>> How hard can it be? there are what.. 5 or 6 AGP drivers in the kernel?
>>>
>>>
>>>  
>>>
>>>       
>> Hmm,
>> but we would still waste a lot of memory compared to kmalloc,
>>     
>
> surely it's at most 4Kb for the entire system?
>
>   
Nope. These structures get allocated once per display memory buffer, and 
a display memory buffer may be as large as
the AGP aperture size, (usually up to 512MB) or as small as one page.
The latter could be a user allocating a texture buffer for each 
character in a font, and they can be quite numerous, so we would waste 
almost 4Kb per buffer, which is not acceptable.

> (if agp allows the non-root user to pin a lot more than that in kernel
> memory there is a different problem of rlimits ;)
>
>   
The drm memory manager sets aside and keeps track of a preset amount of 
memory that can be pinned in the kernel for video use, which is shared 
by all users running direct rendering clients. Currently this is a hard 
limit, but the idea is to unlock memory and make it swappable if 
resources become scarce. The memory we're discussing above is included 
in the bookkeeping.

/Thomas



