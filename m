Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267306AbUH1GmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267306AbUH1GmY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 02:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268196AbUH1GmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 02:42:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:57826 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267306AbUH1GmX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 02:42:23 -0400
Date: Fri, 27 Aug 2004 23:40:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: oleg@tv-sign.ru, linux-kernel@vger.kernel.org
Subject: Re: [1/4] standardize bit waiting data type
Message-Id: <20040827234033.2b6e1525.akpm@osdl.org>
In-Reply-To: <20040828063419.GA5492@holomorphy.com>
References: <20040826014745.225d7a2c.akpm@osdl.org>
	<20040828052627.GA2793@holomorphy.com>
	<20040828053112.GB2793@holomorphy.com>
	<20040827231713.212245c5.akpm@osdl.org>
	<20040828063419.GA5492@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> William Lee Irwin III <wli@holomorphy.com> wrote:
> >> void fastcall unlock_page(struct page *page)
> >>  {
> >> +	unsigned long *word = (unsigned long *)&page->flags;
> 
> On Fri, Aug 27, 2004 at 11:17:13PM -0700, Andrew Morton wrote:
> > This will break if a little-endian 64-bit architecture elects to use a
> > 32-bit page_flags_t.
> 
> You mean a big-endian one? I did check to be sure none did so; only
> x86-64 does. Easy enough to dress up so BE arches can do it too.
> 

hm.  Actually, the page_flags_t hack can only work on little-endian
hardware anyway.

perhaps your implementation should imitate x86_64/bitops.h and use a void*,
along with apologetic comments.

