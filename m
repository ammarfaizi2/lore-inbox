Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbTL2HCn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 02:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbTL2HCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 02:02:42 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:916 "HELO mail.iinet.net.au")
	by vger.kernel.org with SMTP id S262784AbTL2HCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 02:02:41 -0500
Message-ID: <3FEFD18D.3070608@cyberone.com.au>
Date: Mon, 29 Dec 2003 18:02:37 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware
References: <200312231138.21734.kernel@kolivas.org> <20031226225652.GE197@elf.ucw.cz> <200312271042.55989.kernel@kolivas.org> <20031227110903.GA1413@elf.ucw.cz>
In-Reply-To: <20031227110903.GA1413@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Pavel Machek wrote:

>Hi!
>
>
>>>BTW this is going to be an issue even on normal (non-HT)
>>>systems. Imagine memory-bound scientific task on CPU0 and nice -20
>>>memory-bound seti&home at CPU1. Even without hyperthreading, your
>>>scientific task is going to run at 50% of speed and seti&home is going
>>>to get second half. Oops.
>>>
>>>Something similar can happen with disk, but we are moving out of
>>>cpu-scheduler arena with that.
>>>
>>>[I do not have SMP nearby to demonstrate it, anybody wanting to
>>>benchmark a bit?]
>>>
>>This is definitely the case but there is one huge difference. If you have 
>>2x1Ghz non HT processors then the fastest a single threaded task can run is 
>>at 1Ghz. If you have 1x2Ghz HT processor the fastest a single threaded task 
>>can run is 2Ghz. 
>>
>
>Well, gigaherz is not the *only* important thing.
>
>On 2x1GHz, 2GB/sec RAM bandwidth, fastest a single threaded task can
>run is 1GHz, 2GB/sec. If you run two of them, it is 1GHz,
>*1*GB/sec. So you still have effect similar to hyperthreading. And
>yes, it can be measured.
>

Hi Pavel,
Sure this might be a real problem sometimes, but I don't see the
CPU scheduler ever handling it unless we want to add a few kitchen
sinks to its nice lean code as well.

If the need really arises, then probably a userspace daemon could
do it.


