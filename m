Return-Path: <linux-kernel-owner+w=401wt.eu-S965501AbWLPUzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965501AbWLPUzd (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 15:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965498AbWLPUzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 15:55:33 -0500
Received: from amsfep20-int.chello.nl ([62.179.120.15]:42953 "EHLO
	amsfep20-int.chello.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965501AbWLPUzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 15:55:32 -0500
Subject: Re: Recent mm changes leading to filesystem corruption?
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       debian-kernel@lists.debian.org, linux-mm <linux-mm@kvack.org>,
       David Miller <davem@davemloft.net>
In-Reply-To: <20061216155044.GA14681@deprecation.cyrius.com>
References: <20061216155044.GA14681@deprecation.cyrius.com>
Content-Type: text/plain
Date: Sat, 16 Dec 2006 21:55:16 +0100
Message-Id: <1166302516.10372.5.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-16 at 16:50 +0100, Martin Michlmayr wrote:
> Debian recently applied a number of mm changes that went into 2.6.19
> to their 2.6.18 kernel for LSB 3.1 compliance (msync() had problems
> before).  Since then, some filesystem corruption has been observed
> which can be traced back to these mm changes.  Is anyone aware of
> problems with these patches?

As said by Hugh, no we were not.

> The patches that were applied are:
> 
>    - mm: tracking shared dirty pages
>    - mm: balance dirty pages
>    - mm: optimize the new mprotect() code a bit
>    - mm: small cleanup of install_page()
>    - mm: fixup do_wp_page()
>    - mm: msync() cleanup
> 
> With these applied to 2.6.18, the Debian installer on a slow ARM
> system fails because a program segfaults due to filesystem corruption:
> http://bugs.debian.org/401980  This problem also occurs if you only
> apply the "mm: tracking shared dirty pages" patch to 2.6.18 from the
> series of 5 patches listed above.

This made me think of a blog entry by DaveM from some time ago:
  http://vger.kernel.org/~davem/cgi-bin/blog.cgi/2006/06/09

> Another problem has been reported related to libtorrent: according to
> http://bugs.debian.org/402707 someone also saw this with non-Debian
> 2.6.19 but obviously it's hard to say whether the bugs are really
> related.
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=394392;msg=24 shows
> some dmesg messages but again it's not 100% clear it's the same bug.
> 
> Has anyone else seen problems or is aware of a fix to the patches
> listed above that I'm unaware of?  It's possible the problem only
> shows up on slow systems. (The corruption is reproducible on a slow
> NSLU2 ARM system with 32 MB ram, but it doesn't happen on a faster ARM
> box with more RAM.)

What is not clear from all these reports is what architectures this is
seen on. I suspect some of them are i686, which together with the
explicit mention of ARM make it a cross platform issue.



