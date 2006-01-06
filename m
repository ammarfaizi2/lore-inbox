Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWAFI2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWAFI2s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 03:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWAFI2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 03:28:48 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:56020 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932225AbWAFI2r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 03:28:47 -0500
Date: Fri, 6 Jan 2006 00:28:26 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Eric Dumazet <dada1@cosmosbay.com>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shrinks sizeof(files_struct) and better layout
In-Reply-To: <43BE1E46.3060904@cosmosbay.com>
Message-ID: <Pine.LNX.4.62.0601060014140.1708@qynat.qvtvafvgr.pbz>
References: <20051108185349.6e86cec3.akpm@osdl.org> <437226B1.4040901@cosmosbay.com>
 <20051109220742.067c5f3a.akpm@osdl.org> <4373698F.9010608@cosmosbay.com>
 <43BB1178.7020409@cosmosbay.com> <p733bk4z2z0.fsf@verdi.suse.de>
 <43BBADD5.3070706@cosmosbay.com> <Pine.LNX.4.62.0601051900440.973@qynat.qvtvafvgr.pbz>
 <43BE0FC3.7030602@cosmosbay.com> <Pine.LNX.4.62.0601052318570.1708@qynat.qvtvafvgr.pbz>
 <43BE1E46.3060904@cosmosbay.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006, Eric Dumazet wrote:

> David Lang a écrit :
>> Ok, so if you have large numbers of CPU's and large page sizes it's not 
>> useful. however, what about a 2-4 cpu machine with 4k page sizes, 8-32G of 
>> ram (a not unreasonable Opteron system config) that will be running 
>> 5,000-20,000 processes/threads?
>
> Dont forget 'struct files_struct' are shared between threads of one process.
>
> So may benefit from this 'special cache' only if you plan to run 20.000 
> processes.

Ok, that's why I as asking

>> 
>> I know people argue that programs that do such things are bad (and I 
>> definantly agree that they aren't optimized), but the reality is that some 
>> workloads are like that. if a machine is being built for such uses 
>> configuring the kernel to better tolorate such use may be useful
>
> If 20.000 process runs on a machine, I doubt the main problem of sysadmin is 
> about the 'struct files_struct' placement in memory :)

I have some boxes that routinely sit with 3,500-4,000 processes (fork 
heavy workload, ~1400 forks/sec so far) that topple over when they go much 
over 10,000 processes.

I'm only running 32 bit kernels with 1G of ram available, (no himem), I've 
been assuming that ram was my limiting factor, but it hasn't been 
enough of an issue to really track down yet :-)

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

