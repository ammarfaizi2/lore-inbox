Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbULNSJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbULNSJW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 13:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbULNSIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 13:08:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:12178 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261595AbULNR6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 12:58:33 -0500
Date: Tue, 14 Dec 2004 09:58:18 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Werner Almesberger <wa@almesberger.net>
cc: Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <20041214135029.A1271@almesberger.net>
Message-ID: <Pine.LNX.4.58.0412140950520.3279@ppc970.osdl.org>
References: <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
 <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com>
 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> <20041214025110.A28617@almesberger.net>
 <Pine.LNX.4.58.0412140734340.3279@ppc970.osdl.org> <20041214135029.A1271@almesberger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Dec 2004, Werner Almesberger wrote:
> 
> Would you agree that the use of stdint.h types is acceptable for
> new interfaces, provided that these come with the warning that
> their use may pull in all of stdint.h ?

Not really. 

Two reasons:
 - The fact is, things are interdependent. And this thing is all about 
   _avoiding_ implicit dependencies, and rules like "if you include _this_ 
   particular header file, then you must include yyy.h first, or you can't 
   do zzzz".
 - uint32_t and friends aren't all that nice anyway. Quite frankly, there 
   is nada, zilch, _zero_, reason to use them over the __u8/__u16/__u32.
   In contrast, the __u8/__u16/__u32 types have obvious advantages, 
   ranging from the _lack_ of namespace collission issue to just plain 
   consistency.

iow, using "uint32_t" and friends is _stupid_. The only fathomable 
argument for doing so would be consistency, but since BY DEFINITION we 
cannot be consistent if we use them (since we cannot and must not use them 
anywhere), that _single_ reason for using them is actually the biggest 
reason to NOT use them.

See my point?

> If this is as unpredictable as you describe it, it would mean
> that also new interfaces which need to specify an exact integer
> size would require new sets of type names.

No. They require an OLD set of type names, that have existed for years in
the kernel, and that are already used widely.

In other words, they require __u8/__u16/__u32/__u64. That _is_ the way to 
specify a sized type in kernel headers. It has been that way for years, 
it's extremely readable, it's consistent, and it's compact.

In other words, u8/u16/u32/u64 (and the signed versions: s8 and friends)  
_are_ the standard names in the kernel, and the __ versions have always 
existed alongside them for things like header files that have namespace 
issues.

So forget about that stupid abortion called "uint32_t" already. It buys
you absolutely nothing.

			Linus
