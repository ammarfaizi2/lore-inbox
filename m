Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbUKSQ5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbUKSQ5A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 11:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbUKSQ5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 11:57:00 -0500
Received: from waste.org ([209.173.204.2]:33234 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261471AbUKSQ4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 11:56:53 -0500
Date: Fri, 19 Nov 2004 08:56:16 -0800
From: Matt Mackall <mpm@selenic.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, davidm@snapgear.com,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH 17/20] FRV: Better mmap support in uClinux
Message-ID: <20041119165616.GX2460@waste.org>
References: <20041119052936.GE8040@waste.org> <20040401020550.GG3150@beast> <200411081434.iA8EYKn7023613@warthog.cambridge.redhat.com> <13104.1100881603@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13104.1100881603@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 04:26:43PM +0000, David Howells wrote:
> 
> > >  (3) Files (and blockdevs) cannot be mapped shared since it is not
> > >  really possible to honour this by writing any changes back to the
> > >  backing device.
> > 
> > [way behind on email]
> > 
> > I think this could be done at msync, munmap and exit time? You end up
> > flushing the entire mapping, but it's still correct (and POSIX
> > compliant).
> 
> Don't forget write() too. If someone does a write, that would have to be
> written over the mapping too. Obviously this is not impossible.

I don't see such a requirement, but it'd be nice, yes.
 
> > And, if you wanted to be really clever, you could store a hash of each
> > page to detect changes and avoid the extra I/O.
> 
> It'd probably have to be something like an md5 sum.

Arguably, it needn't be cryptographically strong. But that's another
discussion.

> Okay, technically, we could probably emulate it, but is it worth it? I think
> it's something to bear in mind for another time.

Well I wasn't volunteering, just pointing out it's not as hard as
claimed. Thankfully all the boxes I currently have to care about are
not so special.

-- 
Mathematics is the supreme nostalgia of our time.
