Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278098AbRJRTgL>; Thu, 18 Oct 2001 15:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278099AbRJRTgB>; Thu, 18 Oct 2001 15:36:01 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:27654 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S278098AbRJRTfv>; Thu, 18 Oct 2001 15:35:51 -0400
Date: Thu, 18 Oct 2001 15:36:21 -0400
Message-Id: <200110181936.f9IJaLF06832@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: VM test on 2.4.13-pre3aa1 (compared to 2.4.12-aa1 and 2.4.13-pre2aa1)
X-Newsgroups: linux.dev.kernel
In-Reply-To: <20011017040907.A2380@athlon.random>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011017040907.A2380@athlon.random> andrea@suse.de wrote:
>On Wed, Oct 17, 2001 at 09:32:12AM +0800, Beau Kuiper wrote:

>> Swapping too much probably has a lot to do with a particular hard drive
>> and its performace. Is there any way of adding a configurable option (via
>> sysctl) to allow the adminstrators to tune how aggressively the kernel
>> swaps out data/vs throwing out the disk cache (so if it is set to
>> agressive, the kernel will try hard to make sure to use swap to free up
>> memory, or if it is set to conservative it will try to free disk cache (to
>> a limit) instead of swapping stuff out to free memory)
>
>I could add a sysctl to control that. In short the change consists of
>making the DEF_PRIORITY in mm/vmscan.c a variable rather than a
>preprocessor #define. That's the "ratio" number I was talking about in
>the last email to Rik, and if you read ac/mm/vmscan.c you'll find it
>there too indeed.

I think that would give people a sense of control.

>That's basically the only number that I left in the code, everything
>else should be completly dynamic behaviour. Anyways also this number
>isn't critical, as said it shouldn't make an huge difference anyways,
>but yes it could be tunable.
>
>However one of the reasons I didn't do that I still believe the vm
>should be autotuning and provide behaviour with concepts, not with
>random tweaking. But I cannot imagine at the moment how to make even
>such fixed number to go away :), so at the moment it could make some
>sense to make it a sysctl.

  I thing it's desirable for VM to run well on autopilot for as many
cases as possible, because Linux is going to be used by some very
non-technical users. However, it is also strong in small machines, old
PCs, embedded uses, etc. These would benefit from tuning the ratio of
swap and buffer use, and also from being able to specify having a large
available page pool, for applications which suddenly need memory which
is a large percentage of physical memory.

| The probe of the cache that allows me to swapouts before we really
| failed shrinking the cache doesn't sounds like random tweaking either to
| me (maybe I'm biased 8), it instead allows to free memory and swapout at
| the very same time, and this seems beneficial.

  If it can work well in common cases for average users, and still allow
tuning by people who have special needs, I'm all for it. I'm sure you
understand the problems with self-tuning VM as well as anyone, I just
want to suggest that for uncommon situations you provide a way for
knowledgable users to handle special situations which need info not
available to the VM otherwise.

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
