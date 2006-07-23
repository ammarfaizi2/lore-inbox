Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWGWVOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWGWVOK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 17:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWGWVOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 17:14:09 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:5861 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750725AbWGWVOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 17:14:08 -0400
Date: Sun, 23 Jul 2006 14:13:19 -0700
From: Paul Jackson <pj@sgi.com>
To: ricknu-0@student.ltu.se
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, jeff@garzik.org,
       adobriyan@gmail.com, vlobanov@speakeasy.net, jengelh@linux01.gwdg.de,
       getshorty_@hotmail.com, pwil3058@bigpond.net.au, mb@bu3sch.de,
       penberg@cs.helsinki.fi, stefanr@s5r6.in-berlin.de, larsbj@gullik.net
Subject: Re: [RFC][PATCH] A generic boolean (version 4)
Message-Id: <20060723141319.7eed99eb.pj@sgi.com>
In-Reply-To: <1153669750.44c39a7607a30@portal.student.luth.se>
References: <1153341500.44be983ca1407@portal.student.luth.se>
	<1153669750.44c39a7607a30@portal.student.luth.se>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The defines of false and true to be themselves are going to cause a
thousand code readers to say "wtf?".  How about a comment, as in:

 enum {
 	false	= 0,
 	true	= 1
 };
+
+/* Let any other #if[n]def's on false/true presume they're defined */
 #define false false
 #define true true 
 

===

On second thought, I just grep'd the entire kernel with:
	grep -E '#ifn*def.*(false|true)'
and only found exactly one other such #ifdef construct:

  drivers/media/video/cpia2/cpia2.h:
    #ifndef true
    #define true 1
    #define false 0
    #endif

Perhaps we should just drop the cpia2.h defines, and drop
the defines of false/true to be themselves.  And drop my
comment ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
