Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269340AbUJWBYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269340AbUJWBYZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 21:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269347AbUJWBUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 21:20:30 -0400
Received: from ozlabs.org ([203.10.76.45]:1471 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269538AbUJWAeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:34:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16761.42743.34328.919506@cargo.ozlabs.ibm.com>
Date: Sat, 23 Oct 2004 10:33:59 +1000
From: Paul Mackerras <paulus@samba.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pmac_cpufreq msleep cleanup/fixes
In-Reply-To: <20041022234344.GI18906@us.ibm.com>
References: <200410221906.i9MJ63Ai022889@hera.kernel.org>
	<1098484616.6028.80.camel@gaston>
	<Pine.LNX.4.58.0410221552320.2101@ppc970.osdl.org>
	<1098487053.6029.89.camel@gaston>
	<20041022234344.GI18906@us.ibm.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth Aravamudan writes:

> Looks good to me... And makes quite a bit of sense, after I thought
> about it. Does feel a little hacky, but I don't see a slicker way around
> the problem...

We would need a platform-specific function to tell us how long until
the next jiffy to do any better, I think, and even then it would only
make much of a difference if HZ was significantly smaller than 1000.

We could do the how-long-until-next-jiffy function quite easily and
quickly on ppc and ppc64, just by reading the decrementer register and
scaling it.  I don't know about other architectures.  But if we are
mostly using HZ=1000 there doesn't seem to be much point.

Paul.
