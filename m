Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbULNTYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbULNTYv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 14:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbULNTYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 14:24:51 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:11986 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261620AbULNTYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 14:24:41 -0500
Message-Id: <200412141923.iBEJNCY9011317@laptop11.inf.utfsm.cl>
To: Werner Almesberger <wa@almesberger.net>
cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, David Woodhouse <dwmw2@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__ 
In-Reply-To: Message from Werner Almesberger <wa@almesberger.net> 
   of "Tue, 14 Dec 2004 13:50:29 -0300." <20041214135029.A1271@almesberger.net> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Tue, 14 Dec 2004 16:23:12 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <wa@almesberger.net> said:
> Linus Torvalds wrote:
> > No. Because when you include <sys/ioctl.h> (which includes the 
> > <linux-user/foo.h>, the POSIX/SuS/whatever namespace rules say that YOU 
> > MUST NOT pollute the namespace with the names from stdint.h.

[...]

> Therefore, stdint.h types would mainly be used with new interfaces,
> or in intermediate definitions which are not themselves part of the
> interface. Of course, the latter would have to consider pollution
> issues.

They _can't_ show up in interfaces unless you specify that stdint.h has to
be included before them... and I'd awise against any needless interface
fattening. Besides, using them in the kernel would then mean pulling in
stdint.h there... and you get the same mess, the other way around ("What
userspace headers are OK to pull in when compiling the kernel?"). Better
don't.

[...]

> > And trust me, the rules are really arcane. Not only do you have several 
> > standards, and several versions, you have various local rules too, ie gcc 
> > and glibc make up their own rules about things that depend on compiler 
> > flags etc. 

> If this is as unpredictable as you describe it, it would mean that also
> new interfaces which need to specify an exact integer size would require
> new sets of type names.

That's what all the _u8 and such are. Note that any name starting with _ or
__ is explicitly reserved by the standard (i.e., users should never use
them), so they are (relatively) safe.

>                         So horrors like my_uint32_t, project-specific and
> of course conflicting definitions of ULONG (really really meaning 32 bit,
> at least sometimes), etc. would still be with us for a long time.

Better use stdint.h where possible.

> Let me add that I've happily used the standard integer names for
> a while, inside and outside of the kernel, so far without ill
> effects. Maybe I've just been lucky.

No. You just haven't commited horrors like the ones Linus showed. No
halfway sane C programmer would, but they are quite legal (and must work).

> > Remember: the _biggest_ reason to make kernel headers available is not to 
> > user programs that want them, but to libc and friends.

> Okay, for me it's usually exactly the opposite :-) New tools
> that need to share fairly private interfaces with the kernel.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
