Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbVJ3VXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbVJ3VXV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 16:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbVJ3VXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 16:23:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7086 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932127AbVJ3VXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 16:23:20 -0500
Date: Sun, 30 Oct 2005 11:36:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: Andrew Morton <akpm@osdl.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add be*/le* types without underscores
In-Reply-To: <20051030064842.GA5933@gondor.apana.org.au>
Message-ID: <Pine.LNX.4.64.0510301134440.27915@g5.osdl.org>
References: <20051030064842.GA5933@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 30 Oct 2005, Herbert Xu wrote:
> 
> Of course userspace won't see them since they're protected by
> #ifdef __KERNEL__.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

This won't work, I think.

sparse basically always creates a _new_type_ for a bitwise typedef, so 
when you do

	typedef u16 __bitwise le16;
	typedef u16 __bitwise be16;
	...

your new "le16" will be _different_ from the old __le16, and you can't use 
it with "cpu_to_le16()" and other things.

I think that

	typedef __le16 le16;

should do what you want, but you should check.

		Linus
