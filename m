Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317360AbSGVN62>; Mon, 22 Jul 2002 09:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317375AbSGVN62>; Mon, 22 Jul 2002 09:58:28 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:12811 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317360AbSGVN60>; Mon, 22 Jul 2002 09:58:26 -0400
Date: Mon, 22 Jul 2002 11:00:29 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Andrew Morton <akpm@zip.com.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>, Ed Tomlinson <tomlins@cam.org>, <bcrl@redhat.com>
Subject: Re: [PATCH][1/2] return values shrink_dcache_memory etc
In-Reply-To: <7146496.1027297237@[10.10.2.3]>
Message-ID: <Pine.LNX.4.44L.0207221057280.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2002, Martin J. Bligh wrote:

> > Was it purely Oracle which drove pte-highmem, or do you think
>
> I don't see you can get into pathalogical crap without heavy
> sharing of large amounts of data .... without sharing, you're at
> a fixed percentage of phys mem - with sharing, I can have more
> PTEs needed that I have phys mem.

... for which pte_highmem wouldn't fix the problem, either.

>From what I can see we really want/need 2 complementary
solutions to fix this problem:

1) large pages and/or shared page tables to reduce page
   table overhead, which is a real "solution"

2) page table garbage collection, to reduce the amount
   of (resident?) page tables when the shit hits the fan;
   this is an "emergency" thing to have and we wouldn't
   want to use it continously, but it might be important
   to keep the box alive

Since I've heard that (1) is already in use by some people
I've started working on (2) the moment Linus asked me to put
the dentry/icache pages in the LRU ;)))

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

