Return-Path: <linux-kernel-owner+w=401wt.eu-S1751465AbXAUUCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbXAUUCR (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 15:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbXAUUCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 15:02:17 -0500
Received: from hosting.zipcon.net ([209.221.136.3]:47117 "EHLO
	hosting.zipcon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbXAUUCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 15:02:16 -0500
X-Greylist: delayed 2798 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jan 2007 15:02:16 EST
Message-ID: <45B3BBE1.9090305@beezmo.com>
Date: Sun, 21 Jan 2007 11:15:45 -0800
From: William D Waddington <william.waddington@beezmo.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFCLUE3] flagging kernel interface changes
References: <455B9133.9030704@beezmo.com> <9a8748490611151517r7779652ej910a33ca961ba025@mail.gmail.com>
In-Reply-To: <9a8748490611151517r7779652ej910a33ca961ba025@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hosting.zipcon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - beezmo.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 15/11/06, William D Waddington <william.waddington@beezmo.com> wrote:
> 
>> I tried submitting a patch a while back:
>> "[PATCH] IRQ: ease out-of-tree migration to new irq_handler prototype"
>> to add #define __PT_REGS to include/linux/interrupt.h to flag the change
>> to the new interrupt handler prototype.  It wasn't well received :(
>>
>> No big surprise.  The #define wasn't my idea and I hadn't submitted a
>> patch before.  I wanted to see how the patch procedure worked, and
>> hoped that the flag would be included so I could mod my drivers and
>> move on...
>>
>> What I'm curious about is why flagging kernel/driver interface changes
>> is considered a bad idea.  From my point of view as a low-life out-of-
>> tree driver maintainer,
>>
>> #ifdef NEW_INTERFACE
>> #define <my new internals>
>> #endif
>>
>> (w/maybe an #else...)
>>
>> is cleaner and safer than trying to track specific kernel versions in
>> a multi-kernel-version driver.  It seems that in some cases, the new
>> interface has been, like HAVE_COMPAT_IOCTL for instance.
>>
>> I don't want to start an argument about "stable_api_nonsense" or the
>> wisdom of out-of-tree drivers.  Just curious about the - why - and
>> whether it is indifference or antagonism toward drivers outside the
>> fold. Or ???
>>
> 
> I would say that one reason is that cluttering up the kernel with
> #ifdef's is ugly and annoying to maintain long-term. Especially when
> it's expected that anyone who changes in-kernel interfaces also fix up
> any user(s) of those interfaces, so the #ifdef's are pointless
> (ignoring out-of-tree code that is).

Ah, but out-of-tree code is what I'm stuck w/maintaining.  I wouldn't
want to infest in-tree drivers w/#ifdef's either, but they are a fact
of life in my world.  And, lately, _really_ ugly version tests.

If I had _my_ way, there would be a kernel_interface_change.h file that
had an #define'd entry for _every_ kernel interface change within a
major release series:

/*
  * include/linux/interrupt.h interface change x.y.z
  * interrupt handler now takes 2 args
  */
#define INTERRUPT_H_CHANGE_X.Y.Z "interrupt handler now takes 2 args"

or something.

I understand that many (most?) kernel maintainers would prefer that
all drivers be brought in-tree, and aren't particularly concerned
when interface changes affect out-of-tree drivers.

Respectfully, I suggest that world domination isn't quite the same
thing as world dictatorship, and maybe the road to the former would
be helped by a little less of the latter :)

Rat-bastard out-of-tree maintainer takes refuge under desk....

Thanks,
Bill
-- 
--------------------------------------------
William D Waddington
Bainbridge Island, WA, USA
william.waddington@beezmo.com
--------------------------------------------
"Even bugs...are unexpected signposts on
the long road of creativity..." - Ken Burtch
