Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbUEWBJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUEWBJN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 21:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUEWBJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 21:09:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:65501 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262060AbUEWBJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 21:09:09 -0400
Date: Sat, 22 May 2004 18:08:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm5
Message-Id: <20040522180837.3d3cc8a9.akpm@osdl.org>
In-Reply-To: <m165aorm70.fsf@ebiederm.dsl.xmission.com>
References: <20040522013636.61efef73.akpm@osdl.org>
	<m165aorm70.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm5/
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm5/
> > 
> > 
> > add-i386-readq.patch
> >   add i386 readq()/writeq()
> 
> > static inline u64 readq(void *addr)
> > {
> > 	return readl(addr) | (((u64)readl(addr + 4)) << 32);
> > }
> > 
> > static inline void writeq(u64 v, void *addr)
> > {
> > 	u32 v32;
> > 
> > 	v32 = v;
> > 	writel(v32, addr);
> > 	v32 = v >> 32;
> > 	writel(v32, addr + 4);
> > }
> > 
> > #endif
> 
> The implementation is broken and it will break drivers that actually
> expect writeq and readq to be 64bit reads and writes.

I don't think we can expect all architectures to be able to implement
atomic 64-bit IO's, can we?

ergo, drivers which want to use readq and writeq should provide the
appropriate locking.

> I attempted to suggest some alternative implementations earlier
> in the original thread that brought this up but it looks like
> you missed that.

I saw some stuff float past, but I don't recall seeing anything which would
work on all architectures?
