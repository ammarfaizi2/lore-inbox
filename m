Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263885AbUDPWMh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263822AbUDPWDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 18:03:05 -0400
Received: from mail.shareable.org ([81.29.64.88]:54946 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263888AbUDPWCY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 18:02:24 -0400
Date: Fri, 16 Apr 2004 23:02:23 +0100
From: Jamie Lokier <jamie@shareable.org>
To: linux-kernel@vger.kernel.org
Subject: msync() needed before munmap() when writing to shared mapping?
Message-ID: <20040416220223.GA27084@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm verifying that writing to a shared mapping and then calling
munmap() or exit() definitely propagates the dirty bits from the page
tables to the file.

This has been asked before, 1 year ago, in a thread called "Memory
mapped files question", and hpa said:

> munmap() and fsync() or msync() will flush it to disk; there is no
> reason munmap() should unless perhaps the file was opened O_SYNC.

That was talking about flushing data all the way to disk.  The
implication of hpa's response is that munmap() does propagate the
dirty bits from the page table to the file.  That is the obvious
behaviour, and what I've always assumed.

I've followed the logic from do_munmap() and it looks good:
unmap_vmas->zap_pte_range->page_remove_rmap->set_page_dirty.

Can someone confirm this is correct, please?

Also, I recall a mention on lkml that some flavour of BSD doesn't
propagate the dirty bits when unmapping, and msync is needed to ensure
data is properly written to the file.  I haven't been able to find the
message, though; perhaps I imagined it.

Can someone confirm or refute that, and similarly does anyone know of
any other OS that needs msync before munmap or exit, to ensure written
data reaches the file?

Thanks,
-- Jamie
