Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262815AbUK0CTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbUK0CTl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263121AbUK0CKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 21:10:37 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262815AbUKZTh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:37:29 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: David Woodhouse <dwmw2@infradead.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, hch@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
In-Reply-To: <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
References: <19865.1101395592@redhat.com>
	 <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1101406661.8191.9390.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Thu, 25 Nov 2004 18:17:42 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-25 at 16:54 +0000, Matthew Wilcox wrote:
> >      Note that this doesn't take account of the other directories under
> >      include/, but I don't think they're relevant.
> 
> I think they may be.  If they are, they can be accommodated.  For example:
> 
> 	include/user-scsi/	include/scsi/
> 	include/user-net/	include/net/
> 	include/user-rxrpc/	include/rxrpc/
> 
> etcetera.  This only creates a conflict if someone creates a directory
> foo that also clashes with asm-foo.  And if someone does propose that,
> we just kill them.  Easy.

Agreed.

> >      (d) stdint types should be used where possible.
> > 
> > 		[include/user-i386/termios.h]
> > 		struct winsize {
> > 			uint16_t ws_row;
> > 			uint16_t ws_col;
> > 			uint16_t ws_xpixel;
> > 			uint16_t ws_ypixel;
> > 		};
> 
> I really hate stdint.  Can't we use __u16 instead?

We're trying to clean all this crap up. I think we'd need a better
justification than 'I hate stdint' to use anything other than the
standard types which the language provides.

You'll get over it, I promise. I hated stdint too for a whole week or so
after I admitted it made sense to switch JFFS2 to it, because I actually
wanted it to be usable other than in the Linux kernel.

> This proposal doesn't address the asm-generic problem directly.  Can I
> presume that you intend to also create linux/include/user-generic, install
> it as /usr/include/user-generic and create an asm-generic symlink that
> points to user-generic?  A good problem file to be dealt with would
> be asm/errno.h

That makes sense.

> ppc might want to consider following the lead of parisc, s390 and mips
> and unify at least their header files, if not their arch directory.

That makes a certain amount of sense, although ppc64 currently lacks the
mess of platform-specific stuff that ppc32 has for various embedded
platforms. I suspect it would take a fair amount of work to produce a
single directory which everyone's happy with.

-- 
dwmw2

