Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265258AbTIDRHN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 13:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbTIDRHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 13:07:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:9388 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265258AbTIDRHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 13:07:05 -0400
Date: Thu, 4 Sep 2003 10:06:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@redhat.com>
cc: geert@linux-m68k.org, <paulus@samba.org>, <hch@infradead.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix ppc ioremap prototype
In-Reply-To: <20030904094328.59961739.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0309040958420.6676-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Sep 2003, David S. Miller wrote:
> 
> > So clearly ioremap() has to work for other buses too.
> 
> What if they are like I/O ports on x86 and require special
> instructions to access?

ioremap() is very easy to explain to a mathematician: its "domain" is
_exactly_ that which is in the "iomem_resource" tree. The "range" is a
virtual address.

In other words, something like I/O ports, that aren't in the 
iomem_resource, are not covered by ioremap(). It's that simple. 

Another way opf saying it: "iomem_resource" is one special set of
"physical resource mappings". The way you make sure they are accessible is 
"ioremap()".

This is how it has always been on x86, and it is self-consistent.

NOTE! That doesn't preclude having other resource trees, and other ways to
map those. We've never needed to have a "ioportremap()" for the
"ioport_resource" tree, because that resource is so limited that it can be
statically mapped (on x86 it's mapped by hardware, and on other
architectures it is often mapped into the virtual address space like iomem
is).

And some architectures may end up deciding that "iomem_resource" isn't 
sufficient for them, and want to maybe have _multiple_ totally independent 
address trees. Then you'd have to do something else.

		Linus

