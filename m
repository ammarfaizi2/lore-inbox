Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264133AbTDOETX (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 00:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264138AbTDOETW (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 00:19:22 -0400
Received: from [12.47.58.203] ([12.47.58.203]:20529 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264133AbTDOETW (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 00:19:22 -0400
Date: Mon, 14 Apr 2003 21:31:14 -0700
From: Andrew Morton <akpm@digeo.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.67-mm3
Message-Id: <20030414213114.37dc7879.akpm@digeo.com>
In-Reply-To: <20030415041759.GA12487@holomorphy.com>
References: <20030414015313.4f6333ad.akpm@digeo.com>
	<20030415020057.GC706@holomorphy.com>
	<20030415041759.GA12487@holomorphy.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Apr 2003 04:31:05.0734 (UTC) FILETIME=[D4434A60:01C30307]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> +	for (; addr < (unsigned long)uaddr + size && !ret; addr += PAGE_SIZE)
> +		ret = __put_user(0, (char *)max(addr, (unsigned long)uaddr));

This hurts my brain.  If anything, it should be formulated as a do-while loop.

But I'm not sure we should really bother, because relatively large amounts of
stuff is broken for PAGE_SIZE != PAGE_CACHE_SIZE anyway.  tmpfs comes to
mind...

If page clustering needs to redo this code (and I assume it does) then that
would be an argument in favour.

