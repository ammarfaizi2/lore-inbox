Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266351AbUIIRVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266351AbUIIRVm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 13:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266366AbUIIRVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 13:21:22 -0400
Received: from holomorphy.com ([207.189.100.168]:43441 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266362AbUIIRUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:20:09 -0400
Date: Thu, 9 Sep 2004 10:19:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kirill Korotaev <dev@sw.ru>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adding per sb inode list to make invalidate_inodes() faster
Message-ID: <20040909171927.GU3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@osdl.org>, Kirill Korotaev <dev@sw.ru>,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <4140791F.8050207@sw.ru> <Pine.LNX.4.58.0409090844410.5912@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409090844410.5912@ppc970.osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 08:51:45AM -0700, Linus Torvalds wrote:
> Hmm.. I don't mind the approach per se, but I get very nervous about the 
> fact that I don't see any initialization of "inode->i_sb_list".
> Yes, you do a
> 	list_add(&inode->i_sb_list, &sb->s_inodes);
> in new_inode(), but there are a ton of users that allocate inodes other 
> ways, and more importantly, even if this was the only allocation function, 
> you do various "list_del(&inode->i_sb_list)" things which leaves the inode 
> around but with an invalid superblock list.
> So at the very _least_, you should document why all of this is safe very 
> carefully (I get nervous about fundamental FS infrastructure changes), and 
> it should be left to simmer in -mm for a longish time to make sure it 
> really works..
> Call me chicken.

Some version of this patch has been in 2.6.x-mm for a long while. I've
not reviewed this version of the patch for differences with the -mm
code. It would probably be best to look at the -mm bits as they've had
sustained exposure for quite some time.


-- wli
