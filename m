Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbWEYRDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbWEYRDk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 13:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbWEYRDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 13:03:40 -0400
Received: from graphe.net ([209.204.138.32]:16778 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S1030283AbWEYRDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 13:03:39 -0400
Date: Thu, 25 May 2006 10:03:32 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Christoph Lameter <clameter@sgi.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/3] mm: tracking shared dirty pages
In-Reply-To: <1148576422.10561.80.camel@lappy>
Message-ID: <Pine.LNX.4.64.0605251001080.30649@graphe.net>
References: <20060525135534.20941.91650.sendpatchset@lappy> 
 <20060525135555.20941.36612.sendpatchset@lappy> 
 <Pine.LNX.4.64.0605250856020.23726@schroedinger.engr.sgi.com>
 <1148576422.10561.80.camel@lappy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -2.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2006, Peter Zijlstra wrote:

> On Thu, 2006-05-25 at 09:21 -0700, Christoph Lameter wrote:
> > On Thu, 25 May 2006, Peter Zijlstra wrote:
> > 
> > > @@ -1446,12 +1447,13 @@ static int do_wp_page(struct mm_struct *
> > >  
> > > -	if (unlikely(vma->vm_flags & VM_SHARED)) {
> > > +	if (vma->vm_flags & VM_SHARED) {
> > 
> > You add this unlikely later again it seems. Why remove in the first place?
> 
> I'm not sure I follow you, are you suggesting that we'll find the
> condition to be unlikely still, even with most of the shared mappings
> trapping this branch?

No, I just saw the opposite in a later patch. It was the -1 patch that 
does

+       if (unlikely(vma->vm_flags & VM_SHARED)) {

but thats a different context?
\
