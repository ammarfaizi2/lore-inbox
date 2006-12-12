Return-Path: <linux-kernel-owner+w=401wt.eu-S1751047AbWLLDJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWLLDJV (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 22:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbWLLDJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 22:09:20 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:54502 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbWLLDJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 22:09:20 -0500
Subject: Re: [PATCH] connector: Some fixes for ia64 unaligned access errors
From: Matt Helsley <matthltc@us.ibm.com>
To: David Miller <davem@davemloft.net>
Cc: zaitcev@redhat.com, erikj@sgi.com, guillaume.thouvenin@bull.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061211.175050.55478586.davem@davemloft.net>
References: <20061209183409.67b54d01.zaitcev@redhat.com>
	 <1165881167.24721.73.camel@localhost.localdomain>
	 <20061211172907.305473cf.zaitcev@redhat.com>
	 <20061211.175050.55478586.davem@davemloft.net>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Mon, 11 Dec 2006 19:09:16 -0800
Message-Id: <1165892956.24721.129.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-11 at 17:50 -0800, David Miller wrote:
> From: Pete Zaitcev <zaitcev@redhat.com>
> Date: Mon, 11 Dec 2006 17:29:07 -0800
> 
> > On Mon, 11 Dec 2006 15:52:47 -0800, Matt Helsley <matthltc@us.ibm.com> wrote:
> >
> > > 	I'm shocked memcpy() introduces 8-byte stores that violate architecture
> > > alignment rules. Is there any chance this a bug in ia64's memcpy()
> > > implementation? I've tried to read it but since I'm not familiar with
> > > ia64 asm I can't make out significant parts of it in
> > > arch/ia64/lib/memcpy.S.
> >
> > The arch/ia64/lib/memcpy.S is probably fine, it must be gcc doing
> > an inline substitution of a well-known function.
> >
> > A commenter on my blog mentioned seeing the same thing in the past.
> > (http://zaitcev.livejournal.com/107185.html?thread=128945#t128945)
> >
> > It's possible that applying (void *) cast to the first argument of memcpy
> > would disrupt this optimization. But since we have a well understood
> > patch by Erik, which only adds a penalty of 32 bytes of stack waste
> > and 32 bytes of memcpy, I thought it best not to bother with heaping
> > workarounds.
> 
> Yes GCC can assume the object is aligned because of the type
> of the argument to memcpy().

Hmm, that GCC assumption conflicts with the prototypes of memcpy() I've
seen.

	Does the code really check the type or just the size argument? If the
latter then I don't think assuming alignment is correct -- we could be
copying a non-nul-terminated string that happens to be a power of 2 in
length.

Cheers,
	-Matt Helsley

