Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265155AbUANIti (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 03:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265164AbUANIti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 03:49:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:48533 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265155AbUANItf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 03:49:35 -0500
Date: Wed, 14 Jan 2004 00:49:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: jh@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix compilation on gcc 3.4
Message-Id: <20040114004944.5ba6b4a5.akpm@osdl.org>
In-Reply-To: <20040114083700.GA1820@averell>
References: <20040114083700.GA1820@averell>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> 
> The upcomming gcc 3.4 has a new inlining algorithm which sometimes
> fails to inline some "dumb" inlines in the kernel. This sometimes leads
> to undefined symbols while linking.

That's a compiler bug, surely.

> To make the kernel compile again this patch drops the always inline
> for gcc 3.4.  The new algorithm should be good enough to do the right
> thing on its own. 

Are you sure?  Without the always_inline stuff we were seeing 100 different
copies of __constant_c_and_count_memset and friends in the vmlinux symbol
table.  It was really silly.

After applying this patch and building with gcc-3.4, how does `size
vmlinux' compare with the same kernel built with gcc-3.3, minus the patch?

