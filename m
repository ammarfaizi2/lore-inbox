Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264378AbTIIUfp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264418AbTIIUfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:35:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:10924 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264460AbTIIUeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:34:09 -0400
Date: Tue, 9 Sep 2003 13:33:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: davidm@hpl.hp.com
cc: Jes Sorensen <jes@wildopensource.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: Re: [Patch] asm workarounds in generic header files
In-Reply-To: <16222.14136.21774.211178@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0309091329570.30594-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Sep 2003, David Mosberger wrote:
> 
> In my opinion, moving all the asm-stuff greatly improved readability
> of the source code.  Especially for folks who are not intimately
> familiar with GCC asm syntax (which is hairy _and_ platform-specific).

I might agree, but "compiler.h" is getting increasingly messy, and this 
just makes it worse (and sets the stage for making it even worse in the 
future).

Is somebody willing to split up compiler.h into a per-compiler file (and 
yes, I think "gcc-2.95" is a different compiler from "gcc-3.2" in this 
case, since that is what most of the compiler.h #ifdef's are all about).

Then, have a config-time "set the right symbolic link" the same way we do 
for "include/asm/", so that we can have a set of _clean_ 
compiler-dependent abstractions.

At that point, we can look at adding support for non-gcc compilers without
horrible problems. At least as long as the compiler otherwise is
"sufficiently good" (which clearly right now includes support for inline
assembly on most architectures).

		Linus

