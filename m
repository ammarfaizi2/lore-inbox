Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274888AbTGaW7T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 18:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274898AbTGaW7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 18:59:18 -0400
Received: from dyn-ctb-210-9-244-141.webone.com.au ([210.9.244.141]:11524 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S274888AbTGaW5u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 18:57:50 -0400
Message-ID: <3F299EA2.9020409@cyberone.com.au>
Date: Fri, 01 Aug 2003 08:56:34 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.org>
CC: Jamie Lokier <jamie@shareable.org>, Con Kolivas <kernel@kolivas.org>,
       Andrew Morton <akpm@osdl.org>, Johoho <johoho@hojo-net.de>,
       wodecki@gmx.de, Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O10int for interactivity
References: <200307280112.16043.kernel@kolivas.org> <200307311743.17370.kernel@kolivas.org> <20030731145937.GD6410@mail.jlokier.co.uk> <200307311724.12738.oliver@neukum.org>
In-Reply-To: <200307311724.12738.oliver@neukum.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Oliver Neukum wrote:

>>>This part interests me. It would seem that either 
>>>1. The AS scheduler should not bother waiting at all if the process is not 
>>>going to wake up in that time
>>>
>>How about something as simple as: if process sleeps, and AS scheduler
>>is waiting since last request from that process, AS scheduler stops
>>waiting immediately?
>>

No its fine if the process were to sleep on something. Its the
amount of time between IOs that is important (and is measured).
Makes no difference if the process is computing something or
waiting for something really.

>>
>>In other words, a hook in the process scheduler when a process goes to
>>sleep, to tell the AS scheduler to stop waiting.
>>
>>Although this would not always be optimal, for many cases the point of
>>AS is that the process is continuing to run, not sleeping, and will
>>issue another request shortly.
>>
>
>How do you tell which task dirtied the page?
>Wouldn't giving a bonus to tasks doing file io achieve the same purpose?
>Also, isn't quickly waking up tasks more important?
>

With AS, it doesn't matter what task created the IO, its what
task will have to wait on it. In the case of async writes, we
don't care about them anyway because the pagecache means they
get done a long way behind the instruction pointer of the
process anyway, so they'll be nicely layed out anyway.


