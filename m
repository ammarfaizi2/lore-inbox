Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbTJDHls (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 03:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTJDHls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 03:41:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:51395 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261938AbTJDHlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 03:41:47 -0400
Date: Sat, 4 Oct 2003 00:42:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: joe.korty@ccur.com, linux-kernel@vger.kernel.org
Subject: Re: mlockall and mmap of IO devices don't mix
Message-Id: <20031004004246.13d1f977.akpm@osdl.org>
In-Reply-To: <m34qyp7ae4.fsf@averell.firstfloor.org>
References: <CFYv.787.23@gated-at.bofh.it>
	<m34qyp7ae4.fsf@averell.firstfloor.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> Joe Korty <joe.korty@ccur.com> writes:
> 
> >  
> > I do not believe that the above constitutes a correct fix.  The
> > problem is that follow_pages() is fundamentally not able to handle a
> > mapping which does not have a 'struct page' backing it up, and a
> > mapping to IO memory by definition has no 'struct page' structure to
> > back it up.
> 
> The 2.4 vm scanner handles this by always checking VALID_PAGE().
> 

VALID_PAGE got nuked.

It still exists in vestigial form in some architectures, but x86 does not
implement it and core kernel does not use it.

It is not a trivial thing to do now we no longer have a single mem_map[].
