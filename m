Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266170AbRF2TsI>; Fri, 29 Jun 2001 15:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266167AbRF2Tr6>; Fri, 29 Jun 2001 15:47:58 -0400
Received: from hacksaw.org ([216.41.5.170]:61929 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S266166AbRF2Tri>; Fri, 29 Jun 2001 15:47:38 -0400
Message-Id: <200106291947.f5TJlUE26243@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.3
To: Craig.McLean@Sun.COM
cc: linux-kernel@vger.kernel.org
Subject: Re: Cosmetic JFFS patch. 
In-Reply-To: Your message of "Fri, 29 Jun 2001 13:00:11 BST."
             <3B3C6DCB.5711888E@Sun.COM> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Jun 2001 15:47:30 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>No 'debug=' could then simply cause the kernel to kprint any info from
>drivers/modules that failed to load, else keep schtum.

My idea is that the driver announces itself, and then what it has 
found/initialized, in the minimum number of screen lines possible. I'd want 
that to be the default, because it gives you a decent idea of where it was if 
it failed.

I am envisioning an algorithm like this:

1. Printk name and version
2. initialize self
3. Hunt for devices, printk when you find one
4. Initialize this device
5. Go back to 3 until you don't detect any more devices
6. Do whatever final thing needs doing

Note that I only advocate the two printk's mentioned explicitly. I think this 
provides just enough of a clue to give one an idea of what might have gone 
wrong, so you might be able to make a quick fix even before needing to enter a 
"tell me everything you are doing" mode for debugging. More might be nice, but 
balance is good.

I agree with some folks that this is way too much from some drivers. The giant 
per CPU tables are an example. That's a useful thing if you are a kernel 
developer, or are trying to debug something weird, but it too much information 
for someone like me, who knows the code works most of the time. If I see an 
error, I'm going to replace the CPU, not write new code.

On the other hand, I do like the v for version, etc thing, but I think I would 
have it like this:

v for version
i for initiation progress (devices and options)
d for debugging (or tell me every major step you take)
q for quiet (Just the kernel version and the word "Loading" and a spinner of 
some sort)
s for "shut up shuttin' up!" (Nothing, or maybe some custom module for the 
embedded installations)

Obviously, the last two are exclusive with the first three. I'd make it so 
including them after the other cancels them, so you could add something 
temporarily without losing your default.

I would default to "vi", no pun intended.



