Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbVLHSru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVLHSru (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 13:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbVLHSru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 13:47:50 -0500
Received: from [194.90.237.34] ([194.90.237.34]:63018 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S932241AbVLHSrt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 13:47:49 -0500
Date: Thu, 8 Dec 2005 21:09:14 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Hugh Dickins <hugh@veritas.com>
Cc: Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: set_page_dirty vs set_page_dirty_lock
Message-ID: <20051208190913.GA28482@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
The comment at set_page_dirty_lock says:

/*
 * set_page_dirty() is racy if the caller has no reference against
 * page->mapping->host, and if the page is unlocked.  This is because another
 * CPU could truncate the page off the mapping and then free the mapping.
 *
 * Usually, the page _is_ locked, or the caller is a user-space process which
 * holds a reference on the inode by having an open file.
 *
 * In other cases, the page should be locked before running set_page_dirty().
 */

Still, I wander whether it might be OK to use set_page_dirty
in another case - if I previously got a reference to the page
with get_user_pages?
The page wouldnt be written back in this case, would it?
What if I'm in the middle of a system call?

Thanks,

-- 
MST
