Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266547AbUIISZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266547AbUIISZR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266491AbUIISYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 14:24:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:57534 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266508AbUIISIq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 14:08:46 -0400
Date: Thu, 9 Sep 2004 11:06:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: torvalds@osdl.org, dev@sw.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adding per sb inode list to make invalidate_inodes()
 faster
Message-Id: <20040909110622.78028ae6.akpm@osdl.org>
In-Reply-To: <20040909171927.GU3106@holomorphy.com>
References: <4140791F.8050207@sw.ru>
	<Pine.LNX.4.58.0409090844410.5912@ppc970.osdl.org>
	<20040909171927.GU3106@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Thu, Sep 09, 2004 at 08:51:45AM -0700, Linus Torvalds wrote:
>  > Hmm.. I don't mind the approach per se, but I get very nervous about the 
>  > fact that I don't see any initialization of "inode->i_sb_list".
>  > Yes, you do a
>  > 	list_add(&inode->i_sb_list, &sb->s_inodes);
>  > in new_inode(), but there are a ton of users that allocate inodes other 
>  > ways, and more importantly, even if this was the only allocation function, 
>  > you do various "list_del(&inode->i_sb_list)" things which leaves the inode 
>  > around but with an invalid superblock list.
>  > So at the very _least_, you should document why all of this is safe very 
>  > carefully (I get nervous about fundamental FS infrastructure changes), and 
>  > it should be left to simmer in -mm for a longish time to make sure it 
>  > really works..
>  > Call me chicken.
> 
>  Some version of this patch has been in 2.6.x-mm for a long while.

One year.

> I've
>  not reviewed this version of the patch for differences with the -mm
>  code. It would probably be best to look at the -mm bits as they've had
>  sustained exposure for quite some time.

Yes.

I have not merged it up because it seems rather dopey to add eight bytes to
the inode to speed up something as rare as umount.

Is there a convincing reason for proceeding with the change?
