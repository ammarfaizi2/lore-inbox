Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUC2Wew (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 17:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbUC2Wew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 17:34:52 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:5587 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263166AbUC2Wd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 17:33:58 -0500
Date: Mon, 29 Mar 2004 23:34:01 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: John Stoffel <stoffel@lucent.com>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-rc2-mm1 - swapoff dies with OOM, why?
In-Reply-To: <16488.40157.474575.545711@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.44.0403292326400.20046-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2004, John Stoffel wrote:
> 
> But in this case, there was no way to force the turning off of swap,
> since the ext3 bug in 2.6.5-rc2-mm1 had filled the cache, and wasn't
> going away.  Is this right?  

Well, it was a memory leak, filling more and more resident memory,
leaving less and less for other uses.  I didn't investigate, but
I'm guessing not cache.

> I wonder if there's a way to tell swap to 'go away when you can, don't
> allow more swap (kill new requests), and generally work on pushing
> stuff back to memory, or other swap partitions.'

User space thing really: you could add an option to swapoff(8) to loop
retrying (well, I think it would need to fork off a child to do the
sys_swapoff, fork another when that one gets OOM-killed; a bit messy,
I agree).

Hugh

