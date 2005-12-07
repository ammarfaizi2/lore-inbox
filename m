Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVLGJre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVLGJre (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 04:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbVLGJrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 04:47:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29929 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750756AbVLGJrd (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 7 Dec 2005 04:47:33 -0500
Date: Wed, 7 Dec 2005 01:46:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: nikita@clusterfs.com, Linux-Kernel@vger.kernel.org
Subject: Re: [PATCH 01/16] mm: delayed page activation
Message-Id: <20051207014659.512619ea.akpm@osdl.org>
In-Reply-To: <20051207014235.GA5186@mail.ustc.edu.cn>
References: <20051203071444.260068000@localhost.localdomain>
	<20051203071609.755741000@localhost.localdomain>
	<17298.56560.78408.693927@gargle.gargle.HOWL>
	<20051204134818.GA4305@mail.ustc.edu.cn>
	<17299.1331.368159.374754@gargle.gargle.HOWL>
	<20051205014842.GA5103@mail.ustc.edu.cn>
	<17301.53377.614777.913013@gargle.gargle.HOWL>
	<20051207014235.GA5186@mail.ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
>
> Andrew, and anyone in the lkml, do you feel ok to test it in -mm tree?

Nope, sorry.  I am wildly uninterested in large changes to page reclaim. 
Or to readahead, come to that.

That code has had years of testing, tweaking, tuning and poking.  Large
changes such as these will take as long as a year to get settled into the
same degree of maturity.  Both of these parts of the kernel are similar in
that they are hit with an extraordinarly broad range of usage patterns and
they both implement various predict-the-future heuristics.  They are subtle
and there is a lot of historical knowledge embedded in there.

What I would encourage you to do is to stop developing and testing new
code.  Instead, devote more time to testing, understanding and debugging
the current code.  If you find and fix a problem and can help us gain a
really really really good understanding of the problem and the fix then
great, we can run with that minimal-sized, minimal-impact, well-understood,
well-tested fix.

See where I'm coming from?  Experience teaches us to be super-cautious
here.  In these code areas especially we cannot afford to go making
larger-than-needed changes because those changes will probably break things
in ways which will take a long time to discover, and longer to re-fix.
