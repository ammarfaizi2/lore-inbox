Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264337AbTLPDqv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 22:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264339AbTLPDqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 22:46:51 -0500
Received: from gandalf.tausq.org ([64.81.244.94]:30625 "EHLO pippin.tausq.org")
	by vger.kernel.org with ESMTP id S264337AbTLPDqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 22:46:49 -0500
Date: Mon, 15 Dec 2003 20:40:33 -0800
From: Randolph Chung <randolph@tausq.org>
To: linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org
Subject: Question about cache flushing and fork
Message-ID: <20031216044033.GT533@tausq.org>
Reply-To: Randolph Chung <randolph@tausq.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG: for GPG key, see http://www.tausq.org/gpg.txt
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can someone please explain why it is necessary to flush the cache 
during fork()? (i.e. call to flush_cache_mm() in dup_mmap)

It seems that after fork, the parent and child have access to the same
vm, so it should be sufficient to flush the tlb, and create two pte's
for the processes. I can see that during COW processing there can be
kernel/user cache aliasing issues on virtually indexed caches, but
that seems to be taken care of by copy_cow_page(). 

I've read through cachetlb.txt, but it just says:

        This interface is used to handle whole address space
        page table operations such as what happens during
        fork, exit, and exec.

I can see why this is needed for exit(), but why fork()? and i don't see
this used for exec() ?

Also is there an updated version of the "Linux Cache Flush Architecture"
document? (http://en.tldp.org/LDP/khg/HyperNews/get/memory/flush.html)
This is a very nicely written doc, but it seems a bit out of date for
2.6 (e.g. flush_page_to_ram is gone)

thanks
randolph
-- 
Randolph Chung
Debian GNU/Linux Developer, hppa/ia64 ports
http://www.tausq.org/
