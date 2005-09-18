Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbVIRKi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbVIRKi5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 06:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbVIRKi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 06:38:57 -0400
Received: from [81.2.110.250] ([81.2.110.250]:27339 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751063AbVIRKi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 06:38:57 -0400
Subject: Re: p = kmalloc(sizeof(*p), )
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Al Viro <viro@ftp.linux.org.uk>
In-Reply-To: <20050918100627.GA16007@flint.arm.linux.org.uk>
References: <20050918100627.GA16007@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 18 Sep 2005 12:04:34 +0100
Message-Id: <1127041474.8932.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-09-18 at 11:06 +0100, Russell King wrote:
> I completely disagree with the above assertion for the following
> reasons:

Ditto, but you forgot #4. People are always getting sizeof(*p) wrong, in
particular forgetting that p happens to be a void *, or a struct that is
some generic type not the full space for the more complex object
allocated, so using (*p) everywhere just causes more memory scribbles.

If it bugs people add a kmalloc_object macro that is

#define new_object(foo, gfp) (foo *)kmalloc(sizeof(foo), (gfp))

then you can

	x = new_object(struct frob, GFP_KERNEL)

Other good practice in many cases is a single routine which allocates
and initialises the structure and is used by all allocators of that
object. That removes duplicate initialisers, stops people forgetting to
update all cases, allows better debug and far more.
 
Alan

