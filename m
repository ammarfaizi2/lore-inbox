Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264486AbTDPRcn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 13:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264491AbTDPRcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 13:32:43 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:49313 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264486AbTDPRcK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 13:32:10 -0400
Date: Wed, 16 Apr 2003 12:43:54 -0500
From: linas@austin.ibm.com
To: linux-kernel@vger.kernel.org
Subject: 2.4: crash when unmounting ext2fs
Message-ID: <20030416124353.A33082@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
                                                                                
I've been chasing a bug in a slightly down-level version of the
kernel (2.4.19) and was wondering if perchance its been fixed
recently ... The crash occurs after a large ext2 filesystem
was heavily used (in a large-memory config), and is then unmounted.
Using KDB, I find myself chasing pointers in discard_bh_page()
(in fs/buffer.c) and one of the bh->b_this_page points at a page
that's clearly been zero'ed, but for one tell-tale clue.  It looks
like the zero'ed out page used to be chained correctly into the
lru_list[], and then it was zero'ed out, and then someone called
__remove_from_lru_list() on its neighbor.
                                                                                
I'm a little stumped on how a bh was on the lru_list, got whacked,
and is still in the list of page->buffers that discard_bh_page() is
trying to get rid of.  Anyone fix anything like this recently?

Or more generally, any sort of buffer-freeing/page-freeing/file-system
flushing/freeing type bugs where pages might have been zero'ed out
before thier time? 

--linas
