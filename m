Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbVH3WFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbVH3WFl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 18:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVH3WFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 18:05:41 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:58886 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932493AbVH3WFl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 18:05:41 -0400
Message-ID: <4314D98E.2030801@tmr.com>
Date: Tue, 30 Aug 2005 18:11:26 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: KLive: Linux Kernel Live Usage Monitor
References: <20050830030959.GC8515@g5.random> <Pine.LNX.4.63.0508300954190.1984@cassini.linux4geeks.de> <20050830082901.GA25438@bitwizard.nl> <Pine.LNX.4.63.0508301044150.1984@cassini.linux4geeks.de> <20050830094058.GA29214@bitwizard.nl>
In-Reply-To: <20050830094058.GA29214@bitwizard.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff wrote:
> On Tue, Aug 30, 2005 at 10:53:13AM +0200, Sven Ladegast wrote:
> 
>>>A trick to use would be to send an UDP packet at boot (after 1 minute
>>>or so), and then randomly say "once a month" (i.e. about 1/30 chance of
>>>sending a packet on the first day) The number of these random packets
>>>recieved is a measure of the number of CPU-months that the kernel
>>>runs.
>>
>>This could be a sloution but like you know UDP packets may or may not 
>>arrive the destination address. So the packet loss with this method could 
>>be very high, expecially if you send only one packet. Using a 
>>TCP-connection for this is a lot more stable and the payload can be 
>>encrypted too.

The information will be public anyway, what's the gain. This is a way 
for people to voluntarily give you information, keep it simple. And to 
that end run it as a user program. It should call home at start (boot), 
stop, and from time to time to prove it's up. A single UDP packet can do 
all that, and if you see machine X boot 2.6.99-rc5 and drop back to rc4 
in ten minutes, that's valuable information. And if people stop running 
the test kernel and drop back to a vendor kernel, THAT'S valuable info 
as well. Time of use is not the only indication here, fallback is an 
indication that a kernel boot was not pleasing in some way.
> 
> 
> The "load" that an UDP packet poses on a system is much lower than
> for a TCP connection. The fact that UDP packets sometimes get lost
> is not much of an issue: Those packets simply wouldn't get logged.
> So what?
> 
> In 90%  (my guess, 90% of statistics is made up....) of the cases 
> where the first packet doesn't reach the destination, any subsequent
> packets also wouldn't. So if it is so unimportant as here, why bother
> with the more overhead of the TCP connection?

Your assumption is unrealistic, a fair number of routers start dropping 
packets under load, ping first, then some other icmp, then udp, tcp last 
(usually).
> 
> The "in kernel module" that might send this, could put some easily
> gathered information into the packet. The goal of logging kernels-
> that-get-run would then be met. Installing a userspace program is
> something that most testers won't be bothered to do.

I think you have it backward, people will add a user program after the 
fact, they may not recompile just to add a feature.
> 
> A kernel option that is clearly documented what exact info is logged
> would IMHO work better. (A userspace program is technically a better
> solution, the social aspect of getting a bigger user-base is the main
> reason for me to suggest the in-kernel approach).

The social issue is that on a stable machine I'm not going to change the 
kernel, but any one user can run the program to provide usage without 
having access to anything important, so I can install this as nobody or 
it's own UID, and feel better than putting it in my kernel.
> 
> (the people who go upgrading kernels tend to be different people from
> those who go installing programs for fun.)

Part of my testing involves booting a kernel and seeing if it stays up, 
the user program could be added after the fact.

The kernel info, memory, CPU, and machine name can be gotten without 
privs, as can uptime. As far as how to install it, provide a script and 
put it in cron (system or user). So you can actually track so info on 
the system, like load. A week running while I was on vacation doesn't 
test much, a week running on a loaded server tests other things.

The use will depend on how easy it is to install, patch and build isn't 
easy. Crontab is. And I bet developers would be interested in how long 
it takes a new release to be used in production. There are lots of 
things you could add, but get it working first.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
