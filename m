Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263504AbTLDT37 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 14:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbTLDT37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 14:29:59 -0500
Received: from operator.touchtunes.com ([207.96.182.163]:6385 "EHLO
	mail.touchtunes.com") by vger.kernel.org with ESMTP id S263504AbTLDT3y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 14:29:54 -0500
Message-ID: <3FCF8B87.7060207@touchtunes.com>
Date: Thu, 04 Dec 2003 14:31:19 -0500
From: Tristan Van Berkom <vantr@touchtunes.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How do I share large portions of memory with "user land" ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
	This is one of those "How do I ..." questions
about writing a kernel module/driver.

My question is already well phrased and andswered in an
email archived from a few years ago:
	http://www.ussg.iu.edu/hypermail/linux/kernel/0005.2/0505.html

Andi > The traditional linux way is to implement mmap for
Andi > your character device, vmalloc the memory in kernel
Andi > and supply it to the user process via mmap.

That means (I'm not mistaken) that first you use vmalloc
to allocate a contiguous virtual memory region and suply a
`nopage' method (via mmap) which returns the physical page
coresponding to user's _and_ the module's virtual address
plane; that means that after mucking about with page tables
a while; you have two virtual contiguous memory regions
(one user/one kernel) that both access the same physical
scattered pages. ... ( ?? hmmm ??)

Andi > 2.3 and some patched 2.2 kernels also offer a way to do this
Andi > directly (usion kiovecs and map_user_kiobuf()). This is not in
Andi > standard 2.2 kernel though.

This approach basicly save's me from the `nopage' aspect
of the afore mentioned method; but I dont have a contiguous
memory region in kernel space; only in user land.

Linus > Basically, the way kio buffers work is that
Linus > they are 100% based on only physical pages. There are no virtual
Linus > issues at all in the IO, and that's exactly how I want it. There
Linus > is no reason to confuse virtual addresses into this, because the
Linus > thing should be usable even in the complete absense of virtual
Linus > mappings (ie the kernel can do direct IO purely based on pages -
Linus > think sendfile() etc).

After reading that (above quoted from...):
  (http://www.ussg.iu.edu/hypermail/linux/kernel/0010.2/0338.html)
I can understand why.

So If I have a collection of physical pages in a kio buffer
is there a way to create a contigous virtual memory region out
of that ?

ie: unsigned long kmap_kiovec(int nr, struct kiobuf *iovec[]);

Must it be done by modifying the page tables by hand ?
(If so; is "linux" interrested in such an api as kmap_kiovec
or is it total nonsence ?)

Is there a preferred way to do this
   (mmap -> nopage vs. map_user_kiobuf()) ?

Best regards,
                 -Tristan

