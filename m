Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWDVTtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWDVTtw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWDVTtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:49:52 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:20675 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751084AbWDVTtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:49:51 -0400
Subject: Re: [PATCH] Shrink rbtree
From: David Woodhouse <dwmw2@infradead.org>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Andrew Morton <akpm@osdl.org>, andrea@suse.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <200604221429.27858.ioe-lkml@rameria.de>
References: <1145623663.11909.139.camel@pmac.infradead.org>
	 <20060421180915.1f2d61a4.akpm@osdl.org>
	 <1145669384.16166.130.camel@shinybook.infradead.org>
	 <200604221429.27858.ioe-lkml@rameria.de>
Content-Type: text/plain
Date: Sat, 22 Apr 2006 14:38:59 +0100
Message-Id: <1145713139.11909.262.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-22 at 14:29 +0200, Ingo Oeser wrote:
> Yes, but please make it a common helper, since there is a real need
> for it and code has to agree on the dirty hacks it uses :-)

Is there a real need for it? It's all just paranoid debugging checks,
isn't it? If there's a _real_ need for marking an object as being
inactive because it can be reached through some means other than the
rbtree, then that arguably lives in the higher-level object itself, not
its rb_node.

I'm reluctant to 'bless' this practice, because we'll then get asked to
set it to 'inactive' every time we take a node off the tree, to have a
BUG_ON() which checks it in certain places, etc.... it's mostly
pointless AFAICT.

-- 
dwmw2

