Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbTI3WaQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 18:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbTI3WaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 18:30:15 -0400
Received: from gaia.cela.pl ([213.134.162.11]:49929 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S261772AbTI3WaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 18:30:09 -0400
Date: Wed, 1 Oct 2003 00:27:49 +0200 (CEST)
From: Maciej Zenczykowski <maze@cela.pl>
To: Russell King <rmk@arm.linux.org.uk>
cc: Andrew Morton <akpm@osdl.org>, Arun Sharma <arun.sharma@intel.com>,
       <linux-kernel@vger.kernel.org>, <kevin.tian@intel.com>,
       Matthew Wilcox <willy@debian.org>
Subject: Re: [PATCH] incorrect use of sizeof() in ioctl definitions
In-Reply-To: <20030930223531.B10154@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0310010022320.20935-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Matthew's conversion mainly converted things to size_t, but from the looks
> > of it, __u32* is the right thing to use in this case, I think?
> 
> sizeof(__u32*) may not be sizeof(sizeof(__u32*)), so this would be an API
> change...  Therefore, all these wrong entries need to change to size_t
> (preferably with the real type following inside a comment so we don't
> loose useful information.)

I hit this bug a while back - most often it's for 4byte sized objects 
(ints or pointers) on x86 arch (don't know about others).  Unfortunately 
there was a case where it was for an 8 and was wrongly declared via sizeof 
and thus 4.  I'd suggest moving all to single sizeof's and where this 
causes API changes to implement bogus/extra declarations which could then 
possibly be faded out with time.  However currently the glibc kernel 
headers are also similarly screwed.  Obviously this would bloat the kernel 
a little, OTOH for x86 arch I only noticed one case where it didn't end up 
the same whether thru double or single sizeof.  Perhaps we could be lucky 
and have almost as much luck on other archs?

MaZe.

