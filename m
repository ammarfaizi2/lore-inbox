Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWG0BHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWG0BHa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 21:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWG0BHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 21:07:30 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:45712 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750702AbWG0BH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 21:07:29 -0400
Date: Wed, 26 Jul 2006 18:06:22 -0700
From: Paul Jackson <pj@sgi.com>
To: ricknu-0@student.ltu.se
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, jeff@garzik.org,
       adobriyan@gmail.com, vlobanov@speakeasy.net, jengelh@linux01.gwdg.de,
       getshorty_@hotmail.com, pwil3058@bigpond.net.au, mb@bu3sch.de,
       penberg@cs.helsinki.fi, stefanr@s5r6.in-berlin.de, larsbj@gullik.net
Subject: Re: [RFC][PATCH] A generic boolean (version 6)
Message-Id: <20060726180622.63be9e55.pj@sgi.com>
In-Reply-To: <1153945705.44c7d069c5e18@portal.student.luth.se>
References: <1153341500.44be983ca1407@portal.student.luth.se>
	<1153945705.44c7d069c5e18@portal.student.luth.se>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard wrote:
> * removed the #undef false/true and #define false/true

Good - thanks.

+enum {
+	false	= 0,
+	true	= 1
+};

My inclination would have been to write this as the more terse:

+enum { false, true };

But I suspect yours is better, as some readers would not be
confident that the terse form made false == 0 and true == 1.

> a real patch (hoping for inclusion) tomorrow.

Good.

I'm delighted that this favors "true, false and bool",
over "TRUE, FALSE and various spellings of BOOLEAN".

Fun stuff to do in the future:
  Convert test_bit() and various other test_*() and
	atomic_*() operators to return bool.
  Convert many TRUE/FALSE to true/false, in a patch of
	similar size to Andrew's March 2006 patch entitled:
	"[patch 1/1] consolidate TRUE and FALSE".
  Convert a variety of spellings of BOOLEAN to "bool".
  Convert routines and variables using the old C
	convention of int/0/1 for boolean to the
	new bool/false/true.
  How do we detect breakage that results from converting
	an apparent boolean to these values, when the
	code actually worked by using more than just
	values 0 and 1 for the variable in question?
  How do we detect any breakage caused by possible changes
	in the sizeof variables whose type we changed?
  Various sparse and/or gcc checks that benefit from
	knowing the additional constraints on bool types.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
