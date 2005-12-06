Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751508AbVLFAKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbVLFAKr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbVLFAKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:10:47 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:65482 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751508AbVLFAKq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:10:46 -0500
Date: Tue, 6 Dec 2005 01:10:06 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org, bharata@in.ibm.com
Subject: Re: 2.6.14 kswapd eating too much CPU
Message-ID: <20051206001006.GX22772@fi.muni.cz>
References: <20051123110241.528a0b37.akpm@osdl.org> <20051123202438.GE28142@fi.muni.cz> <20051123123531.470fc804.akpm@osdl.org> <20051124083141.GJ28142@fi.muni.cz> <20051127084231.GC20701@logos.cnet> <20051127203924.GE27805@fi.muni.cz> <20051127160207.GE21383@logos.cnet> <20051127152108.11f58f9c.akpm@osdl.org> <20051128131648.GG19307@fi.muni.cz> <20051128080446.GA23516@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051128080446.GA23516@logos.cnet>
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
: I wonder why prune_icache() does not move inodes with positive i_count
: to inode_inuse list, letting iput() take care of moving to unused
: once the count reaches zero.
: 
:                 inode = list_entry(inode_unused.prev, struct inode, i_list);
:                 if (inode->i_state || atomic_read(&inode->i_count)) {
:                         list_move(&inode->i_list, &inode_unused);
:                         continue;
:                 }
: 
: Couldnt it be 
: 			list_move(&inode->i_list, &inode_inuse);
: 
: ?

	Hmm, this code is indeed strange. Why does it move the inode
to the inode_unused list, when the inode has in fact been _found_ while
scanning the inode_unused list? And how can an inode with positive
->i_count end up on the inode_unused list?

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
> Specs are a basis for _talking_about_ things. But they are _not_ a basis <
> for implementing software.                              --Linus Torvalds <
