Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265053AbUIMCmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbUIMCmO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 22:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265098AbUIMCmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 22:42:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13733 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265053AbUIMCmK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 22:42:10 -0400
Message-ID: <414508F6.7020301@pobox.com>
Date: Sun, 12 Sep 2004 22:41:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Add sparse "__iomem" infrastructure to check PCI address usage
References: <200409110726.i8B7QTGn009468@hera.kernel.org> <4144E93E.5030404@pobox.com> <Pine.LNX.4.58.0409121922450.13491@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0409121922450.13491@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Sun, 12 Sep 2004, Jeff Garzik wrote:
>>1) what does force do? it doesn't appear to be in gcc 3.3.3 docs.

> It doesn't do anything for gcc. You're looking at the sparse-only code.

doh, and thanks for the info.


>>2) is "volatile ... __force" redundant?

> No, although it's likely to be a strange combination. If you want to force 
> a static address space conversion to a volatile pointer, you can do so. I 
> don't see _why_ you'd want to do it ;)

Well the reason I ask....

static inline void writeb(unsigned char b, volatile void __iomem *addr)
{
         *(volatile unsigned char __force *) addr = b;
}
static inline void writew(unsigned short b, volatile void __iomem *addr)
{
         *(volatile unsigned short __force *) addr = b;
}
static inline void writel(unsigned int b, volatile void __iomem *addr)
{
         *(volatile unsigned int __force *) addr = b;
}


>>3) can we use 'malloc' attribute on kmalloc?

> Since we can't use the gcc alias analysis anyway (it's too broken until
> very late gcc versions), the gcc 'malloc' attribute shouldn't make any
> difference that I can tell.
> 
> But there wouldn't be anything _wrong_ in adding it to kmalloc(), if 
> that's what you're asking.

That's what I'm asking.

Thanks,

	Jeff


