Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbUDGJMg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 05:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbUDGJMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 05:12:36 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:62069 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262130AbUDGJKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 05:10:03 -0400
Date: Wed, 7 Apr 2004 02:08:45 -0700
From: Jeremy Higdon <jeremy@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jbarnes@sgi.com, davidm@hpl.hp.com
Subject: Re: 2.6.5-mm2 (build error in arch/ia64/kernel/setup.c)
Message-ID: <20040407090845.GA790466@sgi.com>
References: <20040406223321.704682ed.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406223321.704682ed.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a build error in arch/ia64/kernel/setup.c.

This patch fixes it for SN2 machines, but I don't claim it is Correct.
In fact, I think it is Wrong.

There have been changes to setup_arch(), including, apparently, the
elimination of the cmdline_p argument.  Unforunately, that argument
was not completely purged from the function.

platform_setup on SN2 is #define'd to sn_setup, which still takes
the argument, but does not use it.  So this hack works.  I don't
know about the other IA64s.

I'm not sure exactly what was intended with these changes, so I
haven't attempted a Correct patch.

jeremy

--- arch/ia64/kernel/setup.c.old	2004-04-07 02:00:01.000000000 -0700
+++ arch/ia64/kernel/setup.c	2004-04-07 01:37:15.000000000 -0700
@@ -361,7 +361,7 @@
 	/* enable IA-64 Machine Check Abort Handling */
 	ia64_mca_init();
 
-	platform_setup(cmdline_p);
+	platform_setup((void *) 0);
 	paging_init();
 }
 
