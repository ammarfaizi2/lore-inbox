Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268113AbUHFKQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268113AbUHFKQq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 06:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268114AbUHFKQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 06:16:46 -0400
Received: from omx3-ext.SGI.COM ([192.48.171.20]:60099 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268113AbUHFKQo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 06:16:44 -0400
Date: Fri, 6 Aug 2004 03:14:18 -0700
From: Paul Jackson <pj@sgi.com>
To: Simon Derr <Simon.Derr@bull.net>
Cc: mbligh@aracnet.com, akpm@osdl.org, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, lse-tech@lists.sourceforge.net, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] new bitmap list format (for cpusets)
Message-Id: <20040806031418.3c58f48f.pj@sgi.com>
In-Reply-To: <Pine.A41.4.53.0408060930100.20680@isabelle.frec.bull.fr>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<250840000.1091738840@flay>
	<20040805144529.3d9c1fc2.pj@sgi.com>
	<Pine.A41.4.53.0408060930100.20680@isabelle.frec.bull.fr>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon wrote:
> it really would have been a shame to lose this ease of use 

I agree with Simon -- this formatting makes learning, using and messing
around with cpusets much easier.  No need to learn yet another limited
use utility that tends to insulate one from what's going on.  Direct and
easy kernel control is good.

It doesn't matter much one way or the other to user level C code.  That
code has some function or library routine to parse the ascii file to and
from the preferred internal bitmap either way, whether the file format
is fixed length hex, or variable length decimal lists.

If is just an issue of compiled kernel text size, we could conditionally
compile the 837 bytes of text (on an i386 build close at hand: 459 bytes
for bitmap_parselist, 199 bytes for bitmap_scnlistprintf and 179 for
bscnl_emit).  So far only cpusets uses this format.  But usually it's
more a matter of kernel source and future maintenance.

I appreciate that it is easy to be against everyone's kernel bloat,
except my own ;).

I view the tradeoff as kernel developer time versus the time of users of
cpusets.  I think that the users of cpusets will save more time if they
have this more friendly, less error prone, format, than the kernel
hackers will spend maintaining the formatting code.  However, I'm
comparing two small numbers with alot of uncertainty on each number, so
... who knows.  I try to optimize for minimum total expenditure of human
brain power.  As anyone can tell from listening to the news, that's the
resource we most critically short of ;).

So I vote to keep it.  But if it goes down the other way, that's not
a big problem.

Oops - one buglet I see - I forgot to mark bscnl_emit() helper routine
static, in lib/bitmap.c.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
