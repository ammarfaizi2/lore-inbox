Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262758AbTCPVNt>; Sun, 16 Mar 2003 16:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262759AbTCPVNt>; Sun, 16 Mar 2003 16:13:49 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:28905 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S262758AbTCPVNs>;
	Sun, 16 Mar 2003 16:13:48 -0500
Message-ID: <3E74EB92.7010801@colorfullife.com>
Date: Sun, 16 Mar 2003 22:24:34 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] O(1) proc_pid_readdir
References: <Pine.LNX.4.44.0303162203590.11399-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0303162203590.11399-100000@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>On Sun, 16 Mar 2003, Manfred Spraul wrote:
>
>  
>
>>Below is a proposal to get rid of the quadratic behaviour of
>>proc_pid_readir(): Instead of storing the task number in f_pos and
>>walking tasks by tasklist order, the pid is stored in f_pos and the
>>tasks are walked by (hash-mangled) pid order.
>>    
>>
>
>have you seen my "procfs/procps threading performance speedup" patch? It
>does something like this.
>
Interesting patch. Do seekdir and telldir still work? I think you must 
detect lseek calls and invalidate the cookie - either by hooking lseek 
or by looking at f_version.

I think my solution for proc_pid_readdir() is better: You must fall back 
to the old algorithm if the pid number stored in f_private got invalid 
between two syscalls. I've modified the hash table slightly and search 
for the next pid value directly, which works even if the current 
position disappeared.

--
    Manfred

