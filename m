Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbULOAS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbULOAS5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 19:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbULOASV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:18:21 -0500
Received: from inx.pm.waw.pl ([195.116.170.20]:47036 "EHLO inx.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261727AbULNXuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 18:50:13 -0500
To: Werner Almesberger <wa@almesberger.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, David Woodhouse <dwmw2@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <19865.1101395592@redhat.com>
	<20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
	<1101406661.8191.9390.camel@hades.cambridge.redhat.com>
	<20041127032403.GB10536@kroah.com>
	<16810.24893.747522.656073@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
	<20041214025110.A28617@almesberger.net>
	<Pine.LNX.4.58.0412140734340.3279@ppc970.osdl.org>
	<20041214135029.A1271@almesberger.net>
	<Pine.LNX.4.58.0412140950520.3279@ppc970.osdl.org>
	<20041214184605.B1271@almesberger.net>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 15 Dec 2004 00:49:33 +0100
In-Reply-To: <20041214184605.B1271@almesberger.net> (Werner Almesberger's
 message of "Tue, 14 Dec 2004 18:46:05 -0300")
Message-ID: <m3fz28tp82.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <wa@almesberger.net> writes:

> A first step towards enabling converence would be to _guarantee_
> that glibc types are _identical_ to the kernel types, e.g.
>
> /usr/include/stdint.h:
> #include <linux-user/types.h> /* only __u32 and such */
>
> typedef __u32 uint32_t;
> ...
>
> (If they just "happen to be the same", people may still not trust
> this, and will feel justified inventing their own schemes. And as
> ugly as uint32_t may look, it's still infinitely better than code
> where each library contributes its own set of sized integers ...)

Not sure about this. I think such types should be defined by the
kernel, for it's use only. The libc (and any other userspace
software) may probably use them (if they have to), but must not
(re)define them.
The userspace should probably best use standard types. This is
userspace to know if their uint32_t has standard meaning equivalent
to __u32 or if it's actually a function name.


So i think we should have:

kernel-include/headers.h:
#define __u32 ...

struct some_structure {
       __u32 var;
}str1;


and then userspace.c (libc et al) should:

#include linux/headers.h

str1 v;
uint32_t variable = v.var;

or maybe with some type conversion:

long long v2 = v.var;
unsigned char v3 = v.var;
-- 
Krzysztof Halasa
