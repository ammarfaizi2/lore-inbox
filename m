Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266669AbUFWU5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266669AbUFWU5S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 16:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266667AbUFWU5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 16:57:17 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:43234 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266670AbUFWU4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 16:56:48 -0400
Subject: Re: Atomic operation for physically moving a page (for memory
	defragmentation)
From: Dave Hansen <haveblue@us.ibm.com>
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: ashwin_s_rao@yahoo.com, Valdis.Kletnieks@vt.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <20040623.205906.71913783.taka@valinux.co.jp>
References: <20040619031536.61508.qmail@web10902.mail.yahoo.com>
	 <1087619137.4921.93.camel@nighthawk>
	 <20040623.205906.71913783.taka@valinux.co.jp>
Content-Type: text/plain
Message-Id: <1088024190.28102.24.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 23 Jun 2004 13:56:30 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-23 at 04:59, Hirokazu Takahashi wrote:
> We should know that many part of kernel code will access the page
> without holding a lock_page(). The lock_page() can't block them.

No, but it will block them from establishing a new PTE to the page.  You
need to:

1. make sure no new PTEs can be established to the page
2. make sure there are no valid PTEs to the page.
3. do the move

My suggestion relates to 1, only.

-- Dave

