Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbUK3PwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbUK3PwT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 10:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbUK3PwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 10:52:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:52352 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262118AbUK3PwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 10:52:08 -0500
Date: Tue, 30 Nov 2004 07:51:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Alexandre Oliva <aoliva@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, David Woodhouse <dwmw2@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__ 
In-Reply-To: <8219.1101828816@redhat.com>
Message-ID: <Pine.LNX.4.58.0411300744120.22796@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org> 
 <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
 <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com>
 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br>  <8219.1101828816@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Nov 2004, David Howells wrote:
> 
> > But in general, I do kind of like the explicit marking. The same way we 
> > explicitly mark the functions inside the kernel that we expose to modules, 
> > we could try to mark the data structures and values that we expose to user 
> > space. That tends to "work".
> 
> That gets trickier when it comes to #defines, I think.
> 
> Do you really object that much to splitting the header files as I proposed?

I object sternuously to your "the header files". If you can't even say 
_which_ header file, I'm not interested.

If you can say "these X header files have this specific problem Y, and if 
we move part Z into a common area A, we'd solve it because B", that's a 
different matter.

See what I'm saying? Whole-sale "move things around because we want to" 
I'm not interested in. Specific problems, yes.

> Personally, I'd prefer us to move to using standard C99 types in lieu of u32
> and co at least for the interface to userspace because they are just that:
> standard.

No. I told you why it cannot and MUST NOT be done. Repeat after me:

	WE MUST NOT POLLUTE THE NAMESPACE!

There are many cases where including a header file means you want the
structure, but it does _not_ mean that you can expose totally unrelated 
types, even if those types happen to be used as part of the structure. See 
what I'm saying?

In contrast, __u8/__u16/__xxx are explicitly defined by the relevant 
standards to be "system name space", and that is _exactly_ why we don't 
use the standard namespaces.

And the fact is, the rules for _when_ you export _which_ standard types
are just too damn hard, and more importantly, they are not something that
the kernel headers should even be deciding. They depend on glibc internal
things like __USE_BSD etc, and they depend on which standard you compile
for, and sometimes even on which _version_ of the standard you compile
for.

I will not have that mess in the kernel. Which means that we do _not_ 
export any of the standard names. Which means that we can't _use_ any of 
them. End of story.

		Linus
