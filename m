Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751027AbWFDUSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWFDUSe (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 16:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWFDUSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 16:18:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31691 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751027AbWFDUSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 16:18:33 -0400
Date: Sun, 4 Jun 2006 13:18:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: [minor fix] radixtree: regulate tag get return value
Message-Id: <20060604131824.e2d1c934.akpm@osdl.org>
In-Reply-To: <349419864.11444@ustc.edu.cn>
References: <349410738.29011@ustc.edu.cn>
	<20060604021105.1ce7d727.akpm@osdl.org>
	<349419864.11444@ustc.edu.cn>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jun 2006 19:17:54 +0800
Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:

> > test_bit() is (sadly) defined to return 0 or 1.  Did this really make a difference?
> 
> Interesting. I got the following gdb outputs. Note that tag_get()
> returns -1 and root_tag_get() returns 1048576.
> 
> (gdb) n
> 399             while (height > 0) {
> (gdb) n
> 402                     offset = (index >> shift) & RADIX_TREE_MAP_MASK;
> (gdb)
> 403                     if (!tag_get(slot, tag, offset))
> (gdb)
> 404                             tag_set(slot, tag, offset);
> (gdb) p tag_get(slot, tag, offset)
> $14 = 0
> (gdb) n
> 405                     slot = slot->slots[offset];
> (gdb) p tag_get(slot, tag, offset)
> $15 = -1

You trust gdb more than I do ;)  It's doing a pretty tricky thing there.

test_bit() returns (1 & (expr)) - it _has_ to return 0 or 1.
