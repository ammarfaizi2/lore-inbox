Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267916AbUIJVjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267916AbUIJVjE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 17:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267920AbUIJVjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 17:39:04 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:35309 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267916AbUIJVjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 17:39:01 -0400
Message-ID: <41421EF0.6020106@nortelnetworks.com>
Date: Fri, 10 Sep 2004 15:38:56 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: having problems with remap_page_range() and virt_to_phys()
References: <Pine.LNX.4.44.0409101501530.16728-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0409101501530.16728-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

> And no, remembering your earlier pleas, the MM system doesn't clean
> up for you, you'll need to ClearPageReserved and free the page when
> it's all done with (if ever).


Cleanup will be at process death, so I'm adding a routine to be called from 
do_exit().

As part of that cleanup, do I need to call do_munmap() on the user virtual 
address first, or can I just do

	ClearPageReserved(pg);
	__free_pages(pg,0);

and then rely on the mm takedown to properly unmap and drop its references?

Basically I'm not sure if I can clear the reservation and free the page while 
it's still mapped in the task's memory map.

Chris
