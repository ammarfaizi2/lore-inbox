Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290768AbSAYSKV>; Fri, 25 Jan 2002 13:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290761AbSAYSKL>; Fri, 25 Jan 2002 13:10:11 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36879 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290760AbSAYSKA>; Fri, 25 Jan 2002 13:10:00 -0500
Date: Fri, 25 Jan 2002 10:08:56 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: John Levon <movement@marcelothewonderpenguin.com>
cc: Andi Kleen <ak@suse.de>, <linux-kernel@vger.kernel.org>, <davej@suse.de>
Subject: Re: [PATCH] Fix 2.5.3pre reiserfs BUG() at boot time
In-Reply-To: <20020125180149.GB45738@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.4.33.0201251006220.1632-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 25 Jan 2002, John Levon wrote:
>
> please apply this too then.

I would prefer instead just avoiding the copy altogether, and just save
the name pointer - with no length restrictions.

Right now the code has the comment

   /* Copy name over so we don't have problems with unloaded modules */

but that was written before "kmem_cache_destroy()" existed, and we should
long ago have fixed any modules that don't properly destroy their caches
when they exit (and yes, I know the difference between "should" and "did",
but that's not an excuse for a bad interface).

		Linus

