Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbTDQXrp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 19:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbTDQXrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 19:47:45 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21265 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262731AbTDQXrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 19:47:43 -0400
Date: Thu, 17 Apr 2003 16:59:55 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Arjan van de Ven <arjanv@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BK+PATCH] remove __constant_memcpy
In-Reply-To: <3E9F3D6F.9030501@pobox.com>
Message-ID: <Pine.LNX.4.44.0304171654530.14595-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 17 Apr 2003, Jeff Garzik wrote:
> 
> If DTRT means just using the existing code for large copies in general, 
> that's easy enough...  patch attached.

Yeah, this looks more palatable. It gets rid of a rather ugly thing, with
no loss in generality _and_ if gcc ever tries to use sse2 for small
copies, we can file that as a valid bug (there's just no way it's a good
idea considering the costs of FP state even in user space)

> 1) where did the 486 string ops go?

They were disabled forever, because nobody cared enough, and they had 
known (or at least strongly suspected) bugs.

> 2) why no sse2-optimized memcpy?  just that noone has done one yet?

Yes. If you want to, it's definitely the right thing to do. More so than 
the 3dnow stuff that is by now ancient. HOWEVER, I don't think there are 
any really valid large memcpy() calls inside the kernel. All the valid 
ones are either special-cased (ie "copy_page()") or to user space.

So I wouldn't worry about it at a memcpy() level. 

		Linus

