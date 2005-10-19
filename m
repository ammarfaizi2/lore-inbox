Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbVJSHtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVJSHtG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 03:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVJSHtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 03:49:05 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:49684
	"EHLO x30.random") by vger.kernel.org with ESMTP id S1750718AbVJSHtE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 03:49:04 -0400
Date: Wed, 19 Oct 2005 09:47:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: [PATCH] fix nr_unused accounting, and avoid recursing in iput with I_WILL_FREE set
Message-ID: <20051019074757.GA30541@x30.random>
References: <20051018082609.GC15717@x30.random> <20051018171335.3b308b3e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051018171335.3b308b3e.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 05:13:35PM -0700, Andrew Morton wrote:
> Well according to my assertion (below), the inode in __sync_single_inode()
> cannot have a zero refcount, so the whole if() statement is never executed.

It can, but only if it comes from I_WILL_FREE path
(generic_forget_inode).  See the write_inode_now in
generic_forget_inode.

My BUG_ON already makes sure that when i_count is zero, I_WILL_FREE is
set (I_WILL_FREE will prevent the inode to be freed by the vm as well,
so it's ok).
