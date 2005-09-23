Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbVIWGyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVIWGyT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 02:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbVIWGyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 02:54:19 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:8133
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750713AbVIWGyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 02:54:19 -0400
Date: Thu, 22 Sep 2005 23:54:13 -0700 (PDT)
Message-Id: <20050922.235413.116392977.davem@davemloft.net>
To: nickpiggin@yahoo.com.au
Cc: linux-kernel@vger.kernel.org, clameter@engr.sgi.com
Subject: Re: making kmalloc BUG() might not be a good idea
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <4333A109.2000908@yahoo.com.au>
References: <20050922.231434.07643075.davem@davemloft.net>
	<4333A109.2000908@yahoo.com.au>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Fri, 23 Sep 2005 16:30:33 +1000

> David S. Miller wrote:
> 
> >I'm sort-of concerned about this change:
> >
> >    [PATCH] __kmalloc: Generate BUG if size requested is too large.
> >
> >it opens a can of worms, and stuff that used to generate
> >-ENOMEM kinds of failures will now BUG() the kernel.
> >
> >Unless you're going to audit every user triggerable
> >path for proper size limiting, I think we should revert
> >this change.
> 
> Making it WARN might be a good compromise.

It's a better, but it's still turning a harmless -ENOMEM
into a DoS log file filler for the cases where a size limit
check is missing and is user triggerable.

Another idea is to put it under CONFIG_DEBUG or something.
