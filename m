Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264449AbUAMRDq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 12:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264452AbUAMRDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 12:03:46 -0500
Received: from gizmo01bw.bigpond.com ([144.140.70.11]:56994 "HELO
	gizmo01bw.bigpond.com") by vger.kernel.org with SMTP
	id S264449AbUAMRDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 12:03:42 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Jesse Allen <the3dfxdude@hotmail.com>
Subject: Re: NForce2, Ross Dickson's timer patch on 2.6.1
Date: Wed, 14 Jan 2004 02:56:30 +1000
User-Agent: KMail/1.5.1
Cc: Ian Kumlien <pomac@vapor.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401140256.30727.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Allen wrote: 
> Hi Ross, 
 > 
 > I have a version of your timer patch (io_apic.c) for kernel 2.6.1. It is 
 > attached. I have been monitoring a problem with it. It seems that with the 
 > patch, I gain 1 seconds time over 10 minutes (roughly). So I gain about 2-3 
 > mintues a day. I haven't taken exact measurements, but I know it ends up about 
 > 20 minutes difference after a week. This is not good, which would require 
 > resetting the time often. 

Not a good thing. 
I have not noticed it on my patched 2.4.24 kernel, it seems to keep
good time with the clock on the wall. I will have to check further to be certain.
I do not run 2.6.x by default as yet.

 > 
 > I tried the 2.6.1 kernel without the timer patch. The timer is now back in PIC 
 > mode, and interrupt 7 has the old noise. Synched the time with my watch. At 
 > first, I noticed no gain in time over 10 minutes. However the next day, I found 
 > it gained 1-2 seconds. Now it is about 7 seconds ahead a few days later now. 
 > This is much better. 
 > 
 > So I'm left to thinking, the patch does two things, maybe one thing right, and 
 > one possibly very wrong: 
 > 
 > 1) It does place the timer in APIC mode. 
 > 2) But the timer seems to be fed extra interrupts, maybe the same that is found 
 > on irq 7 without the patch (is this possible?) 
 > 
 > I remember someone making a comment which might explain the issue: 
 > http://marc.theaimsgroup.com/?l=linux-kernel&m=107098440019588&w=2 
 > 
 > I don't think the patch was much different now than it was then. So I think 
 > there is something wrong with setting up the timer this way. I don't know if 
 > you worked something out with Maciej. I don't know much about interrupt 
 > controller programming so... if maybe you can explain to me anything I'm 
 > missing. For now I've dropped the patch. 

We looked into the issue, these emails (was my 2.4.23 kernel) indicate that
the 8259 PIC is fully masked off when the check timer looked for interrupts.

http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/2288.html
http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/2375.html

So if there are additional interrupts getting into irq0 then they are very 
unexpected and may be from an undocumented source? Or perhaps something
is different in counting time in 2.6.x wrt 2.4.xx? Could the same interrupt
occasionally be getting counted twice or something?

 > 
 > 
 > Jesse 
 > 
 > 
 > PS: I have run with disconnect on, and without your ack patch since I got that 
 > surpise BIOS update. No lockups have occurred in the past month, since that.
 So the disconnect problem is a BIOS bug. (Shuttle has not responded) 
 >

I would love a bios update like that for my motherboards!
Given Daniel has had lockups with disconnect off.
http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/4769.html
And your machine no longer has them with disconnect on, then I now think the
cause is something different to the AMD C1 disconnect issue, but what I do not
know? I believe AMD are still looking into it as per my support request.

I would really like to hear from Nvidia on this issue, I have tried emailing
them, form mailing them and also posting to their linux forum with no success or
response. Given its been over a month since my first posting I am having
serious second thoughts about my choice of chipsets and motherboards!
I currently do not feel very warm and fuzzy about their linux support!

 > PSS: CC me, I'm not subscribed right now. 

