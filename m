Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130426AbRCCHAp>; Sat, 3 Mar 2001 02:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130428AbRCCHA0>; Sat, 3 Mar 2001 02:00:26 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:35720 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130426AbRCCHAS>;
	Sat, 3 Mar 2001 02:00:18 -0500
Date: Sat, 3 Mar 2001 02:00:16 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: TimO <hairballmt@mcn.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS-kernel 2.4.3-pre1
In-Reply-To: <Pine.GSO.4.21.0103030140070.17703-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0103030154190.17703-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




[sorry for sel-followup, but...]
 
> Lovely. sb->s_op == NULL in iget(). The thing being, proc_read_super()
> explicitly sets ->s_op to non-NULL. Oh, and that area hadn't changed since
> 2.4.2, so I'd rather suspect the b0rken build. Can you reproduce it?

More specifically, make sure that you are not using the old fs/proc/inode.o.
That looks like the most probable cause - Linus had merged the ->s_maxbytes
patch from -ac and offsets of struct super_block fields had been changed.
Looks like you've either got screwed timestamps or screwed make dep.
								Cheers,
									Al

