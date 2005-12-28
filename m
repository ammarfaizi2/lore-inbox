Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbVL1TwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbVL1TwD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 14:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbVL1TwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 14:52:01 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:11997 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964891AbVL1TwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 14:52:01 -0500
Subject: Re: [patch 01/2] allow gcc4 to control inlining
From: Arjan van de Ven <arjan@infradead.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051228183912.GF27946@ftp.linux.org.uk>
References: <20051228114653.GB3003@elte.hu>
	 <20051228183912.GF27946@ftp.linux.org.uk>
Content-Type: text/plain
Date: Wed, 28 Dec 2005 20:51:56 +0100
Message-Id: <1135799516.2935.34.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-28 at 18:39 +0000, Al Viro wrote:
> On Wed, Dec 28, 2005 at 12:46:53PM +0100, Ingo Molnar wrote:
> > allow gcc4 compilers to decide what to inline and what not - instead
> > of the kernel forcing gcc to inline all the time.
> 
> > +#define noinline		__attribute__((noinline))
> > +#define __always_inline		inline __attribute__((always_inline))
> >  #define __must_check 		__attribute__((warn_unused_result))
> >  #define __compiler_offsetof(a,b) __builtin_offsetof(a,b)
> 
> You seem to be missing the rest of the patch - namely, addition of
> always_inline where it is needed now...
> 
> Note that we *do* need it in quite a few places.  Anything that relies on
> dead code elimination to kill a call of function that doesn't exist
> would better be always inlined...

on x86-64 that seems to only be fix_to_virt though.. so it's really not
that many.

(based on making "inline" a define for noinline and then an
allyesconfig)

