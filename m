Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVCQXNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVCQXNB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 18:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVCQXNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 18:13:01 -0500
Received: from fire.osdl.org ([65.172.181.4]:47546 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261348AbVCQXLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 18:11:53 -0500
Date: Thu, 17 Mar 2005 15:11:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prezeroing V8
Message-Id: <20050317151151.47fd6e5f.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503171423590.10008@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503171340480.9678@schroedinger.engr.sgi.com>
	<20050317140831.414b73bb.akpm@osdl.org>
	<Pine.LNX.4.58.0503171423590.10008@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> On Thu, 17 Mar 2005, Andrew Morton wrote:
> 
> > Christoph Lameter <clameter@sgi.com> wrote:
> > >
> > > Adds management of ZEROED and NOT_ZEROED pages and a background daemon
> > > called scrubd. /proc/sys/vm/scrubd_load, /proc/sys/vm_scrubd_start and
> > > /proc/sys/vm_scrubd_stop control the scrub daemon. See Documentation/vm/
> > > scrubd.txt
> >
> > It's hard to know what to think about this without benchmarking numbers.

?

> >
> > It would help if you could briefly describe the implementation and design
> > decisions when sending patches.
> 
> Oh. This was discussed so many times that I thought it would not be
> necessary anymore. The discussion is attached.

Add it to the changelog and maintain it, please.  It never hurts.

But that only describes why we want the feature, which is nice.  It's also
useful to explain how the feature works.  Although my preference there is
that this be done within code comments if at all appropriate.

<looks>

OK, so we're splitting each zone's buddy structure into two: one for zeroed
pages and one for not-zeroed pages, yes?

It's not obvious what the page->private of freed pages are being used for. 
Please comment that.

What's all this (zero << 10) stuff?

+	page->private = order + (zero << 10);
+           (page_zorder(page) == order + (zero << 10)) &&

Doesn't this explode if we already have order-1024 pages in there?  I guess
that's a reasonable restriction, but where did the "10" come from? 
Non-obvious, needs commenting.

And given that we have separate buddy structures for zeroed and not-zeroed
pages, why is this tagging needed at all?


These are all design decisions which have been made, but they're not
communicated either in the patch description or in code comments.  It's to
everyone's advantage to fix that, no?

