Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbULUWyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbULUWyy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 17:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbULUWyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 17:54:54 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:1258 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261624AbULUWyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 17:54:49 -0500
Date: Tue, 21 Dec 2004 14:54:46 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Increase page fault rate by prezeroing V1 [1/3]: Introduce
 __GFP_ZERO
In-Reply-To: <p73mzw7cm1p.fsf@verdi.suse.de>
Message-ID: <Pine.LNX.4.58.0412211452110.2541@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com.suse.lists.linux.kernel>
 <41C20E3E.3070209@yahoo.com.au.suse.lists.linux.kernel>
 <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com.suse.lists.linux.kernel>
 <Pine.LNX.4.58.0412211155340.1313@schroedinger.engr.sgi.com.suse.lists.linux.kernel>
 <p73mzw7cm1p.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2004, Andi Kleen wrote:

> Christoph Lameter <clameter@sgi.com> writes:
> > @@ -0,0 +1,52 @@
> > +/*
> > + * Zero a page.
> > + * rdi	page
> > + */
> > +	.globl zero_page
> > +	.p2align 4
> > +zero_page:
> > +	xorl   %eax,%eax
> > +	movl   $4096/64,%ecx
> > +	shl	%ecx, %esi
>
> Surely must be shl %esi,%ecx

Ahh. Thanks.

> But for the one instruction it seems overkill to me to have a new
> function. How about you just extend clear_page with the order argument?

We can just

#define clear_page(__p) zero_page(__p, 0)

and remove clear_page?

>
> BTW I think Andrea has been playing with prezeroing on x86 and
> he found no benefit at all. So it's doubtful it makes any sense
> on x86/x86-64.

Andrea's approach was:

1. Zero hot pages
2. Zero single pages

which simply results in shifting the processing time somewhere else.
