Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277413AbRJOLn6>; Mon, 15 Oct 2001 07:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277414AbRJOLns>; Mon, 15 Oct 2001 07:43:48 -0400
Received: from pcephc56.cern.ch ([137.138.38.92]:40832 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S277413AbRJOLnf>; Mon, 15 Oct 2001 07:43:35 -0400
Date: Mon, 15 Oct 2001 13:43:28 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
Message-ID: <20011015134328.C4269@kushida.jlokier.co.uk>
In-Reply-To: <20011013214603.A1144@kushida.jlokier.co.uk> <Pine.LNX.4.33.0110131516350.8983-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0110131516350.8983-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Oct 13, 2001 at 03:19:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Now, that's a traditional mmap(), though, which has more overhead than a
> "read-with-PAGE_COPY" would have. The pure mmap() approach has the actual
> page fault overhead too, along with having to do "fstat()" and "munmap()".

read() into a freshly allocated buffer (as you do for any large file)
has page fault overhead too -- to allocate zero pages.  It may be a
greater overhead, because the pages are unnecessarily zeroed.

read-with-PAGE_COPY may eliminate both of these overheads.

But then, even without PAGE_COPY, a read() which looks at the receiving
process' page tables may be able to eliminate the page faults, by simply
allocating (without zeroing) pages in kernel context prior to copying
the data there.

-- Jamie


