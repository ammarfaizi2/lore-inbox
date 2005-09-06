Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbVIFEjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVIFEjI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 00:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbVIFEjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 00:39:07 -0400
Received: from hera.kernel.org ([209.128.68.125]:39856 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932377AbVIFEjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 00:39:05 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [discuss] [2.6 patch] include/asm-x86_64 "extern inline" -> "static inline"
Date: Tue, 6 Sep 2005 04:38:47 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <dfj6gn$emj$1@terminus.zytor.com>
References: <20050902203123.GT3657@stusta.de> <20050905180005.GA3776@stusta.de> <20050905184740.GF7403@devserv.devel.redhat.com> <20050905190014.GB3776@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1125981527 15060 127.0.0.1 (6 Sep 2005 04:38:47 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 6 Sep 2005 04:38:47 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20050905190014.GB3776@stusta.de>
By author:    Adrian Bunk <bunk@stusta.de>
In newsgroup: linux.dev.kernel
>
> On Mon, Sep 05, 2005 at 02:47:40PM -0400, Jakub Jelinek wrote:
> > On Mon, Sep 05, 2005 at 08:00:05PM +0200, Adrian Bunk wrote:
> > > It isn't the same, but "static inline" is the correct variant.
> > > 
> > > "extern inline __attribute__((always_inline))" (which is what
> > > "extern inline" is expanded to) doesn't make sense.
> > 
> > It does make sense and is different from
> > static inline __attribute__((always_inline)).
> > Try:
> > static inline __attribute__((always_inline)) void foo (void) {}
> > void (*fn)(void) = foo;
> > vs.
> > extern inline __attribute__((always_inline)) void foo (void) {}
> > void (*fn)(void) = foo;
> > In the former case, GCC will emit the out of line static copy of foo
> > if you take its address, in the latter case either you provide foo
> > function by other means, or you get linker error.
> 
> And we need the former case because in the kernel we do not have 
> out-of-line variants of the inline functions.
> 

UNLESS the function is broken if out-of-lined.  If the function cannot
be safely out-of-lined, extern inline MUST be used.

	-hpa
