Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266695AbUG0XDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266695AbUG0XDD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 19:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266697AbUG0XDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 19:03:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:32207 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266695AbUG0XDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 19:03:01 -0400
Date: Tue, 27 Jul 2004 16:06:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bh_lru_install
Message-Id: <20040727160617.321ce504.akpm@osdl.org>
In-Reply-To: <20040723170338.0c9a38ef.davem@redhat.com>
References: <20040723170338.0c9a38ef.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> wrote:
>
> So I was doing some profiling of memcpy() calls to try and tune
> the UltraSPARC-III memcpy a little more, and you wouldn't believe
> what was at the top of the list during a kernel build :-)
> 
> It's bh_lru_install.  On a 64-bit system every time the local
> cpu's lru->bh[0] doesn't match 'bh' we do a 64-byte memcpy()
> from the stack into the lru->bh[] array.

Well I said it was dopey-but-simple ;)

> It shouldn't be too hard to make the code just work without
> an on-stack copy, shuffling the lru->bh[] array entries
> directly.

Yup, that plus making it a ringbuffer maybe.

But I don't recall seeing bh_lru_install() standing out on profiles.  I
expect that when the system is working hard we're averaging nearly zero
cache misses in that copy.  Do you really think it is worth optimising?
