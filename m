Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751799AbWJILHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbWJILHP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 07:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbWJILHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 07:07:14 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:24967 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751799AbWJILHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 07:07:12 -0400
Date: Mon, 9 Oct 2006 04:06:41 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <matthew@wil.cx>, torvalds@osdl.org, akpm@osdl.org,
       sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in
 the kernel [try #4] 
In-Reply-To: <7795.1160388696@redhat.com>
Message-ID: <Pine.LNX.4.64.0610090403490.25336@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0610061015570.14591@schroedinger.engr.sgi.com> 
 <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com>
 <20061006141704.GH2563@parisc-linux.org>  <7795.1160388696@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2006, David Howells wrote:

> There are a number of reasons:
> 
>  (1) There are a bunch of independent log2 implementations lying around in the
>      code.  It'd be nice to just have one set that anyone can use.

True. So wrap around what is there but do not add gazillion of definitions 
to all arches.
 
>  (2) Not everyone realises that fls() can be used to do log2().

So this is a case for a wrapper.
 
>  (3) ilog2(n) != fls(n)
> 
>      This means that the asm-optimised version for one might be less optimal
>      for the other (for example, ilog2() produces an undefined result if n <=
>      1, fls() must return 0).

Ok these are boundary checks that are easily coded around. Some 
variations on fls even exist that also do various flavors of end case 
handling.
 
>  (4) There are occasions when you might want to take a log2 of a constant.
>      With the totally inline asm approach, it would always execute some code,
>      though it should be unnecessary.  What I've done permits you to avoid that
>      as the answer is always going to be the same.

Good stuff. I have always wanted that. The wrapper could check for a 
constant.
 
>  (5) fls() and fls64() can't be used to initialise a variable at compile time,
>      ilog2() can.

Well that is the same issue as (4).
