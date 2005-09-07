Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbVIGWcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbVIGWcG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 18:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbVIGWcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 18:32:05 -0400
Received: from smtpout.mac.com ([17.250.248.47]:4323 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751308AbVIGWcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 18:32:04 -0400
In-Reply-To: <1126127233.2743.25.camel@syd.mkgnu.net>
References: <1126122068.2744.20.camel@syd.mkgnu.net> <Pine.LNX.4.61.0509071554190.4695@chaos.analogic.com> <1126127233.2743.25.camel@syd.mkgnu.net>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <491A850F-8667-4AF8-AF26-7849C5E6275B@mac.com>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [ham] Re: Gracefully killing kswapd, or any kernel thread
Date: Wed, 7 Sep 2005 18:31:42 -0400
To: Kristis Makris <kristis.makris@asu.edu>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 7, 2005, at 17:07:12, Kristis Makris wrote:
>> To kill a kernel thread, you need to make __it__ call exit(). It  
>> must be
>
> There must be another way to do it. Perhaps one could have another
> process effectively issue the contents of do_exit for the kswapd
> task_struct ?

Umm, so then the kernel does what, exactly?  You have a process in some
indeterminate state, possibly holding semaphores, definitely pinning
memory/resources/etc, and you just stop it, turn it off, and expect
things to continue working?  This is similar in nature to that thread
a while ago about kernel error recovery and killing uninterruptible
user processes.  To extend this to kernel threads, unless the kernel
thread has been _specifically_ coded to be interruptible, it isn't, and
furthermore, *can't* be.

>> CODED to do that! You can't do it externally although you can send
>
> I'm clearly asking for the case where the thread wasn't coded to do
> that.

You can't.  This is flatly impossible.  Go see the thread a while back
about a hot-patch system call for several reasons why that is a bad
idea.  In particular, look at the post that discusses phone switches,
the one with the quote "'So why don't you just reboot the affected
switches?' [...] 'That assumes the switches had ever been booted in
the first place'".

>> it a signal, after which it will spin forever....
>
> kflushd and keventd don't seem to spin forever. I still haven't
> determined what makes kswapd spin forever after it receives the  
> signal.

Probably a while(1) loop that isn't intended to stop until the machine
physically powers off.  If you want to patch one specific kernel thread,
you might be able to do that, but you can't just expect to hot-patch
random parts of the kernel at runtime and have things work.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$ L++++(+ 
++) E
W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+ PGP+++ t+(+++) 5  
X R?
tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  !y?(-)
------END GEEK CODE BLOCK------


