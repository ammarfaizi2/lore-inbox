Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129862AbRBFS2h>; Tue, 6 Feb 2001 13:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129921AbRBFS21>; Tue, 6 Feb 2001 13:28:27 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:21858 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129740AbRBFS2Q>; Tue, 6 Feb 2001 13:28:16 -0500
Date: Tue, 6 Feb 2001 13:25:07 -0500 (EST)
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
In-Reply-To: <Pine.LNX.4.30.0102061841170.6277-100000@elte.hu>
Message-ID: <Pine.LNX.4.30.0102061321110.15204-100000@today.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2001, Ingo Molnar wrote:

> - higher levels do not have the kind of state to eg. merge requests done
>   by different users. The only chance for merging is often the lowest
>   level, where we already know what disk, which sector.

That's what a readaround buffer is for, and I suspect that readaround will
give use a big performance boost.

> - merging is not even *required* for some devices - and chances are high
>   that we'll get away from this inefficient and unreliable 'rotating array
>   of disks' business of storing bulk data in this century. (solid state
>   disks, holographic storage, whatever.)

Interesting that you've brought up this point, as its an example

> i'm truly shocked that you and Stephen are both saying this.

Merging != sorting.  Sorting of requests has to be carried out at the
lower layers, and the specific block device should be able to choose the
Right Thing To Do for the next item in a chain of sequential requests.

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
