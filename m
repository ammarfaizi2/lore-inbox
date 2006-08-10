Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161090AbWHJGjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161090AbWHJGjU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161088AbWHJGjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:39:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19097 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161042AbWHJGjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:39:19 -0400
Date: Wed, 9 Aug 2006 23:39:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: cmm@us.ibm.com
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] Forking ext4 filesystem from ext3 filesystem
Message-Id: <20060809233914.35ab8792.akpm@osdl.org>
In-Reply-To: <1155172622.3161.73.camel@localhost.localdomain>
References: <1155172622.3161.73.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2006 18:17:02 -0700
Mingming Cao <cmm@us.ibm.com> wrote:

> Fork(copy) ext4 filesystem from ext3 filesystem. Rename all functions in ext4 from ext3_xxx() to ext4_xxx().

It would have been nice to spend a few hours cleaning up ext3 and JBD
before doing this.  The code isn't toooo bad, but there are number of
coding style problems, whitespace screwups, incorrect comments, missing
comments, poorly-chosen variable names and all of that sort of thing.

One the fs has been copied-and-pasted, it's much harder to address these
things: either need to do it twice, or allow the filesystems to diverge, or
not do it.

Also, -mm presently has two patches pending against fs/jbd/ and nine pending
against fs/ext3/.  We should get all those things merged before taking the
copy.

Also, JBD is presently feeding into submit_bh() buffer_heads which span two
machine pages, and some device drivers spit the dummy.  It'd be better to
fix that once, rather than twice..  
