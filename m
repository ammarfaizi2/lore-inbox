Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261454AbSJMHvJ>; Sun, 13 Oct 2002 03:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261455AbSJMHvJ>; Sun, 13 Oct 2002 03:51:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:58252 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261454AbSJMHvI>;
	Sun, 13 Oct 2002 03:51:08 -0400
Date: Sun, 13 Oct 2002 00:50:05 -0700 (PDT)
Message-Id: <20021013.005005.41948345.davem@redhat.com>
To: wagnerjd@prodigy.net
Cc: robm@fastmail.fm, hahn@physics.mcmaster.ca, linux-kernel@vger.kernel.org,
       jhoward@fastmail.fm
Subject: Re: Strange load spikes on 2.4.19 kernel
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <000c01c2728d$263c0ca0$7443f4d1@joe>
References: <20021013.000127.43007739.davem@redhat.com>
	<000c01c2728d$263c0ca0$7443f4d1@joe>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Joseph D. Wagner" <wagnerjd@prodigy.net>
   Date: Sun, 13 Oct 2002 02:49:55 -0500

   > But there is no fundamental reason for that, we just haven't
   > gotten around to threading that bit yet.
   
   Oh yes there is.  What if an allocation of blocks and/or inodes is
   preempted?  Another thread could attempt to allocate the same set of
   blocks and/or inodes.
   
That's why we protect the allocation with SMP locking primitives
which under Linux prevent preemption.

This isn't rocket science, the IP networking is fully threaded for
example and I consider that about as hard to thread as something like
ext2/ext3 inode/block allocation.

Also, as Andi Kleen noted, it's actually filesystem dependant whether
the inode/block allocation is threaded or not.
