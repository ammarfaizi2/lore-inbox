Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317307AbSFREWU>; Tue, 18 Jun 2002 00:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317308AbSFREWT>; Tue, 18 Jun 2002 00:22:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10654 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317307AbSFREWR>;
	Tue, 18 Jun 2002 00:22:17 -0400
Date: Mon, 17 Jun 2002 21:17:02 -0700 (PDT)
Message-Id: <20020617.211702.83417250.davem@redhat.com>
To: akpm@zip.com.au
Cc: adilger@clusterfs.com, linux-kernel@vger.kernel.org
Subject: Re: ext2 errors w/2.5.x
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D0EB3F2.C128F97C@zip.com.au>
References: <20020617.195611.61846581.davem@redhat.com>
	<20020618032544.GM22427@clusterfs.com>
	<3D0EB3F2.C128F97C@zip.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Mon, 17 Jun 2002 21:15:46 -0700

   Andreas Dilger wrote:
   > On Jun 17, 2002  19:56 -0700, David S. Miller wrote:
   > > EXT2-fs error (device sd(8,17)): ext2_find_entry: zero-length directory entry
   > 
   > This would appear to be from accessing a buffer (page) which has not yet
   > been read from disk.  Otherwise you would have an error from e2fsck also.
   > Andrew has been mucking the most in this area...

   Not that, I hope.  Possibly it's the interaction between
   block_write_full_pages's memset outside i_size, truncate and lookup.
   It took me a ridiculous amount of time to get that "correct", so
   it's a suspicion point.   Or possibly locking between lookup and
   truncate (rmdir) and/or creat.
   
   Dave, I assume this is with 8k pages and 4k blocks?
   
Yes, that is the case here.

   Is it repeatable enough to conduct a little experiment?  Like, lock the page
   in ext2_find_entry?
   
I'll try out your patch and get back to you, thanks.

Franks a lot,
David S. Miller
davem@redhat.com
