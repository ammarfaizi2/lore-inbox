Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136161AbRECHhi>; Thu, 3 May 2001 03:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136168AbRECHh3>; Thu, 3 May 2001 03:37:29 -0400
Received: from geos.coastside.net ([207.213.212.4]:42125 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S136161AbRECHhC>; Thu, 3 May 2001 03:37:02 -0400
Mime-Version: 1.0
Message-Id: <p05100305b716b4571bc0@[207.213.214.37]>
In-Reply-To: <Pine.LNX.4.05.10105030852330.9438-100000@callisto.of.borg>
In-Reply-To: <Pine.LNX.4.05.10105030852330.9438-100000@callisto.of.borg>
Date: Thu, 3 May 2001 00:33:02 -0700
To: Geert Uytterhoeven <geert@linux-m68k.org>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: unsigned long ioremap()?
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 8:55 AM +0200 2001-05-03, Geert Uytterhoeven wrote:
>Since you're not allowed to use direct memory dereferencing on ioremapped
>areas, wouldn't it be more logical to let ioremap() return an unsigned long
>instead of a void *?
>
>Of course we then have to change readb() and friends to take a long as well,
>but at least we'd get compiler warnings when someone tries to do a direct
>dereference.

Better yet, seems to me, its own type. Say: typedef unsigned long io_ref_t;

It's already done for dma_addr_t, and this seems like an analogous case.

The bigger job would be to fix all the direct dereferences (a 
worthwhile thing, I guess; a quick scan shows at least a few), as 
well as to fix uncast assignments of ioremap(). Or ideally to get rid 
of the casts (most that I see are casts to unsigned long) and type 
the receiving buffer appropriately.

It'd be a big job. And Linus further suggests that ioremap's first 
argument is an architecture-specific object, not necessarily either a 
physical CPU address or a PCI address (though it's typically both in 
many (most?) i386 implementations). Now *there'd* be a cleanup.
-- 
/Jonathan Lundell.
