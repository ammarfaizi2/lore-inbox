Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUDJRtc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 13:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbUDJRtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 13:49:32 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:60428 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262079AbUDJRtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 13:49:31 -0400
Date: Sat, 10 Apr 2004 21:46:33 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Richard Henderson <rth@twiddle.net>, Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ALPHA] Fix unaligned stxncpy again
Message-ID: <20040410214633.A24987@jurassic.park.msu.ru>
References: <20040409103244.GA1904@gondor.apana.org.au> <20040409233511.B727@den.park.msu.ru> <20040409235040.GA14950@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040409235040.GA14950@gondor.apana.org.au>; from herbert@gondor.apana.org.au on Sat, Apr 10, 2004 at 09:50:40AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2004 at 09:50:40AM +1000, Herbert Xu wrote:
> Thanks.  But is there any reason why we need to have code that
> is different from glibc?

The code is different anyway because the glibc routine clobbers
t7 register which must not be touched in the kernel.
Apparently the whole mess started with a typo in the register
renaming patch...
Yes, ideally glibc and kernel stxncpy code can be exactly the same,
but this assumes that the glibc variant is updated to not use the t7.

Ivan.
