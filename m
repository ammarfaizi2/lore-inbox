Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265269AbUFOBcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbUFOBcT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 21:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265268AbUFOBcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 21:32:19 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:1789 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S265269AbUFOBb3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 21:31:29 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: "Nikita V. Youshchenko" <yoush@cs.msu.su>, linux-kernel@vger.kernel.org
Date: Mon, 14 Jun 2004 18:31:17 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: Local DoS (was: Strange 'zombie' problem both in 2.4 and 2.6)
In-Reply-To: <20040615002734.GA9801@logos.cnet>
Message-ID: <Pine.LNX.4.60.0406141754570.30956@dlang.diginsite.com>
References: <200404091311.50787@zigzag.lvk.cs.msu.su> <20040413131017.GA11294@logos.cnet>
 <Pine.LNX.4.60.0406140959250.30433@dlang.diginsite.com> <20040615002734.GA9801@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jun 2004, Marcelo Tosatti wrote:
> On Mon, Jun 14, 2004 at 10:01:53AM -0700, David Lang wrote:
>> I think I may be running into the same (or a similar) issue with a
>> workload that forks heavily (~3500 forks/sec). What can I do to let the
>> system survive this sort of load?
>
> Hi David,
>
> v2.6.7-mm tree contains a fix for this, adding a rlimit for
> pending signals.

I'll have to give this a try.

> Can you describe the problem you are seeing in more detail?

I have a stress-test I am running on a dual Opteron 1.4GHz box that 
receives a network connection, forks a new process, does a little bit of 
network traffic then the child exits. when I hammer this I get ~3500 
connections/sec (with a significant amount of spare CPU, I'm limited by 
my load boxes), but after a few secnds (8-10) something happens and the 
parent stops receiving the sigchild signals. if I connect strace to the 
parent process the signals are re-enabled and everything works for a 
little bit longer before the process repeats.

if I only hit it with ~10,000 connections and then pause the box survives 
indefinantly

running the same test on a dual athlonMP 2200+ I get ~2500 connections a 
sec and it has no problems. I just compiled a 32 bit kernel for the 
opteron and get ~3300 connections/sec (with no idle CPU time) and the box 
doesn't lock up.

I don't know if this is becouse it's just below the threashold of the 
problem or if there is a bug in the 64 bit kernel (or both)

I'm currently trying to tweak the 32 bit opteron kernel to get a smidge 
more speed out of it to see if getting back up to the same speed starts 
triggering the problem again.

David Lang

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
