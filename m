Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312088AbSCQSS6>; Sun, 17 Mar 2002 13:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312087AbSCQSSu>; Sun, 17 Mar 2002 13:18:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:64784 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312091AbSCQSSi>; Sun, 17 Mar 2002 13:18:38 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Date: Sun, 17 Mar 2002 18:16:47 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a72mif$941$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0203161203050.31971-100000@penguin.transmeta.com> <Pine.LNX.4.44L.0203171021090.2181-100000@imladris.surriel.com>
X-Trace: palladium.transmeta.com 1016389104 18802 127.0.0.1 (17 Mar 2002 18:18:24 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 17 Mar 2002 18:18:24 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.44L.0203171021090.2181-100000@imladris.surriel.com>,
Rik van Riel  <riel@conectiva.com.br> wrote:
>
>In other words, large pages should be a "special hack" for
>special applications, like Oracle and maybe some scientific
>calculations ?

Yes, I think so.

That said, a 64kB page would be useful for generic use. 

>Grabbing some bitflags in generic datastructures shouldn't
>be an issue since free bits are available.

I had large-page-support working in the VM a long time ago, back when I
did the original VM portability rewrite.  I actually exposed the kernel
large pages to the VM, and it worked fine - I didn't even need a new
bit, since the code just used the "large page" bit in the page table
directly. 

But it wasn't ever exposed to user space, and in the end I just made the
kenel mapping just not visible to the VM and simplified the x86
pmd_xxx() macros.  The approach definitely worked, though. 

			Linus
