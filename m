Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265689AbTABF4Y>; Thu, 2 Jan 2003 00:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265700AbTABF4Y>; Thu, 2 Jan 2003 00:56:24 -0500
Received: from rth.ninka.net ([216.101.162.244]:48281 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S265689AbTABF4X>;
	Thu, 2 Jan 2003 00:56:23 -0500
Subject: Re: [PATCH] TCP Zero Copy for mmapped files
From: "David S. Miller" <davem@redhat.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Thomas Ogrisegg <tom@rhadamanthys.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20021230012937.GC5156@work.bitmover.com>
References: <20021230010953.GA17731@window.dhis.org> 
	<20021230012937.GC5156@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Jan 2003 22:37:01 -0800
Message-Id: <1041489421.3703.6.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-29 at 17:29, Larry McVoy wrote:
> How about putting this into a different function?  It's a lot to add
> inline for a special case.

This patch also has a ton of other problems:

1) Does not handle writes that straddle multiple VMAs
2) We do not want to encourage people to use this mmap
   scheme anyways.  The mmap way consumes precious VM
   space, whereas the sendfile scheme does not.
3) Finally, I'm very dubious about the "this is faster than
   TUX claim".  Firstly because you've not provided your
   self-made HTTP server so that others can try to reproduce
   your benchmark.  And secondly because you haven't indicated
   if your self-made HTTP server is as full featured as TUX or
   not.  And thirdly you haven't indicated what happens if in
   parallel clients ask to be served more files than you could
   mmap fit into the HTTP server processes address space (ie. see
   #2)

So I think this patch stinks :)

