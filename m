Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbVK2GCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbVK2GCt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 01:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVK2GCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 01:02:49 -0500
Received: from holomorphy.com ([66.93.40.71]:2243 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S1751266AbVK2GCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 01:02:48 -0500
Date: Mon, 28 Nov 2005 22:02:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Fix crash when ptrace poking hugepage areas
Message-ID: <20051129060211.GB2240@holomorphy.com>
References: <20051129050628.GB12498@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051129050628.GB12498@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 04:06:28PM +1100, David Gibson wrote:
> Bill, does this look like the correct fix for the problem to you?  If
> so, please apply Andrew.
> set_page_dirty() will not cope with being handed a page * which is
> part of a compound page, but not the master page in that compound
> page.  This case can occur via access_process_vm() if you attempt to
> write to another process's hugepage memory area using ptrace()
> (causing an oops or hang).
> This patch fixes the bug by first resolving the page * to the compound
> page's master page.
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

akpm had already responded, but my general response would have been
"Why on earth would you mark a hugepage dirty?" or similar.


-- wli
