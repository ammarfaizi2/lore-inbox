Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135401AbRDZX1P>; Thu, 26 Apr 2001 19:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135471AbRDZX1F>; Thu, 26 Apr 2001 19:27:05 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:64915 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135401AbRDZX0q>;
	Thu, 26 Apr 2001 19:26:46 -0400
Date: Thu, 26 Apr 2001 19:25:23 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <20010426230751.J819@athlon.random>
Message-ID: <Pine.GSO.4.21.0104261924080.15385-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Apr 2001, Andrea Arcangeli wrote:

> > How about adding
> > 	if (!buffer_uptodate(bh)) {
> > 		printk(KERN_ERR "IO error or racy use of wait_on_buffer()");
> > 		show_task(current);
> > 	}
> > in the end of wait_on_buffer() for a while?
> 
> At the _top_ of wait_on_buffer would be better then at the end.

In that case ll_rw_block() + wait_on_buffer() (absolutely legitimate
combination) will scream at you.

