Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314835AbSG3IIS>; Tue, 30 Jul 2002 04:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315119AbSG3IIS>; Tue, 30 Jul 2002 04:08:18 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:38413 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S314835AbSG3IIS>; Tue, 30 Jul 2002 04:08:18 -0400
Date: Tue, 30 Jul 2002 09:11:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: async-io API registration for 2.5.29
Message-ID: <20020730091140.A6726@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
	linux-aio@kvack.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020730054111.GA1159@dualathlon.random>; from andrea@suse.de on Tue, Jul 30, 2002 at 07:41:11AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 07:41:11AM +0200, Andrea Arcangeli wrote:
> I find the dynamic syscall approch in some vendor kernel out there
> that implements a /proc/libredhat unacceptable since it's not forward
> compatible with 2.5:

What is /proc/libredhat supposed to be?  It hasn't ever been part of the
AIO patches.

> ). So I would ask if you could merge the below interface into 2.5 so we can
> ship a real async-io with real syscalls in 2.4, there's not much time to
> change it given this is just used in production userspace today. I
> prepared a patch against 2.5.29. Ben, I would appreciate if you could
> review and confirm you're fine with it too.

Please don't.  First Ben has indicated on kernel summit that the abi might
change and I think it's a bad idea to lock him into the old ABI just because
suse doesn't want to have something called libredhat.so* in /lib.
Alternate suggestion: rename it to libunited.so.

And even if there is a syscall reservation the way to do it is not to add
the real syscall names to entry.S and implement stubs but to use
sys_ni_syscall.

> BTW, I'm not the author of the API, and personally I dislike the
> sys_io_sumbit approch, the worst part is the multiplexing of course:

Okay.  So you think the API is stupid but want it to get in without
discussion??

If you really want to ship the old-style AIO (of which I remember ben
saying it it broken for everything post-2.4.9) please stick to the patch
Ben has around, otherwise wait for the proper 2.5 solution.  I have my
doubts that it is backportable, though.
