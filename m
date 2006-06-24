Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWFXTVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWFXTVr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 15:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWFXTVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 15:21:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:706 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751051AbWFXTVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 15:21:46 -0400
Date: Sat, 24 Jun 2006 12:21:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH] x86: cache pollution aware __copy_from_user_ll()
In-Reply-To: <1151160152.3181.59.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0606241218510.6483@g5.osdl.org>
References: <200606231501.k5NF1B79002899@hera.kernel.org>
 <1151160152.3181.59.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Jun 2006, Arjan van de Ven wrote:
> 
> while this patch will reduce the number of cycles spent in the kernel,
> it's just pushing the cache miss to userspace (by virtue of doing a
> cache flush effectively)... is this really the right thing? The total
> memory bandwidth will actually increase with this patch if you're
> unlucky (eg if userspace decides to write to this memory eventually)....

No. It's for copying _from_ user space, ie a "write()" system call. So 
what it does is to effectively try to use non-temporal stores to the page 
cache - since the page cache is usually not read directly afterwards (at 
least not soon enough for L1 caches to help).

I don't generally like cache tricks either (caches tend to be better than 
humans, or at least get there fairly soon), but this one does seem very 
valid.

		Linus
