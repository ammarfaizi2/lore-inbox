Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWITViV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWITViV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 17:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWITViV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 17:38:21 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:56575 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S932141AbWITViU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 17:38:20 -0400
Date: Wed, 20 Sep 2006 17:38:07 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.18-rt1
In-reply-to: <20060920200627.GE1292@us.ibm.com>
To: linux-kernel@vger.kernel.org, paulmck@us.ibm.com
Cc: Daniel Walker <dwalker@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Message-id: <200609201738.07519.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20060920141907.GA30765@elte.hu>
 <1158777240.29177.16.camel@c-67-180-230-165.hsd1.ca.comcast.net>
 <20060920200627.GE1292@us.ibm.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 September 2006 16:06, Paul E. McKenney wrote:
>On Wed, Sep 20, 2006 at 11:34:00AM -0700, Daniel Walker wrote:
>> On Wed, 2006-09-20 at 11:25 -0700, Paul E. McKenney wrote:
>> > BUG: unable to handle kernel NULL pointer dereference at virtual
>> > address 00000000 printing eip:
>> > c01151ff
>> > *pde = 34d21001
>> > *pte = 00000000
>> > stopped custom tracer.
>> > Oops: 0000 [#1]
>> > PREEMPT SMP
>> > Modules linked in:
>> > CPU:    2
>> > EIP:    0060:[<c01151ff>]    Not tainted VLI
>> > EFLAGS: 00010246   (2.6.18-rt2-autokern1 #1)
>> > EIP is at __wake_up_common+0x10/0x55
>>
>> I get this too, it happens when HRT is off.. If you turn HRT on it will
>> boot .. I haven't found a fix for it, but I imagine Thomas will find it
>> soon.
>
>Enabling HRT works for me too -- thanks to you and Thomas for the hint!
>
>       Thanx, Paul

Well, enabling HRT allowed it to boot, but there are several casualties.  

For some reason, "heyu turn a14 off" which works with non-rt kernels, seems 
to hang forever, or until its ctl-c'd.  And all my control scripts that 
use heyu fail.  I killed the background processes that my startup script 
starts, re-ran them by hand and now its working.  Shakes head in 
puzzlement...

Tvtime is still dead, sits in a blue screen & no sound.  I have a cx88 
tvaudio process running at -5 nice that I can't kill, if I do its back on 
the next htop refresh.

/usr/local/bin/upsd (the belkin supplied version) is using up to half the 
cpu.  The cpu of course is running 10F warmer.  And a SIGHUP from htop 
killed it.  And restarting it via an "sh ./S99bulldog" causes a repeat of 
its cpu hogging.

Audacity-1.2.4 takes 30 seconds to clear the busy icon when started with no 
arguments from the icon.  I don't recall observing that before, but its 
been a while since I ran it for any reason too, so my memory could be hazy 
on that.

Hot-babe, (a debian toy) when running, looks normal, but uses 20% of the 
cpu, which contributes to the strip job. :)

All in all, it could be worse.  Now I have to shut down and replace the 
ailing battery in my ups, it just walked in the door.  And that has 
nothing to do with this kernel 2.6.18-rt2.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
