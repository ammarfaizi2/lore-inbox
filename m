Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262667AbREZO3E>; Sat, 26 May 2001 10:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262659AbREZO2z>; Sat, 26 May 2001 10:28:55 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:60676 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S262663AbREZO2l>;
	Sat, 26 May 2001 10:28:41 -0400
Date: Sat, 26 May 2001 10:54:16 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: vm in 2.4.5
In-Reply-To: <20010526102544.A1152@werewolf.able.es>
Message-ID: <Pine.LNX.4.21.0105261049130.30264-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, J . A . Magallon wrote:

> It does not begin to use swap in a growing fashion, it just appears
> full in a moment.

It gets _allocated_ in a moment, but things don't actually get
swapped out. This isn't a problem.

The real problem is that we don't actively reclaim swap space
when it gets full. We just assign swap to parts of processes,
but we never reclaim it when we need swap space for something
else; at least, not until the process exit()s or exec()s.

> And when all the gcc process ends, my mem ends up like:

>              total       used       free     shared    buffers     cached
> Swap:       152576     152576          0
> 
> What process do belong the 150Mb of swap ???!!!!
> Shouldn't that pages have been freed when gcc ends ?

Linux reclaims swap cache (and swap space) when it encounters
them in its scan of memory. It doesn't take the trouble of
freeing the swap on exit() but the swap space will be freed
later.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

