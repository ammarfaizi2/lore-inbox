Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751767AbWJIKL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbWJIKL6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 06:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbWJIKL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 06:11:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35466 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751763AbWJIKL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 06:11:57 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0610061015570.14591@schroedinger.engr.sgi.com> 
References: <Pine.LNX.4.64.0610061015570.14591@schroedinger.engr.sgi.com>  <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com> <20061006141704.GH2563@parisc-linux.org> 
To: Christoph Lameter <clameter@sgi.com>
Cc: Matthew Wilcox <matthew@wil.cx>, torvalds@osdl.org, akpm@osdl.org,
       sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in the kernel [try #4] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 09 Oct 2006 11:11:36 +0100
Message-ID: <7795.1160388696@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:

> Why so complicated and why do it at all? We already have fls and ffs 
> amoung the bit operations and those map to cpu instructions on arches 
> that support these. fls can be used as a log 2 facilities. If you need 
> another name and further refine it then just add an inline function.

There are a number of reasons:

 (1) There are a bunch of independent log2 implementations lying around in the
     code.  It'd be nice to just have one set that anyone can use.

 (2) Not everyone realises that fls() can be used to do log2().

 (3) ilog2(n) != fls(n)

     This means that the asm-optimised version for one might be less optimal
     for the other (for example, ilog2() produces an undefined result if n <=
     1, fls() must return 0).

 (4) There are occasions when you might want to take a log2 of a constant.
     With the totally inline asm approach, it would always execute some code,
     though it should be unnecessary.  What I've done permits you to avoid that
     as the answer is always going to be the same.

 (5) fls() and fls64() can't be used to initialise a variable at compile time,
     ilog2() can.

David
