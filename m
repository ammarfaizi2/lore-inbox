Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbVEZSgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVEZSgH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 14:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVEZSgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 14:36:07 -0400
Received: from unicorn.rentec.com ([216.223.240.9]:61678 "EHLO
	unicorn.rentec.com") by vger.kernel.org with ESMTP id S261688AbVEZSgC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 14:36:02 -0400
X-Rentec: external
Message-ID: <42961700.5090005@rentec.com>
Date: Thu, 26 May 2005 14:35:44 -0400
From: Wolfgang Wander <wwc@rentec.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Borislav Petkov <petkov@uni-muenster.de>, pharon@gmail.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc5-mm1 alsa oops
References: <1117092768.26173.4.camel@localhost>	 <200505261944.50942.petkov@uni-muenster.de>	 <1117130470.5477.5.camel@mindpipe>	 <200505262012.45833.petkov@uni-muenster.de> <1117132339.5477.20.camel@mindpipe>
In-Reply-To: <1117132339.5477.20.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Logged: Logged by unicorn.rentec.com as j4QIZi0Y009346 at Thu May 26 14:35:46 2005
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Thu, 2005-05-26 at 20:12 +0200, Borislav Petkov wrote:
> 
>>On Thursday 26 May 2005 20:01, Lee Revell wrote:
>>
>>>On Thu, 2005-05-26 at 19:44 +0200, Borislav Petkov wrote:
>>>
>>>><snip>
>>>>
>>>>Andrew,
>>>>
>>>>similar oopses as the one I'm replying to all over the place. At it
>>>>happens m in snd_pcm_mmap_data_close(). Here's a stack trace:
>>>
>>>No one using ALSA CVS or any of the 1.0.9 release candidates ever
>>>reported this, but lots of -mm users are... does that help at all?  I
>>>suspect some upstream bug that ALSA just happens to trigger.
>>
>>yeah,
>>
>>this has to do with alsa indirectly. snd_pcm_mmap_data_close() accesses some 
>>vm_area_struct->vm_private_data and apparently there have been some 
>>optimizations to mmap code to avoid fragmentation of vma's so i think there's 
>>the problem. However, we'll need the smarter ones here :))
> 
> 
> Any idea which patches to back out?


avoiding-mmap-fragmentation-fix-2.patch

seems to do the trick. Ken will likely have a fix-3 shortly ;-)

             Wolfgang
