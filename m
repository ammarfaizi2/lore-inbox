Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbUK2RKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbUK2RKu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 12:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbUK2RKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 12:10:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34019 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261268AbUK2RKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 12:10:38 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <19865.1101395592@redhat.com>
	<20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
	<1101406661.8191.9390.camel@hades.cambridge.redhat.com>
	<20041127032403.GB10536@kroah.com>
	<16810.24893.747522.656073@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 29 Nov 2004 15:09:41 -0200
In-Reply-To: <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
Message-ID: <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 28, 2004, Linus Torvalds <torvalds@osdl.org> wrote:

> On the bigger question of what to do with kernel headers in general, let's 
> just make one thing clear: the kernel headers are for the kernel, and big 
> and painful re-organizations that don't help _existing_ user space are not 
> going to happen.

So, of the following two options, which one you think everybody should
pick?

- Linux gets to define the ABI between kernel and userland, and
  userland must duplicate the contents of headers in which the kernel
  defines the kernel<->userland ABI, tracking changes in them in the
  hope that nothing falls through the cracks

- we move the kernel<->userland to a separate package, where it's
  maintained such that it can be used by both kernel and userland, and
  Linux will only build when given a pointer to the location of this
  package.


I don't think you can have it both ways.  As long as the kernel wants
freedom to set the ABI, either let people use the headers where you
define it, or maintain the ABI separately and let people use them.
Forcing others to maintain duplicates of your headers will just get
most people to use your headers for purposes they weren't meant to be
used; maintaining two similar but far from identical sets of headers
in sync is a major pain, that's why few people do it, and even fewer
people do it properly.

Refusing to help in the effort to maintain them for wishes of freedom
to tinker or allergy to external dependencies haven't worked as
excuses in the past, and I think they never will.  Duplicating the
effort is just stupid, and requiring others to do so is arrogant.  Why
shouldn't we just get together and have something that works for both?

Or how about we turn the table around and define an ABI that the
kernel must implement, and then have the kernel have to keep track of
the changes in such external ABI definition, instead of the way things
(fail to) work now?  How comfortable would you feel with this
arrangement?


My usual reply when I hear this argument that the kernel headers that
define the ABI with userland are to be used by the kernel only, and
someone else is supposed to create the headers for the same purpose to
be used by userland, is that you generally won't find the headers that
expose the interface of a library in a separate package (think
libz.{a,so} and zlib.h).  They're part of the same package, built out
of the same sources, and there's a reason for that: if they get out of
sync, it won't serve its purpose.  It makes far more sense to maintain
them together.

You won't find zlib.h in packages that just want to use zlib, unless
they contain zlib in its entirety, just in case it's not
pre-installed.  I think this makes perfect sense.  Requiring libc or a
separate package used by libc to contain copies of headers that define
the API/ABI exported by the kernel to userland is just the same sort
of nonsense, with the difference that it's a way bigger set of headers
we're talking about, which renders the problem even worse.

Sure you can take the easy way out and claim you told people they
shouldn't do what they're doing when they run into problems because of
including kernel headers from userland.  But as soon as you reject
proposals to clean things up such that we would have a set of headers
that both kernel and userland will be able to use, in a way that would
have the headers still conveniently (for you) sitting in the kernel
source tree, I can't see that you could say it's not your problem with
a straight face any more.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
