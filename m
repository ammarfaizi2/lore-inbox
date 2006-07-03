Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWGCOmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWGCOmR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 10:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWGCOmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 10:42:17 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:49386 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750758AbWGCOmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 10:42:16 -0400
Date: Mon, 3 Jul 2006 16:42:02 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Theodore Tso <tytso@mit.edu>
cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 7/8] inode-diet: Use a union for i_blocks and i_size,
 i_rdev and i_devices
In-Reply-To: <20060703140217.GA8099@thunk.org>
Message-ID: <Pine.LNX.4.61.0607031637280.26749@yvahk01.tjqt.qr>
References: <20060703005333.706556000@candygram.thunk.org>
 <20060703010023.720991000@candygram.thunk.org> <20060703090642.GB8242@infradead.org>
 <20060703140217.GA8099@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > The i_blocks and i_size fields are only used for regular files.  So we
>> > move them into the union, along with i_rdev and i_devices, which are
>> > only used by block or character devices.
>> 
>> Can we please make this a named instead of unnamed union so everyone still
>> using the fields will trip up?  To reduce the impact a few more imajor/iminor
>> conversions might be needed were direct references to i_rdev crept back in.
>
>I did that originally but when I sent out my first version of patches
>for review, other developers asked me to use an unnamed union ---
>since otherwise the patch would be much, much larger (lots of changes
>would need to be made) and that makes it much harder to merge into
>either Andrew's or Linus's tree.
>
>What do other people think?  I can go either way on this one.

I prefer unnamed. A dislike it when unions make initializers longer 
than necessary, even if it's short.

  inode->u.file.a.i_blksize...
vs
  inode->i_blksize



Jan Engelhardt
-- 
