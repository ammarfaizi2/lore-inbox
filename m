Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129379AbRBFRjy>; Tue, 6 Feb 2001 12:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129696AbRBFRjo>; Tue, 6 Feb 2001 12:39:44 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:36682 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129379AbRBFRjf>; Tue, 6 Feb 2001 12:39:35 -0500
Date: Tue, 6 Feb 2001 12:37:26 -0500 (EST)
From: Ben LaHaise <bcrl@redhat.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <20010206170506.H1167@redhat.com>
Message-ID: <Pine.LNX.4.30.0102061225330.15204-100000@today.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks,

On Tue, 6 Feb 2001, Stephen C. Tweedie wrote:

> The whole point of the post was that it is merging, not splitting,
> which is troublesome.  How are you going to merge requests without
> having chains of scatter-gather entities each with their own
> completion callbacks?

Let me just emphasize what Stephen is pointing out: if requests are
properly merged at higher layers, then merging is neither required nor
desired.  Traditionally, ext2 has not done merging because the underlying
system doesn't support it.  This leads to rather convoluted code for
readahead which doesn't result in appropriately merged requests on
indirect block boundries, and in fact leads to suboptimal performance.
The only case I see where merging of requests can improve things is when
dealing with lots of small files.  But we already know that small files
need to be treated differently (fe tail merging).  Besides, most of the
benefit of merging can be had by doing readaround for these small files.

As for io completion, can't we just issue seperate requests for the
critical data and the readahead?  That way for SCSI disks, the important
io should be finished while the readahead can continue.  Thoughts?

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
