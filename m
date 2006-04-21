Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWDUT0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWDUT0T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 15:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWDUT0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 15:26:18 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:14266 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932286AbWDUT0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 15:26:18 -0400
Message-ID: <444931C4.9020502@oracle.com>
Date: Fri, 21 Apr 2006 12:25:56 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: akpm@osdl.org, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shrink rbtree
References: <1145623663.11909.139.camel@pmac.infradead.org>	 <44492343.6040603@oracle.com> <1145646412.11909.218.camel@pmac.infradead.org>
In-Reply-To: <1145646412.11909.218.camel@pmac.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Maybe. I thought I'd actually done it once before, but I couldn't
> actually find it when I went looking.

Yeah, that's what I remember too.

> Plenty more words in the git commit.

Ah!  of course, thanks.

> They don't make much sense without
> the patch right below them, and you can see them in juxtaposition at 
> http://git.infradead.org/?p=users/dwmw2/rbtree-2.6.git;a=commitdiff;h=1975e59375756da4ff4e6e7d12f67485e813ace0

Indeed, that reasoning looks sound.  First the if (parent) .. else {}
falls away, then the parent left/right relationship is folded into the
test with old.  Looks good.

> I think it's be better just to drop the RB_RED and RB_BLACK definitions.

I'd agree, I figured you'd left them for a reason.

>>> +static inline void rb_set_parent(struct rb_node *rb, struct rb_node *p)
>>> +{
>> 	BUG_ON((unsigned long)p & 3);
> 
> Yeah, I suppose we could.

>>> +	node->rb_parent_colour = (unsigned long )parent;
>> use rb_set_parent(node, parent) and get the assertion.
> 
> Que?

I meant that if we add the BUG_ON() to rb_set_parent() then we might as
well reuse it here..

- z
