Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161204AbVIPRkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161204AbVIPRkc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 13:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161206AbVIPRkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 13:40:32 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61623 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161204AbVIPRkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 13:40:31 -0400
Date: Fri, 16 Sep 2005 18:40:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Message-ID: <20050916174028.GA32745@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>,
	ReiserFS List <reiserfs-list@namesys.com>
References: <432AFB44.9060707@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432AFB44.9060707@namesys.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

more trivial review comments ontop of the previous one, after looking
at things:

 - please never use list_for_each in new code but list_for_each_entry
 - never use kernel_thread in new code but kthread_*
 - do_sendfile duplicates the common sendfile code.  why aren't you
   using the generic code?
 - there's tons of really useless assertation of the category
   discussed in the last thread
 - there's tons of deep pagecache messing in there.  normally this
   shouldn't be a filesystem, and if this breaks because of VM changes you'll
   have to fix it, don't complain..
 - you still do your plugin mess in ->readpage.  honsetly could you
   please explain why mpage_readpage{,s} don't work for you?
 - (issues with the read/write path already addresses in the previous thread)
 - looking at ->d_count in ->release is wrong
 - still has security plugin stuff that duplicates LSM
 - why do underlying attributes change when VFS inode doesn't change?
   if not please rip out most of getattr_common
 - link_common S_ISDIR doesn't make sense, VFS takes care of it
 - please use the generic_readlink infrastructure

additinoal comment is that the code is very messy, very different
from normal kernel style, full of indirections and thus hard to read.
real review will take some time.
