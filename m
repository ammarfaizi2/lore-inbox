Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbUK2Hxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbUK2Hxp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 02:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbUK2Hxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 02:53:45 -0500
Received: from mx2.redhat.com ([66.187.237.31]:14035 "EHLO mx2.redhat.com")
	by vger.kernel.org with ESMTP id S261189AbUK2Hxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 02:53:43 -0500
Date: Mon, 29 Nov 2004 08:51:16 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, David Woodhouse <dwmw2@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com, Mariusz Mazur <mmazur@kernel.pl>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041129075116.GB29700@devserv.devel.redhat.com>
References: <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk> <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com> <16810.24893.747522.656073@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> <41AAA746.5000003@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41AAA746.5000003@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, Nov 28, 2004 at 11:36:22PM -0500, Jeff Garzik wrote:
> >In particular, any re-organization that breaks _existing_ uses is totally
> >pointless. If you break existing uses, you might as well _not_ re-
> >organize, since if you consider kernel headers to be purely kernel-
> >internal (like they should be, but hey, reality trumps any wishes we might 
> >have), then the current organization is perfectly fine.
> 
> 
> I don't think any drastic reorganization is even necessary.

Well, we want things to be split. However a split doesn't mean a
reorganisation as far as userspace visibility is concerned; the filenames
can still be the same, and the typenames etc etc, you just do the kernel
internal additions in a different dir/header

Not breaking userland ever is a dream only, anytime we touch any header,
some userland breaks (they use our spinlock code even!)

> kernel-specific stuff stripped out.  i.e. userland ABI only.  Not sure 
> how many distros have started picking that up yet...  I think Arjan said 
> Fedora Core had, or would.

nope.

Fedora has it's own set of cleaned up headers. Cleaned up in the sense that
tehre's no #ifdef KERNEL anymore, no inlines (because that's a license trap,
and in addition, all inlines were kernel specific anyway) and all structs
which had spinlocks / semaphores and other kernel private structures in are
removed as well (because they are clearly kernel internal).
