Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVCFWz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVCFWz0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 17:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVCFWuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 17:50:52 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:22181 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261605AbVCFWtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:49:19 -0500
Date: Sun, 6 Mar 2005 22:49:12 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Adrian Bunk <bunk@stusta.de>, Russell King <rmk@arm.uk.linux.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] mm/swap_state.c: unexport swapper_space
Message-ID: <20050306224912.GE5827@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hugh Dickins <hugh@veritas.com>, Adrian Bunk <bunk@stusta.de>,
	Russell King <rmk@arm.uk.linux.org>, linux-kernel@vger.kernel.org
References: <20050306144758.GJ5070@stusta.de> <Pine.LNX.4.61.0503061515200.19898@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0503061515200.19898@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 03:28:19PM +0000, Hugh Dickins wrote:
> immediately on demand).  It's used by the inline page_mapping() in
> include/linux/mm.h, which _was_ used by various arch cacheflushing
> inlines, which could reasonably be called from modular filesystems.
> 
> I think those architectures hit the missed export when the dependence
> on &swapper_space got added to page_mapping(), the export was soon
> added to mainline, but meanwhile they moved their inlines out-of-line
> - perhaps temporarily, but not yet reverted.
> 
> Better leave it exported so long as page_mapping is using it.

I disagree.  swapper_state is far too much of an internal detail to be
exported.  I argued that way when page_mapping was changed to use it and
that's why the architectures moved their helpers out of line.
Looks like the exported unfortunately got added anyway although we settled
that discussion.

