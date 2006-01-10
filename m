Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932583AbWAJUZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbWAJUZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbWAJUZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:25:59 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:28092 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932583AbWAJUZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:25:58 -0500
Date: Tue, 10 Jan 2006 21:25:46 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andi Kleen <ak@suse.de>
cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Console debugging wishlist was: Re: oops pauser.
In-Reply-To: <p73vewtw8bh.fsf@verdi.suse.de>
Message-ID: <Pine.LNX.4.61.0601102121400.16049@yvahk01.tjqt.qr>
References: <20060105045212.GA15789@redhat.com> <p73vewtw8bh.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Ok - here's my personal wishlist. If someone is interested ...
>
>What I would like to have is a "more" option for the kernel that makes
>it page kernel output like "more" and asks you before scrolling
>to the next page.

An oops is usually a condition you can recover from in some/most/depends 
cases (e.g. a null deref in a filesystem "only" makes that vfsmount 
(filesystem at all?) blocked), so if the kernel is waiting for user input 
on a non-panic condition, this means userspace stops too, which is not 
too good if the kernel is still 'alive'.
It's like we are entering kdb although everything is fine enough to go 
through a proper `init 6`.

>What would be also cool would be to fix the VGA console to have 
>a larger scroll back buffer.  The standard kernel boot output 
>is far larger than the default scrollback, so if you get a hang
>late you have no way to look back to all the earlier 
>messages.
>
>(it is hard to understand that with 128MB+ graphic cards and 512+MB
>computers the scroll back must be still so short...) 

I doubt this scrollback buffer is implemented as part of the video cards. 
It is rather a kernel invention, and therefore uses standard RAM. But the 
idea is good, preferably make it a CONFIG_ option.

>And fixing sysrq to work after panics would be also nice.

I am not sure, but would enabling interrupts be enough?

>And maybe a sysrq key to switch the font to the smallest one available
>so as much as possible would fit onto a digital photo.

And analog photos? ;)

>> The one case this doesn't catch is the problem of oopses whilst
>> in X. Previously a non-fatal oops would stall X momentarily,
>> and then things continue. Now those cases will lock up completely
>> for two minutes. Future patches could add some additional feedback
>> during this 'stall' such as the blinky keyboard leds, or periodic speaker beeps.
>
>That's the killer issues why this patch is a bad idea.
>

Whilst few can be done in X situations, let's at least improve consoles.


Jan Engelhardt
-- 
