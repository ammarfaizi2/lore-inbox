Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262219AbTC1GOQ>; Fri, 28 Mar 2003 01:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262229AbTC1GOQ>; Fri, 28 Mar 2003 01:14:16 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:53136 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S262219AbTC1GOP>;
	Fri, 28 Mar 2003 01:14:15 -0500
Message-ID: <3E83EAC3.3080107@colorfullife.com>
Date: Fri, 28 Mar 2003 07:25:07 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: task_struct slab cache use after free in 2.5.66
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane wrote:

>On Thu, 27 Mar 2003, Andrew Morton wrote:
>
>> That's the second report of this.  Someone did a put_task_struct against a
>> freed task_struct.  I'll cook up a debug patch to trap it.  Something like
>> this:
>
>Well there is also the detach_pid bug which suddenly vanished... I'm not 
>aware of anyone sending a patch for that (but i can't be certain i havent 
>been keeping up with lkml lately). I posted some debug information for 
>that one about a week ago:
>
>Pine.LNX.4.50.0303221152460.18911-100000@montezuma.mastecende.com
>
>Manfred?

I didn't send a patch. One thing I noticed from reading zwane's bug report is that the reference count of the task structure was off by at least 3:

	__detach_pid(p, PIDTYPE_PGID)

failed because the task structure was already filled with slab poison.

--
	Manfred






