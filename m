Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282469AbRKZT7l>; Mon, 26 Nov 2001 14:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282459AbRKZT6Q>; Mon, 26 Nov 2001 14:58:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:11648 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S282464AbRKZT5j>;
	Mon, 26 Nov 2001 14:57:39 -0500
Date: Mon, 26 Nov 2001 11:57:23 -0800 (PST)
Message-Id: <20011126.115723.41632923.davem@redhat.com>
To: akpm@zip.com.au
Cc: mingo@elte.hu, velco@fadata.bg, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] Scalable page cache
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C029BE0.2BEA2264@zip.com.au>
In-Reply-To: <Pine.LNX.4.33.0111262201420.18923-100000@localhost.localdomain>
	<20011126.111854.102567147.davem@redhat.com>
	<3C029BE0.2BEA2264@zip.com.au>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Mon, 26 Nov 2001 11:45:36 -0800

   It would be nice to have a full complement of non-atomic
   bitops.  At present we have __set_bit, but no __clear_bit, etc.
   
   So we often do buslocked RMW's in places where it's not needed.

I totally agree about fixing up bitops.

I have a patch which cleans up the filesystem bitops.  Specifically,
right now we use things like "ext2_set_bit()" in places where we care
what the old value was and also in places where we don't.

So I added "ext2_test_and_set_bit()" and the like.

I therefore plan to flesh this out, and flesh out the non-atomic
bitops, then resubmit.

I did the work originally during 2.4.15-preX which made me have to
back it out of my tree temporarily while Linus was in anal patch
acceptance mode.

Ahh, speaking of bitops, what's the status of the ext3 bitops bugs I
found Andrew? :-)  Those are pretty serious.
