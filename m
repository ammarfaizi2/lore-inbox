Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbTIPX7T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 19:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262551AbTIPX7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 19:59:19 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:3085
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262546AbTIPX7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 19:59:18 -0400
Date: Tue, 16 Sep 2003 16:59:38 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, oliver@neukum.org
Subject: Re: OOps in HFS was: 2.6.0-test4-mm3
Message-ID: <20030916235938.GB3490@matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, oliver@neukum.org
References: <20030828235649.61074690.akpm@osdl.org> <20030916214105.GA3490@matchmail.com> <20030916144012.0ab9b009.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030916144012.0ab9b009.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 02:40:12PM -0700, Andrew Morton wrote:
> Mike Fedyk <mfedyk@matchmail.com> wrote:
> >
> > Just reading a hfs floppy...
> 
> It's not an oops - it's a warning.
> 

Oh, sorry, I didn't notice.  Will try harder next time. ;)

> > Sep 15 10:10:49 mis-mike-wstn kernel: inserting floppy driver for 2.6.0-test4-mm3-1-mdfail
> > Sep 15 10:10:49 mis-mike-wstn kernel: Floppy drive(s): fd0 is 1.44M
> > Sep 15 10:10:49 mis-mike-wstn kernel: FDC 0 is a post-1991 82077
> > Sep 15 10:10:49 mis-mike-wstn kernel: PM: Adding info for platform:floppy0
> > Sep 15 10:11:14 mis-mike-wstn kernel: Debug: sleeping function called from invalid context at mm/slab.c:1833
> > Sep 15 10:11:14 mis-mike-wstn kernel: Call Trace:
> > Sep 15 10:11:14 mis-mike-wstn kernel:  [__might_sleep+99/104] __might_sleep+0x63/0x68
> > Sep 15 10:11:15 mis-mike-wstn kernel:  [kmem_cache_alloc+37/324] kmem_cache_alloc+0x25/0x144
> > Sep 15 10:11:15 mis-mike-wstn kernel:  [_end+340461616/1068932160] grow_entries+0x24/0xa0 [hfs]
> > Sep 15 10:11:15 mis-mike-wstn kernel:  [_end+340462938/1068932160] get_new_entry+0x1e/0x460 [hfs]
> 
> get_entry() does disk I/O under spin_lock(&entry_lock).  Deadlock country.
> A simple fix would be to convert entry_lock into a semaphore.
> 

Maybe.  It's a client diskette.  Would it be ok if a couple files were
truncated or filled with zeros?

> > Sep 15 10:21:11 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: c261451c
> > Sep 15 10:21:11 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: cc08f104
> > Sep 15 10:21:11 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: c7997ccc
> > Sep 15 10:21:11 mis-mike-wstn kernel: hfs_cat_put: trying to free free entry: c6cb9728
> 
> Well that's not very good.  Can you make an image of that floppy available for download?
> 
> Does 2.4's HFS driver work OK?

I will give that a try.
