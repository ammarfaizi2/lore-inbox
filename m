Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVCRAAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVCRAAn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 19:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVCRAAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 19:00:40 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:41890 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261303AbVCRAA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 19:00:26 -0500
Date: Thu, 17 Mar 2005 16:00:24 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prezeroing V8
In-Reply-To: <20050317155208.22b72984.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503171554230.10205@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503171340480.9678@schroedinger.engr.sgi.com>
 <20050317140831.414b73bb.akpm@osdl.org> <Pine.LNX.4.58.0503171423590.10008@schroedinger.engr.sgi.com>
 <20050317151151.47fd6e5f.akpm@osdl.org> <Pine.LNX.4.58.0503171518030.10205@schroedinger.engr.sgi.com>
 <20050317155208.22b72984.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2005, Andrew Morton wrote:

> Christoph Lameter <clameter@sgi.com> wrote:
> >
> > > And given that we have separate buddy structures for zeroed and not-zeroed
> >  > pages, why is this tagging needed at all?
> >
> >  Because the buddy pointers may point to a page of the different kind. Then
> >  a merge is not possible.
>
> In that case I still don't understand, sorry.
>
> If each zone has two buddy lists, one for zeroed and one for not-zeroed,
> how can we ever get known-to-be-zeroed pages on the not-known-to-be-zeroed
> list or vice versa?

The buddy is calculated based on the position in the page struct array not
based on the list.

> >
> >   #define __free_page(page) __free_pages((page), 0)
> >   #define free_page(addr) free_pages((addr),0)
> >
> >  This is what you want right?
>
> Well, it was more a question that a request.  If we do this, does it speed
> anything up?

It will be able to manage the quicklist effectively and you can avoid
having to zero a page for pte/pmd/pud/pgds.

The main benefit from prezeroing is gained for programs that do numerical
calculations based on sparse matrices or other extremely large programs
that typically also come with large sparse arrays. The optimization is
typical for operating systems in that area (even M$ does that...).

