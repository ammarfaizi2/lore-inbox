Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbUCWDjF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 22:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbUCWDjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 22:39:05 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:20055 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262260AbUCWDjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 22:39:00 -0500
Date: Mon, 22 Mar 2004 19:36:28 -0800
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com, hch@infradead.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-Id: <20040322193628.4278db8c.pj@sgi.com>
In-Reply-To: <20040323031345.GY2045@holomorphy.com>
References: <1079659184.8149.355.camel@arrakis>
	<20040318175654.435b1639.pj@sgi.com>
	<1079737351.17841.51.camel@arrakis>
	<20040319165928.45107621.pj@sgi.com>
	<20040320031843.GY2045@holomorphy.com>
	<20040320000235.5e72040a.pj@sgi.com>
	<20040320111340.GA2045@holomorphy.com>
	<20040322171243.070774e5.pj@sgi.com>
	<20040323020940.GV2045@holomorphy.com>
	<20040322183918.5e0f17c7.pj@sgi.com>
	<20040323031345.GY2045@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> gcc flat out miscompiled such inlines last I checked (Zwane shipped the
> bugreport IIRC).

The one error I've heard tell of recently is one that Andi Kleen hit in
include/linux/bitmap.h.  He had to compute the copy length explicitly in
a separate variable, or gcc forgot to do it (I forget the details).  The
change is:


 static inline void bitmap_copy(unsigned long *dst,
                        const unsigned long *src, int bits)
 {
-       memcpy(dst, src, BITS_TO_LONGS(bits)*sizeof(unsigned long));
+       int len = BITS_TO_LONGS(bits)*sizeof(unsigned long);
+       memcpy(dst, src, len);
 }


Do you have any more pointers/info on the miscompile you quote above?
Like - how long ago - what gcc version ...

It would be an insult to wrap the entire cpumask design around the
axle of such non-specific allegations of gcc misconduct.  Better to
get the API right, and then deal with specific tool bugs as necessary.

Or, as Linus might say (did say, in a quite different context):

  Never _ever_ make your source-code look worse because your tools suck. Fix
  the tools instead.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
