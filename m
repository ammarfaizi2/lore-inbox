Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263815AbUFBS7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263815AbUFBS7r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 14:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUFBS7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 14:59:47 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:61852 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263815AbUFBS7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 14:59:43 -0400
Date: Wed, 2 Jun 2004 20:58:32 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] explicitly mark recursion count
Message-ID: <20040602185832.GA2874@wohnheim.fh-wedel.de>
References: <200406011929.i51JTjGO006174@eeyore.valparaiso.cl> <Pine.LNX.4.58.0406011255070.14095@ppc970.osdl.org> <20040602131623.GA23017@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020712180.3403@ppc970.osdl.org> <Pine.LNX.4.58.0406020724040.22204@bigblue.dev.mdolabs.com> <20040602182019.GC30427@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406021124310.22742@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0406021124310.22742@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 June 2004 11:37:50 -0700, Davide Libenzi wrote:
> 
> You're requesting to add and maintain data to feed a tool that catches 
> only trivially visible recursion. I don't want to waste mine and your time 
> explaining why your tool will never work, but if you want an hint, you can 
> start thinking about all functions that sets/pass callbacks and/or sets 
> operational functions. I don't know if you noticed that, but Linux is 
> heavily function-pointer driven. Eg, one function setups a set of function 
> pointers, and another 317 indirectly calls them. Having such comments, not 
> only makes the maintainance heavier, but gives the false sense of safeness 
> that once you drop that data in, you're protected against recursion.

Yeah, I know about the problems to generate a complete call graph.
With function pointers, it is plain impossible to get it right in the
most general case.

Note the "in the most general case" part.  You can get things right if
you make some assumptions and those assumptions are actually valid.
In my case the assumptions are:
1. all relevant function pointers are stuffed into some struct and
2. no casts are used to disguise function pointer as something else.

If you stick with those rules, the resulting code is quite sane, which
is much more important than any tools being usable.  If the kernel
doesn't stick to those rules for a good reason, I'd like to know about
it, so I can adjust my tool.  And if the kernel doesn't stick to those
rules for no good reason, the code if broken and needs to be fixed.

Is this sane?

Jörn

-- 
A victorious army first wins and then seeks battle.
-- Sun Tzu
