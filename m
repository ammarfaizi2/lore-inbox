Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUIITjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUIITjd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 15:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266805AbUIITgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 15:36:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:7297 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266775AbUIITKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 15:10:43 -0400
Date: Thu, 9 Sep 2004 12:08:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: torvalds@osdl.org, dev@sw.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adding per sb inode list to make invalidate_inodes()
 faster
Message-Id: <20040909120818.7f127d14.akpm@osdl.org>
In-Reply-To: <20040909181818.GF3106@holomorphy.com>
References: <4140791F.8050207@sw.ru>
	<Pine.LNX.4.58.0409090844410.5912@ppc970.osdl.org>
	<20040909171927.GU3106@holomorphy.com>
	<20040909110622.78028ae6.akpm@osdl.org>
	<20040909181818.GF3106@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Thu, Sep 09, 2004 at 11:06:22AM -0700, Andrew Morton wrote:
>  > Yes.
>  > I have not merged it up because it seems rather dopey to add eight bytes to
>  > the inode to speed up something as rare as umount.
>  > Is there a convincing reason for proceeding with the change?
> 
>  The only motive I'm aware of is for latency in the presence of things
>  such as autofs. It's also worth noting that in the presence of things
>  such as removable media umount is also much more common. I personally
>  find this sufficiently compelling. Kirill may have additional ammunition.

Well.  That's why I'm keeping the patch alive-but-unmerged.  Waiting to see
who wants it.

There are people who have large machines which are automounting hundreds of
different NFS servers.  I'd certainly expect such a machine to experience
ongoing umount glitches.  But no reports have yet been sighted by this
little black duck.

>  Also, the additional sizeof(struct list_head) is only a requirement
>  while the global inode LRU is maintained. I believed it would have
>  been beneficial to have localized the LRU to the sb also, which would
>  have maintained sizeof(struct inode0 at parity with current mainline.

Could be.  We would give each superblock its own shrinker callback and
everything should balance out nicely (hah).
