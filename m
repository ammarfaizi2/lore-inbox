Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbUBVGPf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 01:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbUBVGPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 01:15:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:52190 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261170AbUBVGPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 01:15:34 -0500
Date: Sat, 21 Feb 2004 22:15:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: cw@f00f.org, mfedyk@matchmail.com, linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
Message-Id: <20040221221553.01b1b71c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org>
References: <4037FCDA.4060501@matchmail.com>
	<20040222023638.GA13840@dingdong.cryptoapps.com>
	<Pine.LNX.4.58.0402211901520.3301@ppc970.osdl.org>
	<20040222031113.GB13840@dingdong.cryptoapps.com>
	<Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> What happened to the experiment of having slab pages on the (in)active
>  lists and letting them be free'd that way? Didn't somebody already do 
>  that? Ed Tomlinson and Craig Kulesa?

That was Ed.  Because we cannot reclaim slab pages direct from the LRU it
turned out that putting slab pages onto the LRU was merely an extremely
complicated way of making the VFS cache scanning rate porportional to the
pagecache scanning rate.  So we ended up doing just that, without putting
the slab pages on the LRU.


