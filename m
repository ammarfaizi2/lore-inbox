Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264768AbSKEHrd>; Tue, 5 Nov 2002 02:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264772AbSKEHrd>; Tue, 5 Nov 2002 02:47:33 -0500
Received: from franka.aracnet.com ([216.99.193.44]:13188 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264768AbSKEHrc>; Tue, 5 Nov 2002 02:47:32 -0500
Date: Mon, 04 Nov 2002 23:50:21 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: kcn <kcn@263.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel freeze
Message-ID: <3845928973.1036453820@[10.10.2.3]>
In-Reply-To: <002d01c2849c$927faa40$31036fa6@zhoulin>
References: <002d01c2849c$927faa40$31036fa6@zhoulin>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'll lay you a large bet that lowmem is full of garbage.
>> Probably buffer_heads, inodes or PTEs. Output of /proc/meminfo 
>> and /proc/slabinfo as you approach oblivion would be useful.
>> As would a description of the workload that triggers it.
>> 
>> M.
>   I think it's the reason. But I have to decreased memory from 4G to 2G
> because of the complain from my customers, so I can't give you the
> /proc/meminfo or /proc/slabinfo now. :(

The patches don't seem to have wended their way back to mainline
yet, probably because people have been concentrating on 2.5 recently.
I think Andrea's -aa kernel has fixes for most, if not all of these
problems.

>   Why the linux-vm can't manage lowmem correctly? I have seen some
> articles talking about the LRU pre zone patch, but why 2.4.19+rmap14a
> patch also has this problem?

rmap won't help you in this instance, as the stuff you're filling
ZONE_NORMAL with is unswappable. In fact, it may make it worse,
due the overhead of pte_chains ... but this will probably only
hurt you if you have many large tasks sharing memory.

Changing PAGE_OFFSET from 3Gb to 2Gb may be a better workaround than
decreasing from 4Gb to 2Gb of RAM, if you don't have any huge single
process.

M.

