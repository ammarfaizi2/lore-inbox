Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265317AbUATIul (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 03:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265329AbUATIuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 03:50:40 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:30621 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265317AbUATIuY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 03:50:24 -0500
Message-ID: <400CEBA9.20706@cyberone.com.au>
Date: Tue, 20 Jan 2004 19:49:45 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Stefan Smietanowski <stesmi@stesmi.com>
CC: Tim Hockin <thockin@hockin.org>, Rusty Russell <rusty@au1.ibm.com>,
       vatsa@in.ibm.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       akpm@osdl.org, rml@tech9.net
Subject: Re: CPU Hotplug: Hotplug Script And SIGPWR
References: <20040116174446.A2820@in.ibm.com> <20040120060027.91CC717DE5@ozlabs.au.ibm.com> <20040120063316.GA9736@hockin.org> <400CCE2F.2060502@cyberone.com.au> <20040120065207.GA10993@hockin.org> <400CD4B5.6020507@cyberone.com.au> <20040120073032.GB12638@hockin.org> <400CDCA1.5070200@cyberone.com.au> <20040120075409.GA13897@hockin.org> <400CE354.8060300@cyberone.com.au> <400CE9A6.90208@stesmi.com>
In-Reply-To: <400CE9A6.90208@stesmi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Stefan Smietanowski wrote:

> Hi.
>
>>> We have a conflict of priority here.  If an RT task is affined to 
>>> CPU A and
>>> CPU A gets yanked out, what do we do?
>>>
>>> Obviously the RT task can't keep running as it was.  It was affined 
>>> to A.
>>> Maybe for a good reason.  I see we have a few choices here:
>>>
>>> * re-affine it automatically, thereby silently undoing the explicit
>>>  affinity.
>>> * violate it's RT scheduling by not running it until it has been 
>>> re-affined
>>>  or CPU A returns to the pool/
>>>
>>> Sending it a SIGPWR means you have to run it on a different CPU that 
>>> it was
>>> affined to, which is already a violation.
>>>
>>
>> At least the task has the option to handle the problem.
>
>
> Why not make a flag that handles that choice explicitly.
>
> If the task sets the affinity itself the default is to
> re-affine it if the cpu gets yanked but if the task wants to
> be suspended until the CPU reappears it can set a flag for
> that to happen if the CPU is yanked.
>
> If we have a program that can start another program on a
> specific CPU then that program can dictate how the task
> should respond by setting the flag the same way
> as the task would if the task would be the one selecting
> a specific CPU. Doesn't that fix the problem?


Well I'll admit it would usually be more flexible if you freeze
the process and run hotplug scripts to handle cpu affinity.

Unfortunately it introduces unfixable robustness and realtime
problems by design.


