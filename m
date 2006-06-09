Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbWFISCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbWFISCw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbWFISCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:02:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39815 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030338AbWFISCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:02:50 -0400
Date: Fri, 9 Jun 2006 11:02:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: alex@clusterfs.com, jeff@garzik.org, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, adilger@clusterfs.com
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-Id: <20060609110236.c342e28c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<4488E1A4.20305@garzik.org>
	<20060609083523.GQ5964@schatzie.adilger.int>
	<44898EE3.6080903@garzik.org>
	<448992EB.5070405@garzik.org>
	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
	<m33beecntr.fsf@bzzz.home.net>
	<Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2006 09:25:57 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> (buffer heads! In 2006!)

We should be able to make the vast majority of those go away, btw.

We already have `-o data=writeback,nobh'.  That gives us writeback-mode
with no buffer_heads on the pagecache.

On top of that we can implement nobh ordered-mode by adding an inode walk
which calls do_sync_file_range() into the appropriate place in commit.

The tricky part is the inode walk - at present super_block.s_list is a
list_head and it's not trivial to walk that without missing some inodes.

Probably it could be done via a new fs-private dirty-inode list which we
hande carefully, or via a walk of an i_ino-ordered radix-tree, which
doesn't miss things.

I floated this a year or so ago, but no little fishies bit.
