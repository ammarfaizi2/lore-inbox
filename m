Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbVJAGUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbVJAGUz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 02:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbVJAGUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 02:20:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39908 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750739AbVJAGUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 02:20:54 -0400
Date: Fri, 30 Sep 2005 23:20:43 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: LKML <linux-kernel@vger.kernel.org>, Deepak Saxena <dsaxena@plexity.net>
Subject: Re: Strange commit?
In-Reply-To: <20051001141548.6f26f4e5.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.64.0509302255390.3378@g5.osdl.org>
References: <20051001141548.6f26f4e5.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 1 Oct 2005, Stephen Rothwell wrote:
> 
> The first commit after v2.6.14-rc3 in your git tree seem to refer to the same tree object
> ast the v2.6.14-rc3 commit does.  Is this expected?

Drat. No. It is missing the actual diff ;)

The cause is that the patch was corrupted, but in a way that git-apply 
didn't notice. The diff looked like this:

	diff --git a/arch/arm/mach-ixp2000/core.c b/arch/arm/mach-ixp2000/core.c
	--- a/arch/arm/mach-ixp2000/core.c
	+++ b/arch/arm/mach-ixp2000/core.c
	 static struct resource ixp2000_uart_resource = {
	...

and it's actually missing the line numbers (and an empty line). Which ends 
up meaning that it's interpreted as an empty patch with just garbage 
following, so I ended up committing an empty change.

I've pushed out the real patch.

Thanks for noticing. I'll make "git-apply" flag empty patches as errors.

		Linus
