Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbWBMFnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWBMFnh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 00:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbWBMFnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 00:43:37 -0500
Received: from smtpout.mac.com ([17.250.248.71]:19198 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750888AbWBMFnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 00:43:37 -0500
In-Reply-To: <43F0027E.2070207@cfl.rr.com>
References: <Pine.LNX.4.44L0.0602122104330.20351-100000@netrider.rowland.org> <43F0027E.2070207@cfl.rr.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9B9A94E5-F23E-4FCD-83DA-7C2AA9AE86E3@mac.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Flames over -- Re: Which is simpler?
Date: Mon, 13 Feb 2006 00:43:29 -0500
To: Phillip Susi <psusi@cfl.rr.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 12, 2006, at 22:52, Phillip Susi wrote:
> Alan Stern wrote:
>> It's not just semantics.  There's a real difference between  
>> maintaining state in the hardware and maintaining it somewhere  
>> else.  The biggest difference is that if the hardware retains  
>> suspend power, it is able to detect disconnections.  When the  
>> system resumes, it _knows_ whether a device was attached the  
>> entire time, as opposed to being unplugged and replugged (or  
>> possibly a different device plugged in!) while the system was  
>> asleep.  If the hardware is down completely, there is no way of  
>> telling for certain whether a device attached to some port is the  
>> same one that was there when the system got suspended.
>
> During suspend the hardware is usually completely powered off,

This is true for software suspend, but not for hardware suspend (see  
the differences now?)  This is why the two are independent and should  
not be mashed together into one "Generic Suspend".  Let me bring up  
the example of my PowerBook again.  It's RAM is fully powered right  
now, running from battery, and it has another couple days of sleep- 
charge left before I have to worry about plugging it in again.  When  
I open it, the firmware automatically powers up the CPU and other  
hardware and returns control to the OS.  I can _also_ trigger it to  
wake by leaving it closed and connecting an external VGA and USB (it  
wakes every time I connect a USB, but my suspend script puts it to  
sleep again if it's closed and has no external VGA).

> and in either case, there is nothing running on the CPU to monitor  
> device insertion/removal.

You don't need the CPU, just a good USB controller and hubs with low- 
power modes and such.  The fact that plugging in a USB keyboard/mouse  
and a VGA monitor is enough to wake the system when properly  
configured should be proof enough.

> When the system is resumed the kernel decides if the hardware has  
> changed the same way for either system: it probes the hardware to  
> see if it is still there.  There isn't anything special that  
> monitors device insertion/removal while suspended to ram.

Sometimes not, but again, it depends on the hardware.

Cheers,
Kyle Moffett

--
I have yet to see any problem, however complicated, which, when you  
looked at it in the right way, did not become still more complicated.
   -- Poul Anderson



