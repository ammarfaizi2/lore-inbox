Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVAMBFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVAMBFz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 20:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVAMBDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 20:03:31 -0500
Received: from mproxy.gmail.com ([216.239.56.243]:65127 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261344AbVAMA7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 19:59:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=i3LWWCFxhMapAx3ea6LvE6TVRlJG/HtjrmfIp2BP+Zl8VBtqcd93+OY2LuKNS73BymATPLbUIeP1VTA4sT9Mz+ayJHwdg6PbupzOygceKY4hSwJu4y6fZQ2sEg+0QlVN/Cc7C+OuI4v3C5YCeGcsjSxh6XqPlqZNa7I9b3EWWJY=
Message-ID: <21d7e997050112165935b89a27@mail.gmail.com>
Date: Thu, 13 Jan 2005 11:59:42 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] kill symbol_get & friends
Cc: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, adaplas@pol.net,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dwmw2@redhat.com
In-Reply-To: <1105575573.12794.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050112203136.GA3150@lst.de>
	 <1105575573.12794.27.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Sorry, Christoph, I must be particularly obtuse today.
> 
> If you don't hold a reference, then yes, the module can go away.  This
> hasn't been a huge problem for users in the past.
> 
> The lack of users is because, firstly, dynamic dependencies are less
> common than static ones, and secondly because the remaining inter-module
> users (AGP and mtd) have not been converted.  Patches have been sent
> several times, but maintainers are distracted, it seems.  I *will* run
> out of patience and push those patches which take away intermodule.c one
> day (hint, hint!).

well the DRM doesn't use the AGP anymore so it should be safe to nuke
(does i810 framebuffer use it??), Christoph didn't like converting the
DRM to use module_get so I just went straight to the agp backend..
it's not perfect but it'll work in nearly all situations..

> 
> For optional module dependencies, weak symbols can be used, but there
> seems to be a desire for genuine dynamic dependencies.  If you can get
> rid of those, I'll apply your patch in a second!

what weak symbol support? can I actually use gcc weak symbols and have
it all work?
what happens if the module goes away? 

Dave.
