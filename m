Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130768AbRBFAUb>; Mon, 5 Feb 2001 19:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136110AbRBFAUV>; Mon, 5 Feb 2001 19:20:21 -0500
Received: from colorfullife.com ([216.156.138.34]:16647 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130768AbRBFAUK>;
	Mon, 5 Feb 2001 19:20:10 -0500
Message-ID: <3A7F430D.B1B3E34@colorfullife.com>
Date: Tue, 06 Feb 2001 01:19:25 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: Ingo Molnar <mingo@elte.hu>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify 
 + callback chains
In-Reply-To: <20010205121921.C1167@redhat.com> <Pine.LNX.4.30.0102052213470.10520-100000@elte.hu> <20010205225804.Z1167@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" wrote:
> 
> The original multi-page buffers came from the map_user_kiobuf
> interface: they represented a user data buffer.  I'm not wedded to
> that format --- we can happily replace it with a fine-grained sg list
>
Could you change that interface?

<<< from Linus mail:

        struct buffer {
                struct page *page;
                u16 offset, length;
        };

>>>>>>

/* returns the number of used buffers, or <0 on error */
int map_user_buffer(struct buffer *ba, int max_bcount,
			void* addr, int len);
void unmap_buffer(struct buffer *ba, int bcount);

That's enough for the zero copy pipe code ;-)

Real hw drivers probably need a replacement for pci_map_single()
(pci_map_and_align_and_bounce_buffer_array())

The kiobuf structure could contain these 'struct buffer' instead of the
current 'struct page' pointers.

> 
> In other words, even if we expand the kiobuf into a sg vector list,
> when it comes to merging requests in ll_rw_blk.c we still need to
> track the callbacks on each independent source kiobufs.
>
Probably.


--
	Manfred

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
