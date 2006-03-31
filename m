Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbWCaQWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWCaQWF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 11:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWCaQWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 11:22:05 -0500
Received: from palrel13.hp.com ([156.153.255.238]:16769 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S1751400AbWCaQWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 11:22:04 -0500
Date: Fri, 31 Mar 2006 08:22:22 -0800 (PST)
From: Hans Boehm <Hans.Boehm@hp.com>
X-X-Sender: hboehm@tomil.hpl.hp.com
To: Andi Kleen <ak@suse.de>
Cc: Christoph Lameter <clameter@sgi.com>,
       Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Synchronizing Bit operations V2
In-Reply-To: <p73vetu921a.fsf@verdi.suse.de>
Message-ID: <Pine.GHP.4.58.0603310808190.28478@tomil.hpl.hp.com>
References: <Pine.LNX.4.64.0603301300430.1014@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0603301615540.2023@schroedinger.engr.sgi.com>
 <p73vetu921a.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would argue that there are two semi-viable approaches to this:

1) Guarantee that all atomic operations always include a full
memory fence/barrier.  That way the programmer can largely ignore
associated memory ordering issues.

2) Make the ordering semantics as explicit and clean as possible, which
is being proposed here.

It seems to me that anything in the middle doesn't work well.  If
programmers have to think about ordering at all, you want to make it as
difficult as possible to overlook.

My impression is that approach (1) tends not to stick, since it involves
a substantial performance hit on architectures on which the fence is
not implicitly included in atomic operations.  Those include Itanium and
PowerPC.

Hans

On Fri, 31 Mar 2006, Andi Kleen wrote:

> Christoph Lameter <clameter@sgi.com> writes:
> > MODE_BARRIER
> > 	An atomic operation that is guaranteed to occur between
> > 	previous and later memory operations.
>
>
> I think it's a bad idea to create such an complicated interface.
> The chances that an average kernel coder will get these right are
> quite small. And it will be 100% untested outside IA64 I guess
> and thus likely be always slightly buggy as kernel code continues
> to change.
>
> -Andi
>
