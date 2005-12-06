Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbVLFSOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbVLFSOg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 13:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbVLFSOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 13:14:36 -0500
Received: from hera.kernel.org ([140.211.167.34]:46554 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S964995AbVLFSOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 13:14:35 -0500
Date: Tue, 6 Dec 2005 16:14:12 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org, bharata@in.ibm.com
Subject: Re: 2.6.14 kswapd eating too much CPU
Message-ID: <20051206181412.GA18070@dmt.cnet>
References: <20051123202438.GE28142@fi.muni.cz> <20051123123531.470fc804.akpm@osdl.org> <20051124083141.GJ28142@fi.muni.cz> <20051127084231.GC20701@logos.cnet> <20051127203924.GE27805@fi.muni.cz> <20051127160207.GE21383@logos.cnet> <20051127152108.11f58f9c.akpm@osdl.org> <20051128131648.GG19307@fi.muni.cz> <20051128080446.GA23516@logos.cnet> <20051206001006.GX22772@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051206001006.GX22772@fi.muni.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 01:10:06AM +0100, Jan Kasprzak wrote:
> Marcelo Tosatti wrote:
> : I wonder why prune_icache() does not move inodes with positive i_count
> : to inode_inuse list, letting iput() take care of moving to unused
> : once the count reaches zero.
> : 
> :                 inode = list_entry(inode_unused.prev, struct inode, i_list);
> :                 if (inode->i_state || atomic_read(&inode->i_count)) {
> :                         list_move(&inode->i_list, &inode_unused);
> :                         continue;
> :                 }
> : 
> : Couldnt it be 
> : 			list_move(&inode->i_list, &inode_inuse);
> : 
> : ?
> 
> 	Hmm, this code is indeed strange. Why does it move the inode
> to the inode_unused list, when the inode has in fact been _found_ while
> scanning the inode_unused list? 

It just moves to the head of the list, for later scanning.

> And how can an inode with positive ->i_count end up on the
> inode_unused list?

Such inodes only end up in the unused list during superblock
shutdown, so they should not be a problem actually (my bad).

