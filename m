Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265274AbUATIhe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 03:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265276AbUATIhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 03:37:33 -0500
Received: from as13-5-5.has.s.bonet.se ([217.215.179.23]:34728 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S265274AbUATIhU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 03:37:20 -0500
Message-ID: <400CE9A6.90208@stesmi.com>
Date: Tue, 20 Jan 2004 09:41:10 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Tim Hockin <thockin@hockin.org>, Rusty Russell <rusty@au1.ibm.com>,
       vatsa@in.ibm.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       akpm@osdl.org, rml@tech9.net
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR
References: <20040116174446.A2820@in.ibm.com> <20040120060027.91CC717DE5@ozlabs.au.ibm.com> <20040120063316.GA9736@hockin.org> <400CCE2F.2060502@cyberone.com.au> <20040120065207.GA10993@hockin.org> <400CD4B5.6020507@cyberone.com.au> <20040120073032.GB12638@hockin.org> <400CDCA1.5070200@cyberone.com.au> <20040120075409.GA13897@hockin.org> <400CE354.8060300@cyberone.com.au>
In-Reply-To: <400CE354.8060300@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

>> We have a conflict of priority here.  If an RT task is affined to CPU 
>> A and
>> CPU A gets yanked out, what do we do?
>>
>> Obviously the RT task can't keep running as it was.  It was affined to A.
>> Maybe for a good reason.  I see we have a few choices here:
>>
>> * re-affine it automatically, thereby silently undoing the explicit
>>  affinity.
>> * violate it's RT scheduling by not running it until it has been 
>> re-affined
>>  or CPU A returns to the pool/
>>
>> Sending it a SIGPWR means you have to run it on a different CPU that 
>> it was
>> affined to, which is already a violation.
>>
> 
> At least the task has the option to handle the problem.

Why not make a flag that handles that choice explicitly.

If the task sets the affinity itself the default is to
re-affine it if the cpu gets yanked but if the task wants to
be suspended until the CPU reappears it can set a flag for
that to happen if the CPU is yanked.

If we have a program that can start another program on a
specific CPU then that program can dictate how the task
should respond by setting the flag the same way
as the task would if the task would be the one selecting
a specific CPU. Doesn't that fix the problem?

If the default was to re-affine to another CPU then
we can optionally send it a SIGPWR as well to let it
know it was re-affined.

But the SIGPWR is in my eyes optional and the above scenario
should handle the cases imo.

// Stefan

