Return-Path: <linux-kernel-owner+w=401wt.eu-S933102AbWLaJL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933102AbWLaJL1 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 04:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933101AbWLaJL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 04:11:27 -0500
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:44516 "EHLO
	mail-gw2.sa.eol.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933099AbWLaJL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 04:11:26 -0500
To: davem@davemloft.net
CC: rmk+lkml@arm.linux.org.uk, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, akpm@osdl.org
In-reply-to: <20061230.212338.92583434.davem@davemloft.net> (message from
	David Miller on Sat, 30 Dec 2006 21:23:38 -0800 (PST))
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
 that again
References: <20061230165012.GB12622@flint.arm.linux.org.uk>
	<Pine.LNX.4.64.0612301022200.4473@woody.osdl.org>
	<20061230224604.GA3350@flint.arm.linux.org.uk> <20061230.212338.92583434.davem@davemloft.net>
Message-Id: <E1H0wiB-0003iu-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 31 Dec 2006 10:10:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Therefore, FUSE probably could have been fixed by judicious use
> of copy_{to,from}_user_page() calls instead of adding this new
> ad-hoc flush_anon_page() thing.

Probably, but I don't think either interface is perfect.
copy_*_user_page() will double flush the user mapping
(get_user_pages() already does a flush_dcache_page()).  Actually
nothing except ptrace uses the copy_*_user_page() interface even
though there are many uses of get_user_pages().

What I think get_user_pages() really needs is a single operation that

  - flushes the virtual address view
  - flushes the kernel view

regardles whether the page is anonymous or file backed.

Miklos
