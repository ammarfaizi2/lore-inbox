Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263469AbTJBS5A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 14:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263470AbTJBS5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 14:57:00 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:29453 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S263469AbTJBS44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 14:56:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: Jeff Garzik <jgarzik@pobox.com>, Larry McVoy <lm@bitmover.com>
Subject: Re: Minutes from 10/1 LSE Call
Date: Thu, 2 Oct 2003 21:56:49 +0300
X-Mailer: KMail [version 1.4]
Cc: Andrew Morton <akpm@osdl.org>, Hanna Linder <hannal@us.ibm.com>,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <37940000.1065035945@w-hlinder> <20031001233815.GB29605@work.bitmover.com> <3F7B701C.5020708@pobox.com>
In-Reply-To: <3F7B701C.5020708@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200310022156.49678.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 October 2003 03:23, Jeff Garzik wrote:
> Larry McVoy wrote:
> > On Wed, Oct 01, 2003 at 04:29:16PM -0700, Andrew Morton wrote:
> >>If you have a loop like:
> >>
> >>	char *buf;
> >>
> >>	for (lots) {
> >>		read(fd, buf, size);
> >>	}
> >>
> >>the optimum value of `size' is small: as little as 8k.  Once `size' gets
> >>close to half the size of the L1 cache you end up pushing the memory at
> >>`buf' out of CPU cache all the time.
> >
> > I've seen this too, not that Andrew needs me to back him up, but in many
> > cases even 4k is big enough.  Linux has a very thin system call layer so
> > it is OK, good even, to use reasonable buffer sizes.
>
> Slight tangent, FWIW...   Back when I was working on my "race-free
> userland" project, I noticed that the fastest cp(1) implementation was
> GNU's:  read/write from a single, statically allocated, page-aligned 4K
> buffer.  I experimented with various buffer sizes, mmap-based copies,
> and even with sendfile(2) where both arguments were files.
> read(2)/write(2) of a single 4K buffer was always the fastest.

That sounds reasonable, but today's RAM throughput is on the order
of 1GB/s, not 100Mb/s. 'Out of L1' theory can't explain 100Mb/s ceiling
it seems.
--
vda
