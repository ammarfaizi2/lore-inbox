Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261553AbSJMQmb>; Sun, 13 Oct 2002 12:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261556AbSJMQm2>; Sun, 13 Oct 2002 12:42:28 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:9374 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261553AbSJMQm0>; Sun, 13 Oct 2002 12:42:26 -0400
X-From-Line: nobody Sun Oct 13 17:48:37 2002
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] 2.5.42: remove capable(CAP_SYS_RAWIO) check from
 open_kmem
References: <3DA985E6.6090302@colorfullife.com>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Sun, 13 Oct 2002 17:48:37 +0200
Message-ID: <87adliuyp6.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> writes:

>> In drivers/char/mem.c there's open_port(), which is used as open_mem()
>> and open_kmem() as well. I don't see the benefit of this, since
>> /dev/mem and /dev/kmem are already protected by filesystem
>> permissions.
>>
> capabilities can be stricter than filesystem permissions

Which means, it prevents me from giving access to /dev/kmem to an
otherwise unprivileged process.

> , and the call
> is needed to update the PF_SUPERPRIV process flag.

What exactly is PF_SUPERPRIV good for? I see no real use in the
source. There is exactly one test for this flag (kernel/acct.c:336),
then sets another flag (ASU), which in turn is used nowhere else.

So, I think we could get rid of this flag as well. Comments?

Regards, Olaf.
