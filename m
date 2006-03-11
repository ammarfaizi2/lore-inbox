Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWCKJnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWCKJnP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 04:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752346AbWCKJnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 04:43:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19632 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752107AbWCKJnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 04:43:14 -0500
Date: Sat, 11 Mar 2006 01:41:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Leech <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 8/8] [I/OAT] TCP recv offload to I/OAT
Message-Id: <20060311014103.5d04f863.akpm@osdl.org>
In-Reply-To: <20060311022936.3950.86896.stgit@gitlost.site>
References: <20060311022759.3950.58788.stgit@gitlost.site>
	<20060311022936.3950.86896.stgit@gitlost.site>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Leech <christopher.leech@intel.com> wrote:
>
> Locks down user pages and sets up for DMA in tcp_recvmsg, then calls
>  dma_async_try_early_copy in tcp_v4_do_rcv

All those ifdefs are still there.  They really do put a maintenance burden
on, of all places, net/ipv4/tcp.c.  Please find a way of abstracting out
the conceptual additions which IOAT makes to TCP and to wrap that into
inline functions, etc.  See how tidily NF_HOOK() has inserted things into
the net stack.

Also, for something which is billed as an performance enhancement,
benchmark numbers are the key thing which we need to judge the desirability
of these changes.  What is the plan there?

Thanks.
