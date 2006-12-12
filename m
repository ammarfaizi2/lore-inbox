Return-Path: <linux-kernel-owner+w=401wt.eu-S1750868AbWLLBuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWLLBuw (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 20:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWLLBuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 20:50:52 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:47904
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750868AbWLLBuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 20:50:51 -0500
Date: Mon, 11 Dec 2006 17:50:50 -0800 (PST)
Message-Id: <20061211.175050.55478586.davem@davemloft.net>
To: zaitcev@redhat.com
Cc: matthltc@us.ibm.com, erikj@sgi.com, guillaume.thouvenin@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] connector: Some fixes for ia64 unaligned access errors
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061211172907.305473cf.zaitcev@redhat.com>
References: <20061209183409.67b54d01.zaitcev@redhat.com>
	<1165881167.24721.73.camel@localhost.localdomain>
	<20061211172907.305473cf.zaitcev@redhat.com>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pete Zaitcev <zaitcev@redhat.com>
Date: Mon, 11 Dec 2006 17:29:07 -0800

> On Mon, 11 Dec 2006 15:52:47 -0800, Matt Helsley <matthltc@us.ibm.com> wrote:
> 
> > 	I'm shocked memcpy() introduces 8-byte stores that violate architecture
> > alignment rules. Is there any chance this a bug in ia64's memcpy()
> > implementation? I've tried to read it but since I'm not familiar with
> > ia64 asm I can't make out significant parts of it in
> > arch/ia64/lib/memcpy.S.
> 
> The arch/ia64/lib/memcpy.S is probably fine, it must be gcc doing
> an inline substitution of a well-known function.
> 
> A commenter on my blog mentioned seeing the same thing in the past.
> (http://zaitcev.livejournal.com/107185.html?thread=128945#t128945)
> 
> It's possible that applying (void *) cast to the first argument of memcpy
> would disrupt this optimization. But since we have a well understood
> patch by Erik, which only adds a penalty of 32 bytes of stack waste
> and 32 bytes of memcpy, I thought it best not to bother with heaping
> workarounds.

Yes GCC can assume the object is aligned because of the type
of the argument to memcpy().

I tried myself some games with adding a "packed" attribute to the
pointer declaration (trying to tell it that "the thing pointed to"
might be unaligned), but to no avail.
