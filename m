Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275406AbRIZSDC>; Wed, 26 Sep 2001 14:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275393AbRIZSC5>; Wed, 26 Sep 2001 14:02:57 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:9550 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S275396AbRIZSBX>; Wed, 26 Sep 2001 14:01:23 -0400
Date: Wed, 26 Sep 2001 14:01:49 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        marcelo@conectiva.com.br, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
Message-ID: <20010926140149.C8223@redhat.com>
In-Reply-To: <E15mIfQ-0001E5-00@the-village.bc.nu> <Pine.LNX.4.33.0109261036260.8445-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0109261036260.8445-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Sep 26, 2001 at 10:44:14AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 10:44:14AM -0700, Linus Torvalds wrote:
> Do you have an actual SMP Athlon to test? I'd love to see if that "locked
> add" thing is really SMP-safe - it may be that it's the old "AMD turned
> off the 'lock' prefix synchronization because it doesn't matter in UP".
> They used to have a bit to do that..

Same, my dual reports:

	[bcrl@toomuch ~]$ ./a.out 
	nothing: 11 cycles
	locked add: 11 cycles
	cpuid: 68 cycles

Which is pretty good.

> That said, it _can_ be real even on SMP. There's no reason why a memory
> barrier would have to be as heavy as it is on some machines (even the P4
> looks positively _fast_ compared to most older machines that did memory
> barriers on the bus and took hundreds of much slower cycles to do it).

I had discussions with a few people from intel about the p4 having much 
improved locking performance, including the ability to speculatively 
execute locked instructions.  How much of that is enabled in the current 
cores is another question entirely (gotta love microcode patches).

		-ben
