Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbUB0WVv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 17:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263164AbUB0WVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 17:21:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:44948 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263134AbUB0WVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 17:21:47 -0500
Date: Fri, 27 Feb 2004 14:23:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: andrea@suse.de, riel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
 end)
Message-Id: <20040227142330.4e72d9f4.akpm@osdl.org>
In-Reply-To: <162060000.1077919387@flay>
References: <20040227173250.GC8834@dualathlon.random>
	<Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com>
	<20040227122936.4c1be1fd.akpm@osdl.org>
	<20040227211548.GI8834@dualathlon.random>
	<162060000.1077919387@flay>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> > We can write a testcase ourself, it's pretty easy, just create a 2.7G
> > file in /dev/shm, and mmap(MAP_SHARED) it from 1k processes and fault in
> > all the pagetables from all tasks touching the shm vma. Then run a
> > second copy until the machine starts swapping and see how thing goes. To
> > do this you need probably 8G, this is why I didn't write the testcase
> > myself yet ;).  maybe I can simulate with less shm and less tasks on 1G
> > boxes too, but the extreme lru effects of point 3 won't be visibile
> > there, the very same software configuration works fine on 1/2G boxes on
> > stock 2.4. problems showsup when the lru grows due the algorithm not
> > contemplating million of dirty swapcache in a row at the end of the lru
> > and some gigs of free cache ad the head of the lru. the rmap-only issues
> > can also be tested with math, no testcase is needed for that.
> 
> I don't have time at the moment to go write it at the moment, but I can certainly run it on large end hardware if that helps.

I think just

	usemem -m 2700 -f test-file -r 10 -n 1000

will do it.  I need to verify that.

http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz
