Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWGOE75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWGOE75 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 00:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWGOE75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 00:59:57 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:46295 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751324AbWGOE75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 00:59:57 -0400
Date: Fri, 14 Jul 2006 21:59:19 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>, torvalds@osdl.org, akpm@osdl.org
Subject: Re: RFC: cleaning up the in-kernel headers
In-Reply-To: <1152937109.27135.101.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0607142152420.9010@schroedinger.engr.sgi.com>
References: <20060711160639.GY13938@stusta.de> 
 <Pine.LNX.4.64.0607131201050.28976@schroedinger.engr.sgi.com>
 <1152937109.27135.101.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jul 2006, Steven Rostedt wrote:

> Are you talking about the page-flags.h or the vmstat.h?

Both are troublesome. I forked off vmstat.hy from page-flags.h
and all my attempts to straigthen things out results in other problems
so I finally gave up and just did the same for vmstat.h.

> The page-flags.h has a FIXME by it to remove it, but under Adrian's
> rules, it seems that it should still belong.  The rule is that if foo.h
> needs bar.h to compile, then foo.h should have bar.h in it. And just
> seeing what happens if we remove page-flags.h from mm.h, we get a
> compile error in mm.h. Which means that that page-flags.h belongs in
> mm.h since it wont compile without it.

page-flags.h also seems to be included from the arches 
for various purposes. 

grep page-flags include/asm-*/*

include/asm-ia64/cacheflush.h:#include <linux/page-flags.h>
include/asm-ia64/pgalloc.h:#include <linux/page-flags.h>
include/asm-ia64/uaccess.h:#include <linux/page-flags.h>

grep page-flags arch/*/*/*
arch/s390/appldata/appldata_base.c:#include <linux/page-flags.h>

mm.h gets too big. It would be best if we had some smaller granularity and
page-flags.h should be pretty much stand on its own.


> Now for the vmstat.h, I just tried removing that, and it seems that this
> is a candidate to be removed from mm.h since mm.h compiles fine without
> it. But vmstat.h doesn't compile without mm.h.  So it seems that we
> should add mm.h to vmstat.h, remove vmstat.h from mm.h and for those .c
> files that break, just add vmstat.h to them.

Great if you can detangle that.

