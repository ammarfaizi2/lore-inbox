Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266202AbUGJJ4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266202AbUGJJ4u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 05:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266203AbUGJJ4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 05:56:50 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:56580 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S266202AbUGJJ4t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 05:56:49 -0400
Date: Sat, 10 Jul 2004 19:56:35 +1000
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Chris Wright <chrisw@osdl.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil,
       jmorris@redhat.com, mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
Message-ID: <20040710095635.GA16609@gondor.apana.org.au>
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org> <m1fz80c406.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0407092313410.1764@ppc970.osdl.org> <m1smc09p6m.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1smc09p6m.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6+20040523i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 03:39:13AM -0600, Eric W. Biederman wrote:
> 
> I would agree that using the constant "0" in a pointer context
> when a more explicit NULL is bad form.  But "0" is the one
> legal way in C to write the NULL pointer constant.

One reason I dislike the push to use NULL everywhere is that
new-comers may feel a false sense of security when using NULL.

This will bite in places where an explicit cast is needed to turn
NULL into a null pointer of the correct type, i.e., pointer arguments
to variadic functions.

A neat trick to catch such errors is to define NULL to be 0LL.
This is perfectly legal under ANSI and will generate a different
representation on i386.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
