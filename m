Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbUK2J5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbUK2J5f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 04:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbUK2J5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 04:57:35 -0500
Received: from canuck.infradead.org ([205.233.218.70]:3077 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261645AbUK2J5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 04:57:32 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: Arjan van de Ven <arjan@infradead.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
In-Reply-To: <16810.61839.658951.369223@cargo.ozlabs.ibm.com>
References: <19865.1101395592@redhat.com>
	 <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
	 <1101406661.8191.9390.camel@hades.cambridge.redhat.com>
	 <20041127032403.GB10536@kroah.com>
	 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
	 <16810.61839.658951.369223@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Message-Id: <1101722231.2814.42.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 29 Nov 2004 10:57:12 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-29 at 20:53 +1100, Paul Mackerras wrote:
> Linus Torvalds writes:
> 
> > In particular, any re-organization that breaks _existing_ uses is totally
> > pointless. If you break existing uses, you might as well _not_ re-
> > organize, since if you consider kernel headers to be purely kernel-
> > internal (like they should be, but hey, reality trumps any wishes we might 
> > have), then the current organization is perfectly fine.
> 
> Recently I had some users complaining because their userspace program
> that includes <asm/atomic.h> compiles OK as a ppc64 program but not as
> a ppc32 program.  The reason for that is that asm-ppc/atomic.h has
> #ifdef __KERNEL__ around the inline definitions of atomic_inc et al.,
> but asm-ppc64/atomic.h doesn't.
> 
> My response was that they shouldn't be using <asm/atomic.h> because
> (a) it's an internal kernel header, not part of the kernel ABI, (b)
> it's not portable (it happens to work on some popular architectures,
> but won't work on all) and (c) they're really only entitled to use
> those particular inline function definitions in GPL'd programs anyway.

and (d) on x86 at least the "atomic" part of the atomic ops are #ifdef
CONFIG_SMP, which might well not be set in userland... so you get a
false sense of atomicity.

> I'd be interested to hear your take on this.  Should we try to make
> our atomics easy and safe for userspace to use (including putting them
> under the LGPL)?  Or can you see a better solution?

it's not the kernel's job to provide this functionality imo. 
glibc could. glib does. apr does. there's several options already.
apr is BSD licensed for exanpmle, glib LGPL.


