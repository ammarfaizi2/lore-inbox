Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbWEaJlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWEaJlv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 05:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbWEaJlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 05:41:51 -0400
Received: from cantor.suse.de ([195.135.220.2]:39320 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964913AbWEaJlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 05:41:50 -0400
From: Andi Kleen <ak@suse.de>
To: piet@bluelane.com
Subject: Re: linux-2.6 x86_64 kgdb issue
Date: Wed, 31 May 2006 11:41:43 +0200
User-Agent: KMail/1.9.3
Cc: "Amit S. Kale" <amitkale@linsyssoft.com>,
       "Vladimir A. Barinov" <vbarinov@ru.mvista.com>,
       Andrew Morton <akpm@osdl.org>, kgdb-bugreport@lists.sourceforge.net,
       trini@kernel.crashing.org, linux-kernel@vger.kernel.org
References: <446E0B4B.9070003@ru.mvista.com> <200605310913.54758.ak@suse.de> <1149064749.26542.191.camel@piet2.bluelane.com>
In-Reply-To: <1149064749.26542.191.camel@piet2.bluelane.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605311141.43340.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> My bet is that in this case I was storing a LOT of 
> data in the thread structure, so the space left for 
> the stack was massively reduced. 

Ok so it was your bug. Don't do that.

> Sure but the debugger environment must tolerate larger stacks.

No, Linux doesn't tolerate larger stacks.

> But this can miss a minor abuse. The interrupt check
> is a quick and simple hack but I wonder if it's really
> optimal for commercial implementations.

In practice if you overwrite thread_info you crash eventually
and it's noticed.  If you write below thread_info but keep
ti intact then the redzone would likely not catch it either.

I don't think an additional red zone would improve overflow detection 
in a significant way.

> I think all modules should be ABLE to be built in.

If you have a working module it can be easily built in too.
Just hacks that don't work with modules are bad.

-Andi
