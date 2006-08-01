Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932577AbWHAHWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbWHAHWr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 03:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbWHAHWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 03:22:47 -0400
Received: from mx1.mail.ru ([194.67.23.121]:38968 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S932554AbWHAHWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 03:22:46 -0400
Date: Tue, 1 Aug 2006 11:30:43 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH]: ufs: ufs_get_locked_patch race fix
Message-ID: <20060801073043.GA17186@rain>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20060731125702.GA5094@rain> <20060731230251.3b149902.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060731230251.3b149902.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 11:02:51PM -0700, Andrew Morton wrote:
> On Mon, 31 Jul 2006 16:57:02 +0400
> Evgeniy Dushistov <dushistov@mail.ru> wrote:
> 
> Looks good to me.
> 
> Is there any need to be checking ->index?  Normally we simply use the
> sequence:
> 
> 	lock_page(page);
> 	if (page->mapping == NULL)
> 		/* truncate got there first */
> 
> to handle this case.

Yes, I made it in analogy with `find_lock_page' and missed fact
that if we increment usage counter of page, we have no need to check
page->index.

Need another patch?

-- 
/Evgeniy

