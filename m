Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWFSH2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWFSH2u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 03:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWFSH2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 03:28:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23062 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932204AbWFSH2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 03:28:50 -0400
Date: Mon, 19 Jun 2006 09:29:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <npiggin@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [patch] rfc: fix splice mapping race?
Message-ID: <20060619072921.GA4466@suse.de>
References: <20060618094157.GD14452@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060618094157.GD14452@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18 2006, Nick Piggin wrote:
> Hi, I would be interested in confirmation/comments for this patch.
> 
> I believe splice is unsafe to access the page mapping obtained
> when the page was unlocked: the page could subsequently be truncated
> and the mapping reclaimed (see set_page_dirty_lock comments).
> 
> Modify the remove_mapping precondition to ensure the caller has
> locked the page and obtained the correct mapping. Modify callers to
> ensure the mapping is the correct one.
> 
> In page migration, detect the missing mapping early and bail out if
> that is the case: the page is not going to get un-truncated, so
> retrying is just a waste of time.

splice bit looks good to me!

-- 
Jens Axboe

