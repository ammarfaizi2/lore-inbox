Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131718AbRCXRM3>; Sat, 24 Mar 2001 12:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131716AbRCXRMU>; Sat, 24 Mar 2001 12:12:20 -0500
Received: from adsl-204-0-249-112.corp.se.verio.net ([204.0.249.112]:6141 "EHLO
	tabby.cats-chateau.net") by vger.kernel.org with ESMTP
	id <S131712AbRCXRMC>; Sat, 24 Mar 2001 12:12:02 -0500
From: Jesse Pollard <jesse@cats-chateau.net>
Reply-To: jesse@cats-chateau.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries.Brouwer@cwi.nl
Subject: Re: [PATCH] Prevent OOM from killing init
Date: Sat, 24 Mar 2001 10:48:52 -0600
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <E14gWSN-0005CQ-00@the-village.bc.nu>
In-Reply-To: <E14gWSN-0005CQ-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <01032411110700.03927@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001, Alan Cox wrote:
>> infinite storage. After all, earlier Unix flavours did not need
>> an OOM killer either, and my editor was not killed under Unix V6
>> on 64k when I started some other process.
>
>You were lucky. Its quite possible for V6 to kill processes when you run out
>of swap

Not lucky. I've used V6 - It would not start a process if the resources
werent available (no overcommit). It was also a swap based system and
not a page based system (PDP-11/45 1123+... supported both, but UNIX
only used swapping because it was easy to swap a 64Kbyte process).

>> The old Unix guarantee that a program only crashes because of
>> its own behaviour is lost. That is very sad.
>
>No such guarantee ever existed. There are systems that had stuff like per
>user memory quotas but those were mostly much more mainframe oriented

Only the swapping based systems gave this guarantee. Even AT&T System V
release 2 was swap based (M68020 systems).

>> 200 MB then the rest of that memory is not wasted. But it can
>> only be used for things that can be freed when needed, like
>> inode and buffer cache.
>
>No. You cannot free the inode and buffer cache arbitarily. You only have a
>probability - that puts you back at square 1.
>
>> But inefficient or not, I much prefer a system with guarantees,
>> something that is reliable by default, above something that
>> works well if you are lucky and fails at unpredictable moments.
>
>malloc is merely an accounting exercise (actually its mostly mmap 
>accounting). ptrace is the only quirk. Nobody feels its very important because
>nobody has implemented it.

Small correction - It was implemented, just not included in the standard
kernel.

Check mailing lists around March-April of 2000. The patch was generated
by Eduardo Horvath <eeh@turbolinux.com> for  2.3.99-pre3 and allowed the
administrator to:

"Available virtual memory is calculated as the sum of all swap space as
 well as free and reclaimable RAM, essentially the same value as used
 before.  The kernel will now operate in 4 different modes depending on the
 value of sysctl_overcommit_memory:
 
 1       Do accounting but do not prevent any allocations (old behavior)
 
 0       Do accounting but only prevent individual allocations that exceed
                total VM (old behavior)
 
 -1      Do accounting and prevent a user from making the amount of
                reserved memory exceed the total virtual memory.
 
 -2      Same as above but also for root.
 
 The default is set to -1 to allow root to essentially do whatever it
 wants.  But then if someone's broken root you're in trouble anyway.
 
 If the kernel itself requires memory it can allocate as much as it wants
 and can bring the system into an unsafe state (reserved > total).
 
 Memory segments that are not COW, ZFOD or otherwise swap backed do not
 require reservation."

It was a limited implementation, but worked quite well in testing.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: jesse@cats-chateau.net

Any opinions expressed are solely my own.
