Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbWFVQRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbWFVQRL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 12:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbWFVQRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 12:17:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30878 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030301AbWFVQRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 12:17:10 -0400
Date: Thu, 22 Jun 2006 09:16:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Pekka J Enberg <penberg@cs.Helsinki.FI>, alesan@manoweb.com,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH] cardbus: revert IO window limit
In-Reply-To: <20060622001104.9e42fc54.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606220913420.5498@g5.osdl.org>
References: <Pine.LNX.4.58.0606220947250.15059@sbz-30.cs.Helsinki.FI>
 <20060622001104.9e42fc54.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Jun 2006, Andrew Morton wrote:
> 
> There is something bad happening in there.  Presumably, this patch will
> break the ThinkPad 600x series machines again though.
> 
> It'd be nice if this was related to
> http://bugzilla.kernel.org/show_bug.cgi?id=6725, but I guess not.
> 
> Didn't all this stuff work in 2.4?

No, it's never worked on all machines.

What happens is that the IO window size just changes where things are 
allocated, which breaks things on one machine and fixes it on another. The 
reason tends to be some random hidden IO address that the kernel doesn't 
know about.

So yes, that particular machine may have worked in 2.4.x. Then we fixed 
something, and other machines started working, and that one broke.

I'd rather try to understand why the 256-byte IO window doesn't work on 
that particular machine than try to just randomly change it to hide the 
problem just on that machine again.

		Linus
