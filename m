Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbVLUHUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbVLUHUQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 02:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbVLUHUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 02:20:16 -0500
Received: from mf01.sitadelle.com ([212.94.174.68]:15015 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S932301AbVLUHUP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 02:20:15 -0500
Message-ID: <43A90225.4060007@cosmosbay.com>
Date: Wed, 21 Dec 2005 08:20:05 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Christoph Lameter <christoph@lameter.com>,
       Alok N Kataria <alokk@calsoftinc.com>,
       Shobhit Dayal <shobhit@calsoftinc.com>,
       Shai Fultheim <shai@scalex86.org>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RT 00/02] SLOB optimizations
References: <1134860251.13138.193.camel@localhost.localdomain> <20051220133230.GC24408@elte.hu> <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com> <20051220135725.GA29392@elte.hu> <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com> <1135093460.13138.302.camel@localhost.localdomain> <20051220181921.GF3356@waste.org> <1135106124.13138.339.camel@localhost.localdomain> <84144f020512201215j5767aab2nc0a4115c4501e066@mail.gmail.com> <1135114971.13138.396.camel@localhost.localdomain> <20051221065619.GC766@elte.hu>
In-Reply-To: <20051221065619.GC766@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar a écrit :
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> 
>>[...] Today's slab system is starting to become like the IDE where 
>>nobody, but a select few sado-masochis, dare to venture in. (I've CC'd 
>>them ;) [...]
> 
> 
> while it could possibly be cleaned up a bit, it's one of the 
> best-optimized subsystems Linux has. Most of the "unnecessary 
> complexity" in SLAB is related to a performance or a debugging feature.  
> Many times i have looked at the SLAB code in a disassembler, right next 
> to profile output from some hot workload, and have concluded: 'I couldnt 
> do this any better even with hand-coded assembly'.

Well, I miss a version of kmem_cache_alloc()/kmem_cache_free() that wont play 
with IRQ masking.

The local_irq_save()/local_irq_restore() pair is quite expensive and could be 
avoided for several caches that are exclusively used in process context.

(Not speaking of general caches of course, but caches like dentry_cache, filp, 
...)

Eric

