Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVCYWsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVCYWsA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVCYWpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:45:38 -0500
Received: from mail.dif.dk ([193.138.115.101]:50106 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261845AbVCYWmM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 17:42:12 -0500
Date: Fri, 25 Mar 2005 23:44:09 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-os <linux-os@analogic.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] no need to check for NULL before calling kfree() -
 fs/ext2/
In-Reply-To: <Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com>
Message-ID: <Pine.LNX.4.62.0503252340290.2498@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
 <Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2005, linux-os wrote:

> 
> Isn't it expensive of CPU time to call kfree() even though the
> pointer may have already been freed? I suggest that the check
> for a NULL before the call is much less expensive than calling
> kfree() and doing the check there. The resulting "double check"
> is cheap, compared to the call.
> 
I've been looking at some of the actual code gcc generates for those 
checks, and it's quite bloated. My guess is that the reduced memory 
footprint, one less branch, and the fact that kfree is probably already in 
cache (since it's called often all over the place) outweighs the cost of a 
function call - especially in the cases where the pointer is rarely NULL 
and we'll end up doing the call in any case.
And the reduced use of screen real-estate is nice as well :)

-- 
Jesper juhl


