Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284659AbSAALNX>; Tue, 1 Jan 2002 06:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287801AbSAALNN>; Tue, 1 Jan 2002 06:13:13 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:56592 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S284659AbSAALM5>;
	Tue, 1 Jan 2002 06:12:57 -0500
Date: Tue, 1 Jan 2002 22:08:38 +1100
From: Anton Blanchard <anton@samba.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@zip.com.au>, Manfred Spraul <manfred@colorfullife.com>,
        Dave Jones <davej@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Prefetching file_read_actor()
Message-ID: <20020101110838.GA11768@krispykreme>
In-Reply-To: <3C30BC5F.227349E8@zip.com.au> <E16LMBW-0008Dk-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16LMBW-0008Dk-00@the-village.bc.nu>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Please bury such things in arch/cpu specific routines. Most non intel
> processor hardware isnt that broken.

Exactly, for example ppc32 and ppc64 implement the prefetch macros so we
cant put intel specific prefetch hacks in generic code. 

The correct place to do it is in the copy_*_user routines where you can
make decisions based on length etc. Davem already does this for sparc64
and Paulus is working on it for ppc32/64.

I just grepped around for current prefetch usage and noticed we now
use it in the list macros. Converting non struct list code (eg pagecache
hash) to use for_each_list etc might give some benefits.

Perhaps for_each_task could benefit from the same prefetching.

Anton
