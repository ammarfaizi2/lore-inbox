Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbULNQxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbULNQxz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 11:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbULNQxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 11:53:55 -0500
Received: from almesberger.net ([63.105.73.238]:24336 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261559AbULNQvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 11:51:14 -0500
Date: Tue, 14 Dec 2004 13:50:29 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041214135029.A1271@almesberger.net>
References: <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk> <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com> <16810.24893.747522.656073@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> <20041214025110.A28617@almesberger.net> <Pine.LNX.4.58.0412140734340.3279@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412140734340.3279@ppc970.osdl.org>; from torvalds@osdl.org on Tue, Dec 14, 2004 at 07:49:05AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> No. Because when you include <sys/ioctl.h> (which includes the 
> <linux-user/foo.h>, the POSIX/SuS/whatever namespace rules say that YOU 
> MUST NOT pollute the namespace with the names from stdint.h.

Hmm, the POSIX 1003.1 2004 edition (which includes SuS) wisely
remains silent on the issue of sys/ioctl.h, but I see what you
mean.

I think some of my confusion arises from the fact that there aren't
many well-known interfaces that use uint32_t and friends to start
with. Instead, they use ssize_t, off_t and such (which admittedly
have similar problems, e.g. in cases where one can't simply get all
of sys/types.h), or private inventions like u_int32_t and such.

Therefore, stdint.h types would mainly be used with new interfaces,
or in intermediate definitions which are not themselves part of the
interface. Of course, the latter would have to consider pollution
issues.

Would you agree that the use of stdint.h types is acceptable for
new interfaces, provided that these come with the warning that
their use may pull in all of stdint.h ?

> And trust me, the rules are really arcane. Not only do you have several 
> standards, and several versions, you have various local rules too, ie gcc 
> and glibc make up their own rules about things that depend on compiler 
> flags etc. 

If this is as unpredictable as you describe it, it would mean
that also new interfaces which need to specify an exact integer
size would require new sets of type names. So horrors like
my_uint32_t, project-specific and of course conflicting
definitions of ULONG (really really meaning 32 bit, at least
sometimes), etc. would still be with us for a long time.

Let me add that I've happily used the standard integer names for
a while, inside and outside of the kernel, so far without ill
effects. Maybe I've just been lucky.

> Remember: the _biggest_ reason to make kernel headers available is not to 
> user programs that want them, but to libc and friends.

Okay, for me it's usually exactly the opposite :-) New tools
that need to share fairly private interfaces with the kernel.

Thanks,
- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
