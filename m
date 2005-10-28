Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965180AbVJ1IXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965180AbVJ1IXV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 04:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbVJ1IXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 04:23:21 -0400
Received: from koto.vergenet.net ([210.128.90.7]:18626 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1751618AbVJ1IXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 04:23:20 -0400
Date: Fri, 28 Oct 2005 17:22:52 +0900
From: Horms <horms@verge.net.au>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: 333776@bugs.debian.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bug#333776: linux-2.6: vfat driver in 2.6.12 is not properly case-insensitive
Message-ID: <20051028082252.GC11045@verge.net.au>
References: <20051013165529.GA2472@tennyson.dodds.net> <20051014023216.GJ8848@verge.net.au> <20051015003549.GB11040@tennyson.dodds.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051015003549.GB11040@tennyson.dodds.net>
X-Cluestick: seven
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ogawa-san,

I'm bringing this to you attention because a) I'm not sure who to ask
and b) I'm not sure what the correct behaviour is.

When a vfat filesystem is mounted isocharset=iso8859-1, then the
following works:

touch a.txt
ls A.txt

But when it is mounted isocharset=utf8, then ls complains, file not
found:

touch a.txt
ls A.txt

That is, in utf8, a =! A on vfat, and thus its not case insensitive
as one might expect.

I took a quick look in fs/nls/nls_utf8.c and I see that this is
intentional.

static struct nls_table table = {
        .charset        = "utf8",
        .uni2char       = uni2char,
        .char2uni       = char2uni,
        .charset2lower  = identity,     /* no conversion */
        .charset2upper  = identity,
        .owner          = THIS_MODULE,
};

I guess it is charset2lower or charset2upper that vfat is calling,
which make no conversion, thus leading to the problem I outlined above.

My question is: Is this behaviour correct, or is it a bug?

-- 
Horms
