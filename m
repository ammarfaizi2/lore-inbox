Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130654AbRBGAlW>; Tue, 6 Feb 2001 19:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130671AbRBGAlC>; Tue, 6 Feb 2001 19:41:02 -0500
Received: from zeus.kernel.org ([209.10.41.242]:63201 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130654AbRBGAlA>;
	Tue, 6 Feb 2001 19:41:00 -0500
Date: Wed, 7 Feb 2001 00:36:29 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Ingo Molnar <mingo@redhat.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Ben LaHaise <bcrl@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010207003629.M1167@redhat.com>
In-Reply-To: <20010207002107.L1167@redhat.com> <Pine.LNX.4.32.0102061924300.24366-100000@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.32.0102061924300.24366-100000@devserv.devel.redhat.com>; from mingo@redhat.com on Tue, Feb 06, 2001 at 07:25:19PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 06, 2001 at 07:25:19PM -0500, Ingo Molnar wrote:
> 
> On Wed, 7 Feb 2001, Stephen C. Tweedie wrote:
> 
> > No, it is a problem of the ll_rw_block interface: buffer_heads need to
> > be aligned on disk at a multiple of their buffer size.  Under the Unix
> > raw IO interface it is perfectly legal to begin a 128kB IO at offset
> > 512 bytes into a device.
> 
> then we should either fix this limitation, or the raw IO code should split
> the request up into several, variable-size bhs, so that the range is
> filled out optimally with aligned bhs.

That gets us from 512-byte blocks to 4k, but no more (ll_rw_block
enforces a single blocksize on all requests but that relaxing that
requirement is no big deal).  Buffer_heads can't deal with data which
spans more than a page right now.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
