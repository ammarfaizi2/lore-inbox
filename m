Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWDVUKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWDVUKK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 16:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWDVUKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 16:10:10 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:43208 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751148AbWDVUJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 16:09:47 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Shrink rbtree
Date: Sat, 22 Apr 2006 14:29:26 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, andrea@suse.de,
       linux-kernel@vger.kernel.org
References: <1145623663.11909.139.camel@pmac.infradead.org> <20060421180915.1f2d61a4.akpm@osdl.org> <1145669384.16166.130.camel@shinybook.infradead.org>
In-Reply-To: <1145669384.16166.130.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604221429.27858.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Saturday, 22. April 2006 03:29, David Woodhouse wrote:
> On Fri, 2006-04-21 at 18:09 -0700, Andrew Morton wrote:
> > #define HRTIMER_INACTIVE        ((void *)1UL) 
> 
> Ah. That's newer than the kernel I tested on. Your patch isn't going to
> make kernel/hrtimer.c compile though, surely? Let's do it the same way
> everyone else marks off-tree nodes -- by setting its parent pointer to
> point to itself....

Yes, but please make it a common helper, since there is a real need
for it and code has to agree on the dirty hacks it uses :-)

static inline int rb_in_tree(const struct rb_node *node)
{
	return rb_parent(node) != node;
}

static inline void rb_set_off_tree(struct rb_node *node)
{
	rb_set_parent(node, node);
}


This is trivial, but gives semantics to those strange operations.


Regards

Ingo Oeser
