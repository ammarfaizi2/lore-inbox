Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281474AbRKTXGu>; Tue, 20 Nov 2001 18:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281471AbRKTXGl>; Tue, 20 Nov 2001 18:06:41 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:1810 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281474AbRKTXGa>; Tue, 20 Nov 2001 18:06:30 -0500
Message-ID: <3BFAE1C8.4735C164@zip.com.au>
Date: Tue, 20 Nov 2001 15:05:44 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Maas <dmaas@dcine.com>
CC: Rik van Riel <riel@conectiva.com.br>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Swap
In-Reply-To: <Pine.LNX.4.33L.0111202019170.4079-100000@imladris.surriel.com> <03bb01c17213$887ccd30$1a01a8c0@allyourbase>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Maas wrote:
> 
> > Uhhhh, read his original mail.  When using mmap() he had
> > problems with the VM doing bad page replacement, while
> > read() was smooth.
> 
> I should add that I did experiment with madvise(MADV_SEQUENTIAL) on the
> mapping, and with madvise(MADV_WILLNEED) on pages about to be needed. These
> had no effect. What *did* help with underruns was pre-touching each page in
> a large block (120KB), before sending that block to the output device. At
> that point I thought the mmap() code was getting to be more complicated that
> it was worth so I just dropped back to read()...

There's a new system call, sys_readahead() which does what you want.

It would be nice to make the pagein code smarter though.

-
