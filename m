Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWHTSWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWHTSWU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 14:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWHTSWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 14:22:20 -0400
Received: from 1wt.eu ([62.212.114.60]:55568 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751120AbWHTSWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 14:22:19 -0400
Date: Sun, 20 Aug 2006 20:21:38 +0200
From: Willy Tarreau <w@1wt.eu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Solar Designer <solar@openwall.com>,
       Alex Riesen <fork0@users.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
Message-ID: <20060820182137.GO602@1wt.eu>
References: <20060820003840.GA17249@openwall.com> <20060820100706.GB6003@steel.home> <20060820153037.GA20007@openwall.com> <1156097013.4051.14.camel@localhost.localdomain> <20060820181025.GN602@1wt.eu> <1156099006.4051.43.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156099006.4051.43.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 07:36:46PM +0100, Alan Cox wrote:
> Ar Sul, 2006-08-20 am 20:10 +0200, ysgrifennodd Willy Tarreau:
> > So I think that while it's bad code in userland, a misunderstood kernel
> > semantic caught the developpers. We can at least make the kernel help them.
> 
> Yeah we could. But unfortunately a competence test with the inability to
> write C code isn't part of the Unix spec.

I know but those programs sometimes ship with distros. How many distros do
not ship with either Xfree86 nor Xorg ?

> You can help them enormously using the gcc extensions so gcc warns about
> any unchecked set*uid call, rather than redesigning expected behaviour
> to cause obscure random kills that won't even be noticed/explained.

Arjan proposed to add a __must_check on the set*uid() function in glibc.
I think that if killing the program is what makes you nervous, we could
at least print a warning in the kernel logs so that the admin of a machine
being abused has a chance to detect what's going on. Would you accept
something like this ?

Willy

