Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWE3UWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWE3UWn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 16:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWE3UWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 16:22:43 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:54148 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932399AbWE3UWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 16:22:42 -0400
Date: Tue, 30 May 2006 13:21:52 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: David Howells <dhowells@redhat.com>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/3] mm: tracking shared dirty pages 
In-Reply-To: <18903.1149011787@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0605301317340.18290@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0605300953390.17716@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.64.0605300818080.16904@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0605260825160.31609@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0605250921300.23726@schroedinger.engr.sgi.com>
 <20060525135534.20941.91650.sendpatchset@lappy> <20060525135555.20941.36612.sendpatchset@lappy>
 <24747.1148653985@warthog.cambridge.redhat.com> <12042.1148976035@warthog.cambridge.redhat.com>
 <7966.1149006374@warthog.cambridge.redhat.com>  <18903.1149011787@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006, David Howells wrote:

> Christoph Lameter <clameter@sgi.com> wrote:
> 
> > On Tue, 30 May 2006, David Howells wrote:
> > 
> > > > If set_page_dirty cannot reserve the page then we know that some severe
> > > > action is required. The FS method set_page_dirty() could:
> > > 
> > > But by the time set_page_dirty() is called, it's too late as the code
> > > currently stands.  We've already marked the PTE writable and dirty.  The
> > > page_mkwrite() op is called _first_.
> > 
> > We are in set_page_dirty and this would be part of set_page_dirty 
> > processing.
> 
> Eh?  What do you mean "We are in set_page_dirty"?

We could do the reservation in as part of the set_page_dirty FS method.

> Actually, I'm not sure that calling set_page_dirty() at the bottom of
> do_wp_page() is necessarily a good idea.  It's possible that the page will be
> marked dirty in do_wp_page() and then will get written back before the write
> actually succeeds.  In other words the page may be marked dirty and cleaned up
> all before the modification _actually_ occurs.  On the other hand, the common
> case is probably that the store instruction will beat the writeback.

Yes we are aware of that case.

