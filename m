Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261566AbSJMQkY>; Sun, 13 Oct 2002 12:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbSJMQkY>; Sun, 13 Oct 2002 12:40:24 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:39104 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261566AbSJMQkX>; Sun, 13 Oct 2002 12:40:23 -0400
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] 2.5.42: remove capable(CAP_SYS_RAWIO) check from
 open_kmem
References: <3DA985E6.6090302@colorfullife.com>
	<87adliuyp6.fsf@goat.bogus.local> <3DA99A8B.5050102@colorfullife.com>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Sun, 13 Oct 2002 18:45:57 +0200
In-Reply-To: <3DA99A8B.5050102@colorfullife.com> (Manfred Spraul's message
 of "Sun, 13 Oct 2002 18:08:43 +0200")
Message-ID: <873crauw1m.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> writes:

> Olaf Dietsche wrote:
>  > Manfred Spraul <manfred@colorfullife.com> writes:
>  >
>  >
>  >>>In drivers/char/mem.c there's open_port(), which is used as open_mem()
>  >>>and open_kmem() as well. I don't see the benefit of this, since
>  >>>/dev/mem and /dev/kmem are already protected by filesystem
>  >>>permissions.
>  >>>
>  >>
>  >>capabilities can be stricter than filesystem permissions
>  >
>  >
>  > Which means, it prevents me from giving access to /dev/kmem to an
>  > otherwise unprivileged process.
>  >
> Do you know what access to /dev/kmem means?

Which is not the point. Just assume for a moment, I know what I'm
doing :-)

> A process that can read /dev/kmem can read /etc/shadow and probaly all
> other files he can force into memory.
>
> A process that can write to /dev/kmem can give himself ultimate
> capabilities by modifying it's own uid/capability set.

Now, I have to run this process as root, regardless of filesystem
permissions. So, if I trust this particular process with full
privileges now, there's no problem in reducing its power a little bit.

> Have you tried to disable the capabilities? I think there is a kernel
> option that disables them.

I don't want to disable capabilities. I want to get rid of this
particular use.

>>>, and the call
>>>is needed to update the PF_SUPERPRIV process flag.
>> What exactly is PF_SUPERPRIV good for? I see no real use in the
>> source. There is exactly one test for this flag (kernel/acct.c:336),
>> then sets another flag (ASU), which in turn is used nowhere else.
>> So, I think we could get rid of this flag as well. Comments?
>>
>
> Part of BSD process accounting - you have just broken backward
> compatibility with user space.

Ok, thanks for this hint.

Regards, Olaf.
