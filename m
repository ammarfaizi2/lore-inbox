Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161147AbWBQHDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161147AbWBQHDP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 02:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161150AbWBQHDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 02:03:14 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:27297
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161147AbWBQHDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 02:03:13 -0500
Date: Thu, 16 Feb 2006 23:03:18 -0800 (PST)
Message-Id: <20060216.230318.21310500.davem@davemloft.net>
To: akpm@osdl.org
Cc: kyle@parisc-linux.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Generic is_compat_task helper
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060216214939.78aebcbb.akpm@osdl.org>
References: <20060217025242.GM13492@quicksilver.road.mcmartin.ca>
	<20060216214939.78aebcbb.akpm@osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Thu, 16 Feb 2006 21:49:39 -0800

> Kyle McMartin <kyle@parisc-linux.org> wrote:
> >
> > +static inline int __is_compat_task(struct task_struct *t)
> > +{
> > +	return (personality(t->personality) == PER_LINUX32);
> > +}
> > +
> 
> What continues to bug me about this (in a high-level hand-wavy sort of way)
> is that this is an attribute of the mm_struct, not of the task_struct.

It's an attribute of the "system call being invoked right now".
So you can emulate ia32 apps on ia64 or x86_64 by just trapping
to the 32-bit system calls directly, and stuff like that.
