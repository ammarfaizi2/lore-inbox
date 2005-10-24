Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbVJXB5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbVJXB5Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 21:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbVJXB5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 21:57:24 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:33290 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S1750914AbVJXB5Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 21:57:24 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH] Fix and add EXPORT_SYMBOL(filemap_write_and_wait)
References: <87ek6dtvxz.fsf@devron.myhome.or.jp>
	<20051023141057.59e458f3.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 24 Oct 2005 10:57:04 +0900
In-Reply-To: <20051023141057.59e458f3.akpm@osdl.org> (Andrew Morton's message of "Sun, 23 Oct 2005 14:10:57 -0700")
Message-ID: <87r7aboexb.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> If filemap_fdatawrite() returns an error, this might be due to some I/O
> problem: dead disk, unplugged cable, etc.  Given the generally crappy
> quality of the kernel's handling of such exceptions, there's a good chance
> that the filemap_fdatawait() will get stuck in D state forever.
>
> I don't know how useful that really is - probably not very.  Plus, yes, we
> should wait on writeout after a -ENOSPC.
>
> So hum, not sure.  My gut feeling is that anything which we can do to help
> the kernel limp along after an I/O error is a good thing, hence the
> don't-wait-after-EIO feature should remain.

I see, thanks for explaining it. Please don't apply patch, I need to
consider it obviously.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
