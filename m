Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbUK0FrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbUK0FrV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 00:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbUK0DvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:51:12 -0500
Received: from zeus.kernel.org ([204.152.189.113]:5572 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262531AbUKZTdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:33:42 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: David Woodhouse <dwmw2@infradead.org>
To: Alexandre Oliva <aoliva@redhat.com>
Cc: Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org,
       libc-alpha@sources.redhat.com
In-Reply-To: <ory8goygpr.fsf@livre.redhat.lsd.ic.unicamp.br>
References: <19865.1101395592@redhat.com>
	 <orvfbtzt7t.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <20041125210137.GD2849@parcelfarce.linux.theplanet.co.uk>
	 <ory8goygpr.fsf@livre.redhat.lsd.ic.unicamp.br>
Content-Type: text/plain
Message-Id: <1101470002.8191.9436.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Fri, 26 Nov 2004 11:53:23 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-26 at 09:47 -0200, Alexandre Oliva wrote:
> On Nov 25, 2004, Matthew Wilcox <matthew@wil.cx> wrote:
> 
> > On Thu, Nov 25, 2004 at 04:20:06PM -0200, Alexandre Oliva wrote:
> >> This means these headers shouldn't reference each other as
> >> linux/user/something.h, but rather as linux/something.h, such that
> >> they still work when installed in /usr/include/linux.  This may
> >> require headers include/linux/something.h to include
> >> linux/user/something.h, but that's already part of the proposal.
> 
> > That's going to take severe brain-ache to get right ... and worse,
> > keep right.  These headers aren't going to get tested outside the kernel
> > tree often.  So we'll have missing includes and files that only work if
> > the <linux/> they're including is a kernel one rather than a user one.
> 
> How about moving the internals (i.e., what's not to be exported to
> userland) from linux and asm elsewhere, then?
> 
> Sure, it means significantly more churn in the kernel, but there's
> going to be a lot of moving stuff around one way or the other.

Not really. The kernel code was what was _allowed_ to be using those
headers with those names in the first place; it was userspace which
shouldn't necessarily have been doing so.

> While at that, we could also split what's kernel internal for real and
> what's to be visible to external kernel modules as well.  So we'd have
> 3 layers of headers, instead of two.  I'm not sure this actually makes
> any sense though, since there might be lots of dependencies of headers
> for modules on internal headers.

All modules will be entirely dependent on the full set of kernel
headers. Let's not go there.

-- 
dwmw2

