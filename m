Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131536AbRAJIaY>; Wed, 10 Jan 2001 03:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132436AbRAJIaO>; Wed, 10 Jan 2001 03:30:14 -0500
Received: from gnu.in-berlin.de ([192.109.42.4]:50954 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S131536AbRAJIaE>;
	Wed, 10 Jan 2001 03:30:04 -0500
X-Envelope-From: news@goldbach.in-berlin.de
To: linux-kernel@vger.kernel.org
Path: kraxel
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Date: 10 Jan 2001 07:51:11 GMT
Organization: Strusel 007
Message-ID: <slrn95o53b.ve.kraxel@bogomips.masq.in-berlin.de>
In-Reply-To: <Pine.LNX.3.96.1010109175317.7868A-100000@kanga.kvack.org> <Pine.LNX.4.10.10101091540130.2815-100000@penguin.transmeta.com>
NNTP-Posting-Host: bogomips.masq.in-berlin.de
X-Trace: goldbach.masq.in-berlin.de 979113071 23633 192.168.69.77 (10 Jan 2001 07:51:11 GMT)
X-Complaints-To: news@goldbach.in-berlin.de
NNTP-Posting-Date: 10 Jan 2001 07:51:11 GMT
User-Agent: slrn/0.9.6.3 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Please tell me what you think the right interface is that provides a hook
> > on io completion and is asynchronous.
> 
> Suggested fix to kiovec's: get rid of them. Immediately. Replace them with
> kiobuf's that can handle scatter-gather pages. kiobuf's have 90% of that
> support already.
> 
> Never EVER have a "struct page **" interface. It is never the valid thing
> to do.

Hmm, /me is quite happy with it.  It's fine for *big* chunks of memory like
video frames:  I just need a large number of pages, length and offset.  If
someone wants to have a look: a rewritten bttv version which uses kiobufs
is available at http://www.strusel007.de/linux/bttv/bttv-0.8.8.tar.gz

It does _not_ use kiovecs throuth (to be exact: kiovecs with just one single
kiobuf in there).

> You should have
> 
> 	struct fragment {
> 		struct page *page;
> 		__u16 offset, length;
> 	}

What happens with big memory blocks?  Do all pages but the first and last
get offset=0 and length=PAGE_SIZE then?

  Gerd

-- 
Get back there in front of the computer NOW. Christmas can wait.
	-- Linus "the Grinch" Torvalds,  24 Dec 2000 on linux-kernel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
