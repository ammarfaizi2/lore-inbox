Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264949AbUGGHlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbUGGHlp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 03:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbUGGHlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 03:41:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:35014 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264949AbUGGHll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 03:41:41 -0400
Date: Wed, 7 Jul 2004 00:40:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Brad Fitzpatrick <brad@danga.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs_inode_cache not getting pruned
Message-Id: <20040707004034.540e3fcb.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.55.0407062344210.24800@danga.com>
References: <Pine.LNX.4.55.0407062045200.24800@danga.com>
	<20040706212218.5ef9556d.akpm@osdl.org>
	<Pine.LNX.4.55.0407062344210.24800@danga.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Fitzpatrick <brad@danga.com> wrote:
>
> On Tue, 6 Jul 2004, Andrew Morton wrote:
> 
>  > Brad Fitzpatrick <brad@danga.com> wrote:
>  > >
>  > > I've got a couple boxes here that keep running out of lowmem after about a
>  > >  day of uptime, rendering them almost entirely unusable.  (OOM killer
>  > >  taking out processes left and right, despite 1.5 GB highmem available...)
>  > >
>  > >  From what I can tell, nfs_inode_cache isn't responding to memory pressure
>  > >  and cleaning itself (enough?).
>  >
>  > It works OK here.  Please provide kernel version and full NFS mount options.
> 
>  2.6.7, both client and server.
> 
>  Both machines are exporting 14 filesystems (each ext3 on 3w-9xxx) and
>  mounting the other's 14 over NFSv3:

Sorry, I still cannot reproduce it.  I suspect it's specific to the access
patterns in some way.

Are you able to generate some simple testcase which demonstrates the
problem?  Say, start off from a clean boot, just mount a single filesystem
and then find some access pattern which causes the inode cache to get
stuck?

Also, perhaps the entire VFS cache reclaim mechanism got stuck - check the
logs for any oopses, because that can do it for sure.

And do a huge ls -lR on a local filesystem, check that the local filesystem
VFS caches are being correctly reclaimed.


