Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbRBEXUP>; Mon, 5 Feb 2001 18:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130435AbRBEXUF>; Mon, 5 Feb 2001 18:20:05 -0500
Received: from zeus.kernel.org ([209.10.41.242]:16355 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129030AbRBEXTd>;
	Mon, 5 Feb 2001 18:19:33 -0500
Date: Mon, 5 Feb 2001 23:16:47 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Steve Lord <lord@sgi.com>, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010205231647.C1167@redhat.com>
In-Reply-To: <20010205225804.Z1167@redhat.com> <E14Puih-0004Rk-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E14Puih-0004Rk-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Feb 05, 2001 at 11:06:48PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 05, 2001 at 11:06:48PM +0000, Alan Cox wrote:
> > do you then tell the application _above_ raid0 if one of the
> > underlying IOs succeeds and the other fails halfway through?
> 
> struct 
> {
> 	u32 flags;	/* because everything needs flags */
> 	struct io_completion *completions;
> 	kiovec_t sglist[0];
> } thingy;
> 
> now kmalloc one object of the header the sglist of the right size and the
> completion list. Shove the completion list on the end of it as another
> array of objects and what is the problem.

XFS uses both small metadata items in the buffer cache and large
pagebufs.  You may have merged a 512-byte read with a large pagebuf
read: one completion callback is associated with a single sg fragment,
the next callback belongs to a dozen different fragments.  Associating
the two lists becomes non-trivial, although it could be done.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
