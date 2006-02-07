Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWBGABq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWBGABq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWBGABq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:01:46 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:59603
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932421AbWBGABp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:01:45 -0500
Date: Mon, 06 Feb 2006 16:01:40 -0800 (PST)
Message-Id: <20060206.160140.59716704.davem@davemloft.net>
To: sfr@canb.auug.org.au
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org, ak@suse.de
Subject: Re: [PATCH] compat: add compat functions for *at syscalls
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060207105631.39a1080c.sfr@canb.auug.org.au>
References: <20060207105631.39a1080c.sfr@canb.auug.org.au>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 7 Feb 2006 10:56:31 +1100

> This adds compat version of all the remaining *at syscalls
> so that the "dfd" arguments can be properly sign extended.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

I do the sign extension with tiny stubs in arch/sparc64/kernel/sys32.S
so that the arg frobbing does not consume a stack frame, which is what
happens if you do this in C code.

We need to revisit this at some point and make a way for all
compat platforms to do this with a portable table of some kind
that expands a bunch of macros defined by the platform.
