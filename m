Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbVCTIBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbVCTIBj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 03:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVCTIBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 03:01:38 -0500
Received: from smtpout.mac.com ([17.250.248.88]:40925 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262044AbVCTIBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 03:01:31 -0500
In-Reply-To: <20050319163128.GB28958@elte.hu>
References: <20050318160229.GC25485@elte.hu> <E1DCPut-0005XI-00@gondolin.me.apana.org.au> <20050319163128.GB28958@elte.hu>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <24e1c77a699dcab771a0280df69d44eb@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Herbert Xu <herbert@gondor.apana.org.au>, rusty@au1.ibm.com,
       bhuey@lnxw.com, gh@us.ibm.com, tgall@us.ibm.com,
       jim.houston@comcast.net, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, paulmck@us.ibm.com,
       manfred@colorfullife.com, shemminger@osdl.org, dipankar@in.ibm.com
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Real-Time Preemption and RCU
Date: Sun, 20 Mar 2005 03:01:11 -0500
To: Ingo Molnar <mingo@elte.hu>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 19, 2005, at 11:31, Ingo Molnar wrote:
>> What about allowing only as many concurrent readers as there are CPUs?
>
> since a reader may be preempted by a higher prio task, there is no
> linear relationship between CPU utilization and the number of readers
> allowed. You could easily end up having all the nr_cpus readers
> preempted on one CPU. It gets pretty messy

One solution I can think of, although it bloats memory usage for 
many-way
boxen, is to just have a table in the rwlock with one entry per cpu.  
Each
CPU would get one concurrent reader, others would need to sleep

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


