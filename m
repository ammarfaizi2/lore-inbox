Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264261AbUFZTeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbUFZTeI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 15:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbUFZTeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 15:34:08 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:16581 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264261AbUFZTeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 15:34:05 -0400
Subject: Re: [PATCH] Fix the cpumask rewrite
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       PARISC list <parisc-linux@lists.parisc-linux.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406261203370.16079@ppc970.osdl.org>
References: <1088266111.1943.15.camel@mulgrave> 
	<Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org>
	<1088268405.1942.25.camel@mulgrave> 
	<Pine.LNX.4.58.0406260948070.14449@ppc970.osdl.org>
	<1088270298.1942.40.camel@mulgrave> 
	<Pine.LNX.4.58.0406261044580.16079@ppc970.osdl.org>
	<1088276343.1750.105.camel@mulgrave> 
	<Pine.LNX.4.58.0406261203370.16079@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 26 Jun 2004 14:33:55 -0500
Message-Id: <1088278436.1943.148.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-26 at 14:11, Linus Torvalds wrote:
> It seems the pa-risc optimizer for gcc is somehow broken. I just checked 
> on x86:
> 
> 	#define test_bit(x,y) \
> 	        (!!((1ul << x) & *(y)))
> 
> 	int test(unsigned long *a)
> 	{
> 	        while (test_bit(0, a));
> 	}

OK, this one definitely compiles to a non reaload loop on parisc.  I
concede we need the volatile.

James


