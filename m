Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262760AbVA1U7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbVA1U7S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 15:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbVA1U4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 15:56:55 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:51878 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262747AbVA1Umy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 15:42:54 -0500
Subject: Re: Why does the kernel need a gig of VM?
From: Josh Boyer <jdub@us.ibm.com>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41FA9B37.1020100@comcast.net>
References: <41FA9B37.1020100@comcast.net>
Content-Type: text/plain
Date: Fri, 28 Jan 2005 14:42:49 -0600
Message-Id: <1106944969.7542.13.camel@windu.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-28 at 15:06 -0500, John Richard Moser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Can someone give me a layout of what exactly is up there?  I got the
> basic idea
> 
> K 4G
> A 3G
> A 2G
> A 1G
> 
> App has 3G, kernel has 1G at the top of VM on x86 (dunno about x86_64).
> 
> So what's the layout of that top 1G?  What's it all used for?  Is there
> some obscene restriction of 1G of shared memory or something that gets
> mapped up there?
> 
> How much does it need, and why?  What, if anything, is variable and
> likely to do more than 10 or 15 megs of variation?

Because of various reasons.  Normal kernel space virtual addresses
usually start at 0xc0000000, which is where the 3GiB userspace
restriction comes from.  

Then there is the vmalloc virtual address space, which usually starts at
a higher address than a normal kernel address.  Along the same lines are
ioremap addresses, etc.

Poke around in the header files.  I bet you'll find lots of reasons.

josh

