Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWGKV5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWGKV5F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 17:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWGKV5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 17:57:04 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:17599
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932163AbWGKV5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 17:57:03 -0400
Date: Tue, 11 Jul 2006 14:57:51 -0700 (PDT)
Message-Id: <20060711.145751.77136364.davem@davemloft.net>
To: bos@serpentine.com
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [PATCH] Add memcpy_cachebypass, a copy routine that tries to
 keep cache pressure down
From: David Miller <davem@davemloft.net>
In-Reply-To: <1152653401.16499.35.camel@chalcedony.pathscale.com>
References: <da0cd816c4cb37c4376b.1152651055@localhost.localdomain>
	<20060711.135729.104381402.davem@davemloft.net>
	<1152653401.16499.35.camel@chalcedony.pathscale.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryan O'Sullivan <bos@serpentine.com>
Date: Tue, 11 Jul 2006 14:30:01 -0700

> The last time I tried submitting a patch that followed that style (for
> __iowrite_copy*), it got NAKed for propagating preprocessor abuse (Linus
> roundly flamed someone for a similar patch a few weeks before I
> submitted mine), and Andrew suggested that I use the same scheme that
> this patch uses.
> 
> So whose instructions do I follow?  Yours of today, or Andrew's and
> Linus's of a few months ago?

I didn't realize there was change afoot in this area, sorry.
I was just striving for consistency with current practice.

If Andrew suggested to use weak, that's fine, but it's kind
of erroneous for something like lib/string.c because that
gets built into a library lib.a file, which resolves any
unresolved references.

When the kernel is linked, lib.a implementations only get brought in
if they are not already resolved by definitions present in the other
objects of the kernel image.

Weak makes more sense when dealing with object files, not archives.
