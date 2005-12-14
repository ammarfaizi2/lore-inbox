Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965092AbVLNXf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbVLNXf5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 18:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965093AbVLNXf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 18:35:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33509 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965092AbVLNXf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 18:35:56 -0500
Date: Wed, 14 Dec 2005 15:32:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [2.6 patch] offer CC_OPTIMIZE_FOR_SIZE only if EXPERIMENTAL
In-Reply-To: <20051214224406.GI23349@stusta.de>
Message-ID: <Pine.LNX.4.64.0512141528140.3292@g5.osdl.org>
References: <20051214191006.GC23349@stusta.de> <20051214140531.7614152d.akpm@osdl.org>
 <20051214221304.GE23349@stusta.de> <Pine.LNX.4.64.0512141429030.3292@g5.osdl.org>
 <20051214224406.GI23349@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 Dec 2005, Adrian Bunk wrote:
> 
> My patch has the advantage that it doesn't allow the broken 
> CC_OPTIMIZE_FOR_SIZE=y setting on ARM if !EXPERIMENTAL.

That isn't how it was before either. 

Before, it _asked_ you if EMBEDDED was set, and "y" was just the default 
(but you could select "n" if you wanted to). I don't think it's 
necessarily wrong to allow a -O2 ARM or H8300 kernel, although apparently 
there are compilers that are broken that way too..

So my patch should give the old behaviour for the EMBEDDED platforms, and 
_allow_ it for non-embedded unless SPARC64 is set, or EXPERIMENTAL isn't 
set.

That sounds like the right thing to do to me..

Of course, the really right thing would be to chase down what goes wrong 
with -Os. It might be a compiler bug, but it might be a real kernel bug 
that just happens to bite us (-Os works fine for me on ppc64, and 
apparently Fedora has used it at least on x86-64, but it might be 
something subtle).

		Linus
