Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTENXFv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 19:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263139AbTENXFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 19:05:51 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:47568
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263131AbTENXFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 19:05:50 -0400
Date: Thu, 15 May 2003 01:18:38 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.21rc2aa1
Message-ID: <20030514231838.GP1429@dualathlon.random>
References: <20030514202258.GF1429@dualathlon.random> <3EC2C5AC.6050709@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC2C5AC.6050709@gmx.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 12:39:40AM +0200, Carl-Daniel Hailfinger wrote:
> Andrea Arcangeli wrote:
> 
> > Only in 2.4.21rc2aa1: 00_remove_inode_page-prune_icache-smp-race-1
> > 
> > 	Fix mm corrupting SMP race between remove_inode_page and prune_icache.
> > 	Found by Chris Mason.
> 
> Any chance this will get into mainline before 2.4.21?

it's obviously safe so I think yes:

--- x/mm/filemap.c.~1~	2003-04-24 16:37:50.000000000 +0200
+++ x/mm/filemap.c	2003-04-24 17:05:10.000000000 +0200
@@ -100,9 +100,10 @@ static inline void remove_page_from_inod
 	if (mapping->a_ops->removepage)
 		mapping->a_ops->removepage(page);
 	
-	mapping->nrpages--;
 	list_del(&page->list);
 	page->mapping = NULL;
+	wmb();
+	mapping->nrpages--;
 }
 
 static inline void remove_page_from_hash_queue(struct page * page)


Marcelo please apply, thanks!

Andrea
