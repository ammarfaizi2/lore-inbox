Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbULNVrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbULNVrG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 16:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbULNVrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 16:47:06 -0500
Received: from almesberger.net ([63.105.73.238]:22290 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261672AbULNVqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 16:46:40 -0500
Date: Tue, 14 Dec 2004 18:46:05 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041214184605.B1271@almesberger.net>
References: <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk> <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com> <16810.24893.747522.656073@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> <20041214025110.A28617@almesberger.net> <Pine.LNX.4.58.0412140734340.3279@ppc970.osdl.org> <20041214135029.A1271@almesberger.net> <Pine.LNX.4.58.0412140950520.3279@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412140950520.3279@ppc970.osdl.org>; from torvalds@osdl.org on Tue, Dec 14, 2004 at 09:58:18AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> iow, using "uint32_t" and friends is _stupid_. The only fathomable 
> argument for doing so would be consistency,

I think consistency is a worthwhile goal in this case. I guess we
can work towards consistency even without using uint32_t in kernel
headers.

This still bears the risk that people will copy __u32 and friends
from headers to then non-portable applications, but I guess that's
something we just have live with.

Since C now finally has standard types with well-defined sizes, I
think there's little reason for applications not to use these types.
So peer pressure should eventually make everyone at least compatible.

A first step towards enabling converence would be to _guarantee_
that glibc types are _identical_ to the kernel types, e.g.

/usr/include/stdint.h:
#include <linux-user/types.h> /* only __u32 and such */

typedef __u32 uint32_t;
...

(If they just "happen to be the same", people may still not trust
this, and will feel justified inventing their own schemes. And as
ugly as uint32_t may look, it's still infinitely better than code
where each library contributes its own set of sized integers ...)

Then, in a few years, when uint32_t and friends are considered
as much a part of the C language as "int", we might be able to
sed s/__u32/uint32_t/g the kernel, and obtain perfect consistency.

Does this sound reasonable ?

> So forget about that stupid abortion called "uint32_t" already. It buys
> you absolutely nothing.

Now, what do we do with them when they are inside the kernel,
far from any interfaces ? Live and let live ? Deprecate them
early on January 1st, when nobody is watching ? :-)

Thanks,
- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
