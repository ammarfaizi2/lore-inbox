Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965142AbVHPIaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142AbVHPIaa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 04:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbVHPIaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 04:30:30 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:17083 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S965142AbVHPIaa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 04:30:30 -0400
Message-ID: <4301A5F2.1030805@aitel.hist.no>
Date: Tue, 16 Aug 2005 10:38:10 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joe Peterson <joe@skyrush.com>
CC: mr.fred.smoothie@pobox.com, Vojtech Pavlik <vojtech@suse.cz>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] to drivers/input/evdev.c to add mixer device "/dev/input/events"
References: <4300D09C.4030702@skyrush.com> <20050815174558.GB1450@ucw.cz>	 <4300D845.8070605@skyrush.com> <20050815185729.GA1450@ucw.cz>	 <4300EF7C.9020500@skyrush.com> <161717d505081513066c660129@mail.gmail.com> <4300F9DD.8090005@skyrush.com>
In-Reply-To: <4300F9DD.8090005@skyrush.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Peterson wrote:

>Dave Neuer wrote:
>  
>
>>On 8/15/05, Joe Peterson <joe@skyrush.com> wrote:
>>
>>    
>>
>>>So, overall, I agree that we should not invent hacks to make up for
>>>another software package's problems...
>>>      
>>>
>>but also wrote:
>>
>>
>>    
>>
>>>If the kernel could handle that aspect, it would make all programs more stable.
>>>      
>>>
>>which seems a little contradictory.
>>    
>>
>
>What I was trying to say (and didn't say very well!) is that I agree
>that "hacks" should not be created to mask other problems, but perhaps
>there are ways to solve the problem in the kernel (or in user-space
>programs like udev) that are not hacks and that generally make things
>more elegant all around.
>
>  
>
>>However, Joe continued with:
>>
>>
>>    
>>
>>>It does not sound right to push the handling of the intermittent nature
>>>to each user program.
>>>      
>>>
>>Indeed. Each user program should not care about it. An event/hotplug
>>library should, and the user programs should use that. Like d-bus/HAL.
>>    
>>
>
>Right.  Or, if it makes sense, I was proposing that a new kind of device
>(or device mode) that makes a device ever-present could prevent needless
>handling of plugs and unplugs in applications or X, if that's
>appropriate.  /dev/input/mice is such a device, acting as a catch-all
>for mouse events (and as a byproduct, the specific mouse device chosen
>arbitrarily does not matter to the app).  If it's a hack (as Vojtech
>says), maybe there is a way to get the same functionality in a less
>hackish way.  But Vojtech is right that the kernel should not read
>config files or set "policy," so perhaps something like udev is the
>right place for that kind of thing...
>  
>
Is the kernel really needed for this trick, or could a daemon similiar to
gpm do the job instead?  I.e. the daemon reads the evdev device (when
it is there) and writes to a FIFO. X pulls events out of the other end of
that FIFO.  If the device goes away, the daemon simply waits for it to
reappear, possibly hooking into hotplug if that helps. The FIFO does
not go away, so X is happy.  X just waits till events appear again.

Helge Hafting
