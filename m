Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbUBZAVN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 19:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262399AbUBZAVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 19:21:13 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:23312 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262274AbUBZAU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 19:20:56 -0500
Message-ID: <403D3E47.4080501@techsource.com>
Date: Wed, 25 Feb 2004 19:31:03 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: John Lee <johnl@aurema.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <Pine.GSO.4.03.10402260834530.27582-100000@swag.sw.oz.au>
In-Reply-To: <Pine.GSO.4.03.10402260834530.27582-100000@swag.sw.oz.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



John Lee wrote:
> 
> On Wed, 25 Feb 2004, Timothy Miller wrote:
> 
> 
>>Well, considering that X is suid root, it's okay to require that it be 
>>run at nice -15, but how is the user without root access going to renice 
>>xmms?  
> 
> 
> Hm, I would have thought the vast majority of xmms users would be running
> it on their own machines, to which they have root access. Hope I'm not 
> missing something here... :-)

It's a security concern to have to login as root unnecessarily.  It's 
bad enough we have to do that to change X11 configuration, but we 
shouldn't have to do that every time we want to start xmms.  And just 
suid root is also a security concern.

> 
> 
>>Even for those who do, they're not going to want to have to 
>>renice xmms every time they run it.  Furthermore, it seems like a bad 
>>idea to keep marking more and more programs as suid root just so that 
>>they can boost their priority.
> 
> 
> Assuming that all/most xmms users do have root permissions, I would think
> that this is a very minor inconvenience... isn't xmms something which you
> tend to start up once and leave running until you log out?

This is a bad assumption.  You should never require users to login as 
root to do basic user-oriented tasks.  Indeed, it's often nice to have 
an icon or menu option to start it without having to pull up a terminal, 
and if the program ASKS for the root password, it's annoying to have to 
type that in just to get it to start.

Under Solaris, a number of device nodes (sound, serial ports, etc.) have 
their ownership changed to that of the user who logs into the console. 
This is so that they can access those devices without logging in as root.

What about computer labs of Linux boxes where users do not own the 
computers and are therefore not allowed to login as root.  Should they 
be prohibited from running xmms properly?

For a while, the sysadmin here at work tried to deploy Windows boxes 
with restricted user priveleges, and the users were not given the admin 
password.  For the engineers, that changed, fortunately.  But consider 
what would happen if Linux boxes were deployed that way.  It would suck 
if Windows users could still listen to MP3's during heavy CPU usage but 
Linux users could not.  There are many good reasons to lock down 
workstations and not provide root access.

> 
> I don't think xmms needs to be an suid program, it can just be given a
> renice once (ie. more shares, -9 ==> 101 shares, which is 5 times
> the default, just my choice) and then left alone. Furthermore, the
> controls that my patch features are intended to be exercised as root,
> normal users can do less (as for nice, you can give your own processes
> less shares but not more, and can apply _more_ restrictive CPU caps on
> your tasks).

If someone does not own the box they're using, but they want to, say, 
contribute to xmms development, they're going to be starting and 
stopping the program quite frequently.  They're not going to have any 
way to set the nice level.

Consider what happens if some other user logs in remotely to that 
workstation and starts a large compile.

>>From my testing so far, X and xmms have been the only candidates for a
> shares increase, as these two have been the most talked about :-).
> And after all, one purpose of the patch is to allow users to allocate CPU
> to their tasks in any way they deem fit.

They are the most talked about, so you tested them.  Fine.  But we all 
know that they are not representative samples.  There are bound to be 
numerous other programs that have similar problems.

The way your scheduler works, USERS cannot "allocate CPU to their tasks 
in any way they deem fit".  Only system administrators can.

> 
>>Not to say that your idea is bad... in fact, it may be a pipe dream to 
>>get "flawless" interactivity without explicitly marking which programs 
>>have to be boosted in priority.  Still, Nick and Con have done a 
>>wonderful job at getting close.
> 
> 
> They have indeed, there haven't been any "poor interactivity" emails for a
> while now :-).
> 
> Good interactivity was just one of my goals, I was also aiming for better
> CPU resource allocation and simplification of the main code paths in the
> scheduler by doing away with heuristics, and therefore better throughput.

I read your paper, and I think you have some wonderful ideas.  Don't get 
me wrong.  I think that your ideas, coupled with an interactivity 
estimator, have an excellent chance of producing a better scheduler.

In fact, that may be the only "flaw" in your design.  It sounds like 
your scheduler does an excellent job at fairness with very low overhead. 
  The only problem with it is that it doesn't determine priority 
dynamically.


