Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264097AbUEHT1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbUEHT1o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 15:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264102AbUEHT1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 15:27:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:65252 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264097AbUEHT1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 15:27:43 -0400
Date: Sat, 8 May 2004 12:27:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: manfred@colorfullife.com, davej@redhat.com, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
Message-Id: <20040508122708.676e124a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org>
References: <20040506200027.GC26679@redhat.com>
	<20040506150944.126bb409.akpm@osdl.org>
	<409B1511.6010500@colorfullife.com>
	<20040508012357.3559fb6e.akpm@osdl.org>
	<20040508022304.17779635.akpm@osdl.org>
	<20040508031159.782d6a46.akpm@osdl.org>
	<Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org>
	<20040508120148.1be96d66.akpm@osdl.org>
	<Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> On Sat, 8 May 2004, Andrew Morton wrote:
>  > 
>  > I think we can simply take ->d_lock a bit earlier in __d_lookup.  That will
>  > serialise against d_move(), fixing the problem which you mention, and also
>  > makes d_movecount go away.
> 
>  If you do that, RCU basically loses most of it's meaning.
> 
>  You'll be taking a lock for - and dirtying in the cache - every single
>  dentry on the hash chain, which is pretty much guaranteed to be slower
>  than just taking the dcache_lock _once_, even if that one jumps across 
>  CPU's a lot.

Can take the lock after comparing the hash and the parent?

And if we recheck those after locking, d_movecount is unneeded?
