Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbTH0OB6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 10:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263373AbTH0OB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 10:01:58 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:8326 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S263150AbTH0OB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 10:01:57 -0400
Date: Wed, 27 Aug 2003 15:01:21 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Jim Houston <jim.houston@comcast.net>, linux-kernel@vger.kernel.org,
       jim.houston@ccur.com
Subject: Re: [PATCH] Pentium Pro - sysenter - doublefault
Message-ID: <20030827140121.GA1973@mail.jlokier.co.uk>
References: <1061498486.3072.308.camel@new.localdomain> <20030825040514.GA20529@mail.jlokier.co.uk> <20030826122621.GB3140@malvern.uk.w2k.superh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030826122621.GB3140@malvern.uk.w2k.superh.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Curnow wrote:
> OK, since I get something different to the other reports I saw:
> 
>  1:20PM-malvern-0-534-% ./sysenter
>  1:20PM-malvern-STKFLT-535-% echo $?
> 144

Hi Richard,

That's because you ran it on a 2.5/2.6 kernel, right?  The test code
is meant for 2.4 kernels and earlier :)

Here is a more universal test:

	int main () {
		asm ("movl %%esp,%%ebp;sysenter" : : "a" (1), "b" (0));
		return 0;
	}

I expect it to do the first of these which is applicable:

	- raise SIGILL on Pentium and earlier Intel CPUs
	- raise SIGILL on non-Intel CPUs which don't have the SEP capability
	- raise SIGSEGV on Pentium Pro CPUs
	- raise SIGSEGV on Pentium II CPUs with model == 3 and stepping < 3
	- raise SIGSEGV on 2.4 kernels
	- exit with status 0 on 2.6 kernels

Enjoy,
-- Jamie
