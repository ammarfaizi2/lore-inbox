Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262885AbRE0X7m>; Sun, 27 May 2001 19:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262886AbRE0X7d>; Sun, 27 May 2001 19:59:33 -0400
Received: from jalon.able.es ([212.97.163.2]:54765 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S262885AbRE0X7Y>;
	Sun, 27 May 2001 19:59:24 -0400
Date: Mon, 28 May 2001 01:59:16 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: vm in 2.4.5
Message-ID: <20010528015916.E8098@werewolf.able.es>
In-Reply-To: <20010526102544.A1152@werewolf.able.es> <Pine.LNX.4.21.0105261049130.30264-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.21.0105261049130.30264-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Sat, May 26, 2001 at 15:54:16 +0200
X-Mailer: Balsa 1.1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.26 Rik van Riel wrote:
> On Sat, 26 May 2001, J . A . Magallon wrote:
> 
> > It does not begin to use swap in a growing fashion, it just appears
> > full in a moment.
> 
> It gets _allocated_ in a moment, but things don't actually get
> swapped out. This isn't a problem.
> 
> The real problem is that we don't actively reclaim swap space
> when it gets full. We just assign swap to parts of processes,
> but we never reclaim it when we need swap space for something
> else; at least, not until the process exit()s or exec()s.
> 
> > And when all the gcc process ends, my mem ends up like:
> 
> >              total       used       free     shared    buffers     cached
> > Swap:       152576     152576          0
> > 
> > What process do belong the 150Mb of swap ???!!!!
> > Shouldn't that pages have been freed when gcc ends ?
> 
> Linux reclaims swap cache (and swap space) when it encounters
> them in its scan of memory. It doesn't take the trouble of
> freeing the swap on exit() but the swap space will be freed
> later.
> 

That seems to be partially true, if I start just the same comilation when
the first finishes, it behaves like preivous, in the moment the new gcc
needs swap the old swap gets freed, but not the in-core cache, so if I choose
carefully the number of 'puts' lines to stress my system just to the
border, I can't do two times the same 'gcc tst.c'.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.4-ac15 #1 SMP Wed May 23 21:55:23 CEST 2001 i686
