Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbUBYQXs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 11:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbUBYQXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 11:23:44 -0500
Received: from hera.kernel.org ([63.209.29.2]:59839 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261417AbUBYQXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 11:23:13 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: BOOT_CS
Date: Wed, 25 Feb 2004 16:23:09 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c1ii5d$e3k$1@terminus.zytor.com>
References: <20040225103043.44010.qmail@web11807.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1077726189 14453 63.209.29.3 (25 Feb 2004 16:23:09 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 25 Feb 2004 16:23:09 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040225103043.44010.qmail@web11807.mail.yahoo.com>
By author:    =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
In newsgroup: linux.dev.kernel
> 
>  What I did is simply load and uncompress Linux to a legally allocated
>  HIMEM block (so that is a 100 % compatible DOS software, you can use
>  a network disk or a disk cache for that) and check everything is right
>  before disabling interruption, switch back to real mode with
>  4 Gb segments of non paged memory, copy the block at the right place, 
>  and start Linux in protected mode.
>  You have to remember keeping the code short in between the back switch
>  to real mode and the start of Linux because the data (Linux kernel)
>  is at a clear physical address, but your code itself is in a 4 Kbyte
>  page which is available - but the page after it may not be loaded
>  so no more code...
> 

[...]

There is a hook in the kernel immediately after enteing protected mode
for *exactly* this reason -- it was added to support LOADLIN.  The
whole point is that your boot loader obtains control at that point so
you can put things back where they need to go (such as 0x100000 for
the main part of the kernel, which you will *never* get from an
HMA-enabled DOS.)  The algorithm for that is pretty straightforward;
you can even deal with the case where you have scattered pages all
over memory.

	-hpa

