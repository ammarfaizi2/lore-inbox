Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbTIQVl1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 17:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262836AbTIQVl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 17:41:27 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:51688 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S262819AbTIQVlY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 17:41:24 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: [PATCH] 2.4 force_successful_syscall()
Date: Wed, 17 Sep 2003 15:41:16 -0600
User-Agent: KMail/1.5.3
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309171659510.3994-100000@logos.cnet>
In-Reply-To: <Pine.LNX.4.44.0309171659510.3994-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200309171541.16313.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 September 2003 2:00 pm, Marcelo Tosatti wrote:
> 
> On Wed, 10 Sep 2003, Bjorn Helgaas wrote:
> 
> > Here's a 2.4 backport of this change to 2.5:
> > 
> >     http://linux.bkbits.net:8080/linux-2.5/cset@1.1046.238.7?nav=index.html
> > 
> > Alpha, ppc, and sparc64 define force_successful_syscall_return() in 2.5,
> > but since it's not obvious to me how to do it correctly in 2.4, I left
> > them unchanged.
> 
> Whats the reasoning behing this patch?

Basically we don't want a large unsigned return value to be
misinterpreted as a syscall failure because it looks like
a small negative number.

>From David's description of the 2.5 patch (the link above has
the explanation):

Many architectures (alpha, ia64, ppc, ppc64, sparc, and sparc64 at least)
use a syscall convention which provides for a return value and a separate
error flag.  On those architectures, it can be beneficial if the kernel
provides a mechanism to signal that a syscall call has completed
successfully, even when the returned value is potentially a (small)
negative number.  The patch below provides a hook for such a mechanism via
a macro called force_successful_syscall_return().  On x86, this would be
simply a no-op (because on x86, user-level has to be hacked to handle such
cases).

