Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313638AbSFLIgX>; Wed, 12 Jun 2002 04:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316492AbSFLIgW>; Wed, 12 Jun 2002 04:36:22 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:14603 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S313638AbSFLIgW>; Wed, 12 Jun 2002 04:36:22 -0400
Message-ID: <3D0707FB.3816C7A4@aitel.hist.no>
Date: Wed, 12 Jun 2002 10:36:11 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.20-dj3 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
In-Reply-To: Your message of "Tue, 11 Jun 2002 00:42:32 MST."
		             <3D05A9E8.FF0DA223@zip.com.au> <E17Hheq-0007r7-00@wagner.rustcorp.com.au> <3D05C27D.186DC066@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Rusty Russell wrote:
> >
> > ...
> > Let's not perpetuate the myth that everything in the kernel needs to
> > be tuned to the last cycle at all costs, hm?
> 
> I was more concerned about the RAM use, actually.
> 
> This patch is an additional reason for CONFIG_NR_CPUS, but I've rather
> gone cold on that idea because the "proper fix" is to make all those
> huge per-cpu arrays dynamically allocated.   So you can run a 64p kernel
> on 2p without losing hundreds of k of memory and kernel address space.
> 
> But it looks like all those dynamically-allocated structures would
> have to be allocated out to NR_CPUS anyway, to support hotplug, yes?
> 
> In which case, CONFIG_NR_CPUS is the only way to get the memory
> back...

Re-allocation of tables when adding CPUs is another
option.  That means the data moves - so others have to store
array indices instead of direct pointers to stuff they use.
Dynamic allocation not merely at boottime, but everytime.

Adding a CPU becomes more expensive, but that won't
happen hundreds of times a second anyway.  

Helge Hafting
