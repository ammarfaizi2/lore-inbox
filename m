Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWBMHF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWBMHF5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 02:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWBMHF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 02:05:57 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:6797
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751178AbWBMHF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 02:05:56 -0500
Date: Sun, 12 Feb 2006 23:05:16 -0800 (PST)
Message-Id: <20060212.230516.86740481.davem@davemloft.net>
To: akpm@osdl.org
Cc: hugh@veritas.com, wli@holomorphy.com, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] compound page: use page[1].lru
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060212181312.11392d12.akpm@osdl.org>
References: <20060212135457.2a3d3b37.akpm@osdl.org>
	<Pine.LNX.4.61.0602130043480.17715@goblin.wat.veritas.com>
	<20060212181312.11392d12.akpm@osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Sun, 12 Feb 2006 18:13:12 -0800

> We have a page which has no ->mapping, but lo, it's mmapped by userspace
> and can be MAP_SHARED between different CPUs and processes.
> 
> Yes, I suspect it'll do the wrong thing in unpleasantly subtle ways.
> 
> (cc's davem and runs away).

The ->mapping check is there essentially to hit user mapped pages that
would be modified by the kernel using kernel space memory accesses
other than those done by copy_user_page() and clear_user_page() (and
their brothers copy_user_highpage() and clear_user_highpage() which
just call the former directly on a non-HIGHPAGE platform like
sparc64).

Hugepages actually have no D-cache aliasing issues by definition on
sparc64 because the smallest possible hugepage size is 64K which is
larger than the D-cache aliasing factor (which is 16K).
