Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130157AbRBFU2V>; Tue, 6 Feb 2001 15:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129619AbRBFU2E>; Tue, 6 Feb 2001 15:28:04 -0500
Received: from ns.caldera.de ([212.34.180.1]:45325 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129571AbRBFU1s>;
	Tue, 6 Feb 2001 15:27:48 -0500
Date: Tue, 6 Feb 2001 21:25:03 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net, Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010206212503.A5426@caldera.de>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Ben LaHaise <bcrl@redhat.com>, Ingo Molnar <mingo@elte.hu>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Manfred Spraul <manfred@colorfullife.com>,
	Steve Lord <lord@sgi.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	kiobuf-io-devel@lists.sourceforge.net,
	Ingo Molnar <mingo@redhat.com>
In-Reply-To: <Pine.LNX.4.30.0102061402200.15204-100000@today.toronto.redhat.com> <Pine.LNX.4.10.10102061121530.1474-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <Pine.LNX.4.10.10102061121530.1474-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Feb 06, 2001 at 11:32:43AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2001 at 11:32:43AM -0800, Linus Torvalds wrote:
> Traditionally, a "bh" is only _used_ for small areas, but that's not a
> "bh" issue, that's a memory management issue. The code should pretty much
> handle the issue of a single 64kB bh pretty much as-is, but nothing
> creates them: the VM layer only creates bh's in sizes ranging from 512
> bytes to a single page.
> 
> The IO layer could do more, but there has yet to be anybody who needed
> more (becase once you hit a page-size, you tend to get into
> scatter-gather, so you want to have one bh per area - and let the
> low-level IO level handle the actual merging etc).

Yes.  That's one disadvantage blown away.

The second is that bh's are two things:

 - a cacheing object
 - an io buffer

This is not really an clean appropeach, and I would really like to
get away from it.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
