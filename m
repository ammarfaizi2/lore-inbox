Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264768AbTE1PaI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 11:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264769AbTE1PaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 11:30:08 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:26535 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S264768AbTE1PaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 11:30:07 -0400
Date: Wed, 28 May 2003 16:45:39 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Inline vm_acct_memory
In-Reply-To: <20030528110552.GF5604@in.ibm.com>
Message-ID: <Pine.LNX.4.44.0305281631030.1240-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 May 2003, Ravikiran G Thirumalai wrote:
> I found that inlining vm_acct_memory speeds up vm_enough_memory.  
> Since vm_acct_memory is only called by vm_enough_memory,

No, linux/mman.h declares

static inline void vm_unacct_memory(long pages)
{
	vm_acct_memory(-pages);
}

and I count 18 callsites for vm_unacct_memory.

I'm no judge of what's worth inlining, but Andrew is widely known
and feared as The Scourge of Inliners, so I'd advise you to hide...

Hugh

