Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbUL0Ww4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbUL0Ww4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 17:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbUL0Wwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 17:52:54 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:28836
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261998AbUL0WwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 17:52:19 -0500
Date: Mon, 27 Dec 2004 14:50:57 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: arjan@infradead.org, paulus@samba.org, clameter@sgi.com, akpm@osdl.org,
       linux-ia64@vger.kernel.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Prezeroing V2 [0/3]: Why and When it works
Message-Id: <20041227145057.4c5cd651.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58.0412241018430.2654@ppc970.osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
	<41C20E3E.3070209@yahoo.com.au>
	<Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
	<16843.13418.630413.64809@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0412231325420.2654@ppc970.osdl.org>
	<1103879668.4131.15.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.58.0412241018430.2654@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2004 10:21:24 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> Absolutely. I would want to see some real benchmarks before we do this.  
> Not just some microbenchmark of "how many page faults can we take without
> _using_ the page at all".

Here's my small contribution.  I did three "make -j3 vmlinux" timed
runs, one running a kernel without the pre-zeroing stuff applied,
one with it applied.  It did shave a few seconds off the build
consistently.  Here is the before:

real	8m35.248s
user	15m54.132s
sys	1m1.098s

real	8m32.202s
user	15m54.329s
sys	1m0.229s

real	8m31.932s
user	15m54.160s
sys	1m0.245s

and here is the after:

real	8m29.375s
user	15m43.296s
sys	0m59.549s

real	8m28.213s
user	15m39.819s
sys	0m58.790s

real	8m26.140s
user	15m44.145s
sys	0m58.872s
