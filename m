Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264571AbUGIXhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264571AbUGIXhz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 19:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264850AbUGIXhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 19:37:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:64472 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264571AbUGIXhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 19:37:51 -0400
Date: Fri, 9 Jul 2004 16:40:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm7
Message-Id: <20040709164056.01803862.akpm@osdl.org>
In-Reply-To: <1089411888.1799.146.camel@mulgrave>
References: <20040708235025.5f8436b7.akpm@osdl.org>
	<20040709210423.GB21066@holomorphy.com>
	<20040709151448.28f1dbf7.akpm@osdl.org>
	<1089411888.1799.146.camel@mulgrave>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
> On Fri, 2004-07-09 at 17:14, Andrew Morton wrote:
> > btw, James, I'm unable to convince myself that
> > dma_mark_declared_memory_occupied() reserves enough pages if device_addr is
> > not page-aligned.  Could you double-check that?  If all callers are
> > expected to use a page-aligned address then a BUG_ON might be appropriate. 
> > Or a comment.
> 
> Oh, you mean when addr isn't page aligned and size causes it just to
> span a page, like addr = 0xfff, size=2?

yup.

> You're right, it doesn't.  How about the attached

seems to work OK.


#define PAGE_SIZE 4096
#define PAGE_MASK ~4095
#define PAGE_SHIFT 12

main()
{
	int addr, size;

	for (addr = 1; addr < 8192; addr += 1024) {
		for (size = -1; size < 8192; size += 1024) {
			int pages;

			pages = (size + (addr & ~PAGE_MASK) + PAGE_SIZE - 1) >> PAGE_SHIFT;
			printf("addr:%06x size:%06x pages:%d\n",
				addr, size, pages);
		}
	}
}

