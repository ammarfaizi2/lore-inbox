Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272137AbRIVU7c>; Sat, 22 Sep 2001 16:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272242AbRIVU7W>; Sat, 22 Sep 2001 16:59:22 -0400
Received: from [208.129.208.52] ([208.129.208.52]:26381 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S272197AbRIVU7G>;
	Sat, 22 Sep 2001 16:59:06 -0400
Message-ID: <XFMail.20010922140302.davidel@xmailserver.org>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010922142847.A20641@dea.linux-mips.net>
Date: Sat, 22 Sep 2001 14:03:02 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Ralf Baechle <ralf@conectiva.com.br>
Subject: Re: Purpose of the mm/slab.c changes
Cc: torvalds@transmeta.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>,
        Rik van Riel <riel@conectiva.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22-Sep-2001 Ralf Baechle wrote:
> On Sun, Sep 09, 2001 at 01:58:44PM -0700, Davide Libenzi wrote:
> 
>> >> Do You see it as a plus ?
>> >> The new allocated slab will be very likely written ( w/o regard
>> >> about the old content ) and an L2 mapping will generate
>> >> invalidate traffic.
>> > 
>> > If your invalidates are slower than your RAM, you should
>> > consider getting another computer.
>> 
>> You mean a Sun, that uses a separate bus for snooping ? :)
>> Besides to not under estimate the cache coherency traffic ( that on many CPUs
>> uses the main memory bus ) there's the fact that the old data eventually
>> present in L2 won't be used by the new slab user.
> 
> That's actually what having a slab cache of pre-initialized elements tries
> to achieve.
> 
> On anything that uses a MESI-like cache coherence protocol a cached dirty
> cache line that is written to will not cause any coherency traffic and
> thus be faster.

MESI is a bit more complicated than clean/dirty status.
This is a very good state machine graph for MESI :

http://odin.ee.uwa.edu.au/~morris/CA406/cache_coh.html

Besides this, i don't get how a LIFO could help you.
>From a cache point of view if the slab-free code run on processor A and
the slab-alloc code will run on a processor B, if these two ops are
executed very close in time ( due LIFO ) there's a good probability of
modified->shared migration that will result in pushback ops.
A FIFO will result in more time between free and alloc with a good probability
that the interlock will be relaxed.




- Davide

