Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129812AbRBFTOy>; Tue, 6 Feb 2001 14:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129908AbRBFTOo>; Tue, 6 Feb 2001 14:14:44 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:8829 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129744AbRBFTOb>; Tue, 6 Feb 2001 14:14:31 -0500
Date: Tue, 6 Feb 2001 14:11:23 -0500 (EST)
From: Ben LaHaise <bcrl@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.30.0102061955380.7919-100000@elte.hu>
Message-ID: <Pine.LNX.4.30.0102061402200.15204-100000@today.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2001, Ingo Molnar wrote:

>
> On Tue, 6 Feb 2001, Ben LaHaise wrote:
>
> > 	- reduce the overhead in submitting block ios, especially for
> > 	  large ios. Look at the %CPU usages differences between 512 byte
> > 	  blocks and 4KB blocks, this can be better.
>
> my system is already submitting 4KB bhs. If anyone's raw-IO setup submits
> 512 byte bhs thats a problem of the raw IO code ...
>
> > 	- make asynchronous io possible in the block layer.  This is
> > 	  impossible with the current ll_rw_block scheme and io request
> > 	  plugging.
>
> why is it impossible?

s/impossible/unpleasant/.  ll_rw_blk blocks; it should be possible to have
a non blocking variant that does all of the setup in the caller's context.
Yes, I know that we can do it with a kernel thread, but that isn't as
clean and it significantly penalises small ios (hint: databases issue
*lots* of small random ios and a good chunk of large ios).

> > You mentioned non-spindle base io devices in your last message.  Take
> > something like a big RAM disk. Now compare kiobuf base io to buffer
> > head based io. Tell me which one is going to perform better.
>
> roughly equal performance when using 4K bhs. And a hell of a lot more
> complex and volatile code in the kiobuf case.

I'm willing to benchmark you on this.

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
