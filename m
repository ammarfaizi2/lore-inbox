Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262478AbTDQBy1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 21:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbTDQBy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 21:54:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38408 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262478AbTDQBy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 21:54:26 -0400
Date: Wed, 16 Apr 2003 19:06:27 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BK+PATCH] remove __constant_memcpy
In-Reply-To: <3E9DFC11.50800@pobox.com>
Message-ID: <Pine.LNX.4.44.0304161904170.1534-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Apr 2003, Jeff Garzik wrote:
> 
> gcc's __builtin_memcpy performs the same function (and more) as the 
> kernel's __constant_memcpy.  So, let's remove __constant_memcpy, and let 
> the compiler do it.

Please don't.

There's no way gcc will EVER get the SSE2 cases right. It just cannot do 
it. In fact, I live in fear that we will have to turn off the compiler 
intrisics entirely some day just because there is always the worry that 
gcc will start using FP.

So the advantage of doing our own memcpy() is not that it's necessarily 
faster than the gcc built-in, but simply because I do not believe that the 
gcc people care enough about the kernel to let them make the choice.

		Linus

