Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264231AbUGIE55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbUGIE55 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 00:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264251AbUGIE55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 00:57:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:36525 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264231AbUGIE54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 00:57:56 -0400
Date: Thu, 8 Jul 2004 21:56:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, mason@suse.com
Subject: Re: writepage fs corruption fixes
Message-Id: <20040708215645.16d0f227.akpm@osdl.org>
In-Reply-To: <20040709044205.GF20947@dualathlon.random>
References: <20040709040151.GB20947@dualathlon.random>
	<20040708212923.406135f0.akpm@osdl.org>
	<20040709044205.GF20947@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> BTW, the new mpage code looks great,

You should have seen the first version!  But after all the bugs were fixed
and the real world hit it, some spaghetti got in there.

> it's a pity that reiserfs and ext3 don't use it yet.

JFS, hfs, hfsplus and ext2 are using it.

Unfortunately it's hard to use mpage_writepages() even in ext3's writeback
mode, because ext3_get_block() assumes that it is called with a transaction
open.  Not impossible though I guess - use a different get_block() which
opens a transaction for itself...  But only open it if the page isn't
already mapped to disk.  (/me gets itchy fingers)


