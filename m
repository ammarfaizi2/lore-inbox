Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbUKSRme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbUKSRme (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 12:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbUKSRme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 12:42:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:181 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261507AbUKSRm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 12:42:27 -0500
Date: Fri, 19 Nov 2004 09:42:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Matt Mackall <mpm@selenic.com>, akpm@osdl.org, davidm@snapgear.com,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH 17/20] FRV: Better mmap support in uClinux 
In-Reply-To: <13783.1100883978@redhat.com>
Message-ID: <Pine.LNX.4.58.0411190936450.2222@ppc970.osdl.org>
References: <20041119165616.GX2460@waste.org>  <20041119052936.GE8040@waste.org>
 <20040401020550.GG3150@beast> <200411081434.iA8EYKn7023613@warthog.cambridge.redhat.com>
 <13104.1100881603@redhat.com>  <13783.1100883978@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Nov 2004, David Howells wrote:
> 
> > > Don't forget write() too. If someone does a write, that would have to be
> > > written over the mapping too. Obviously this is not impossible.
> > 
> > I don't see such a requirement, but it'd be nice, yes.
> 
> I think it is a requirement. With normal Linux, if you do a write that crosses
> a shared mmap it will change the mmapped data.

Indeed. 

Some other UNIXes are broken in this regard, and there are cache coherency 
issues on some platforms that people who depend on this behaviour may need 
to be aware of, but in general Linux has always gone for coherenct mmap's.

POSIX doesn't require it, but quite frankly, non-coherent shared mmap just 
isn't worth it. You might as well not support it at all at that point.

[ I think at least HP-UX used to be broken in this regard, but HP-UX had
  such atrocious mmap behaviour _anyway_ that I don't understand how
  anybody could use it (you couldn't munmap partial mappings etc). I think
  they finally fixed it a few years ago and updated their source base from
  some totally ancient BSD to something a bit more modern. ]

			Linus
