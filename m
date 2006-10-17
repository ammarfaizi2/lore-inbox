Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWJQBvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWJQBvJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 21:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWJQBvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 21:51:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55777 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932139AbWJQBvG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 21:51:06 -0400
Date: Mon, 16 Oct 2006 18:50:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC] typechecking for get_unaligned/put_unaligned
In-Reply-To: <20061017005025.GF29920@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0610161847210.3962@g5.osdl.org>
References: <20061017005025.GF29920@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Oct 2006, Al Viro wrote:
>
> 	What kind of typechecking do we want for those?
> 
> AFAICS, current constraints are
> 	* {put,get}_unaligned() should be passed a pointer to object; void *
> is not acceptable
> 	* sizeof(*ptr) should be one of 1, 2, 4, 8
> 	* assignment of val to *ptr should be valid C.

Have we ever really had any problems with this?

I think that as far as typing, we should just make sure that 
[get|put]_unaligned() has the same behaviour as a dereference. Sure, 
checking the size might be worth it, but it doesn't sound like we'd 
actually find any real bugs (ie wrong sizes should just result in compile 
or link errors on architectures where you need special code for it).

> 	c) how about gradually switching to linux/unaligned.h?

I'd prefer not to, if only because it's an unnecessary compile-time 
overhead for nice sane architectures like x86, which don't need any of the 
unaligned crap.

Since x86[-64] is clearly the main architecture, dis-optimizing for that 
one sounds like a bad idea.

		Linus
