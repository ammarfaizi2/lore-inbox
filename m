Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbVJCMyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbVJCMyq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 08:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbVJCMyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 08:54:46 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:12268 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750824AbVJCMyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 08:54:46 -0400
Date: Mon, 3 Oct 2005 15:54:31 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Jesper Juhl <jesper.juhl@gmail.com>, Ben Dooks <ben-linux@fluff.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] release_resource() check for NULL resource
In-Reply-To: <20051003124950.GD16717@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0510031552450.24263@sbz-30.cs.Helsinki.FI>
References: <20051002170318.GA22074@home.fluff.org> <20051002103922.34dd287d.rdunlap@xenotime.net>
 <20051003094803.GC3500@home.fluff.org> <9a8748490510030259o43646cbbo22b37f1791d267e@mail.gmail.com>
 <20051003100431.GA16717@flint.arm.linux.org.uk>
 <84144f020510030543q10ff4fd2g138de4d06eddc440@mail.gmail.com>
 <20051003124950.GD16717@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2005, Russell King wrote:
> And the above is buggy.  request_region() allocates memory.
> release_resource() unregisters the resource but does _not_
> free the allocated memory.

Indeed but that's besides the point as kfree() deals with NULLs fine.

On Mon, 3 Oct 2005, Russell King wrote:
> On the other hand, release_region() is the counter-part of
> request_region() and should be used to release resources
> created by request_region().

Right. To me, it makes sense for the release counter-part accept NULL if 
the allocation/initialization function can return it.

			Pekka
