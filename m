Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVFNPeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVFNPeT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 11:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVFNPeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 11:34:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45444 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261163AbVFNPeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 11:34:14 -0400
Date: Tue, 14 Jun 2005 08:36:05 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Bongani Hlope <bonganilinux@mweb.co.za>
cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Tracking a bug in x86-64
In-Reply-To: <200506132339.13614.bonganilinux@mweb.co.za>
Message-ID: <Pine.LNX.4.58.0506140819440.8487@ppc970.osdl.org>
References: <200506132259.22151.bonganilinux@mweb.co.za>
 <200506132339.13614.bonganilinux@mweb.co.za>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Jun 2005, Bongani Hlope wrote:
> 
> I've just tested 2.6.11-mm1 it has that bug as well. So the bug was introduced on that kernel.

Bongani,
 can you try to narrow it down even further, since nobody sees what coul 
dbe wrong..

The easiest way to narrow it down some more is to get a clean 2.6.11, and
get all the broken-out patches in 2.6.11-mm1, and do a binary search.  
Testing just four or five kernels should already have narrowed it down a
lot.

The way to do the binary searach is to get the

	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm1/2.6.11-mm1-broken-out.tar.gz 

file, and then to apply half of the patches you do basically

	grep -v '^#' broken-out/series | wc

gives you 821, so start with the 410 first patches:

	grep -v '^#' broken-out/series | head -410 > apply
	cat apply | while read i; do ( cd linux-2.6.11 ; patch -p1 ) < broken-out/$i; done

and then you test that. If that doesn't show the problem, try with 615
patches, and so on..

There are smarter ways to do it than just the brute-force approach, but
they're also more likely to break, and doing the brute-force approach for
a small number of kernels should already pinpoint the problem to just a
few patches, and then that is when it is worth starting to think about it.

			Linus
