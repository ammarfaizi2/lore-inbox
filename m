Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbUKCKoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbUKCKoM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 05:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261544AbUKCKoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 05:44:11 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:30983 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261524AbUKCKmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 05:42:18 -0500
Date: Wed, 3 Nov 2004 10:42:07 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org, akpm@osdl.org,
       davidm@snapgear.com, linux-kernel@vger.kernel.org,
       uclinux-dev@uclinux.org
Subject: Re: [PATCH 8/14] FRV: GP-REL data support
Message-ID: <20041103104207.GC18416@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, torvalds@osdl.org,
	akpm@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org,
	uclinux-dev@uclinux.org
References: <20041102094827.GD5841@infradead.org> <76b4a884-2c3c-11d9-91a1-0002b3163499@redhat.com> <200411011930.iA1JUL1K023209@warthog.cambridge.redhat.com> <25976.1099413241@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25976.1099413241@redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 04:34:01PM +0000, David Howells wrote:
> 
> > > +#ifdef CONFIG_FRV
> > > +#define __jiffy_data  __attribute__((section(".data")))
> > > +#else
> > > +#define __jiffy_data
> > > +#endif
> > 
> > please avoid per-arch ifdefs in common code, this needs to go into some asm/
> > header, or and __ARCH_HAVE_FOO ifdef.
> 
> You're advocating using an ifdef? I thought you hated the things...

You have an ifdef already.  Using the right symbol at least avoids this
into turning to

#if define(foo) || defined(bar) || (defined(baz) && !defined(foobar))

> I want to avoid changing every other arch.
> 
> > Anyway, would doing this unconditionally cause any problems?
> 
> Not as far as I know.

So go for that.

> > > +#ifndef __ASSEMBLY__
> > > +extern const char linux_banner[];
> > > +#endif
> > 
> > totally wrong place.  this is not about linkage at all.
> 
> Actually, it's almost entirely about linkage:-) But in this case, you may be
> right.

So how is the linux banner about linkage?

> Anyone any suggestions as to the right place for this? linux/kernel.h
> perhaps?

Maybe.
