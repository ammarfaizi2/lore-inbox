Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264481AbTLGScO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 13:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbTLGScO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 13:32:14 -0500
Received: from www.stereoconnection.CA ([216.16.235.58]:42121 "EHLO
	nic.NetDirect.CA") by vger.kernel.org with ESMTP id S264481AbTLGScN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 13:32:13 -0500
Date: Sun, 7 Dec 2003 13:32:01 -0500
From: Chris Frey <cdfrey@netdirect.ca>
To: Mark Symonds <mark@symonds.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 hard lock, 100% reproducible.
Message-ID: <20031207133201.A4744@netdirect.ca>
References: <20031207023650.GA772@symonds.net> <87he0ds3sv.fsf@ceramic.fifi.org> <02a901c3bc7b$69294ee0$7a01a8c0@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <02a901c3bc7b$69294ee0$7a01a8c0@gandalf>; from mark@symonds.net on Sat, Dec 06, 2003 at 08:34:32PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 06, 2003 at 08:34:32PM -0800, Mark Symonds wrote:
> Other than that, nothing.  Is there a patch out there 
> that will simply make 2.4.22 secure?  Things run great
> on that kernel. 

Here's the relevant section from patch-2.4.23

- Chris


diff -urN linux-2.4.22/mm/mmap.c linux-2.4.23/mm/mmap.c
--- linux-2.4.22/mm/mmap.c      2003-06-13 07:51:39.000000000 -0700
+++ linux-2.4.23/mm/mmap.c      2003-11-28 10:26:21.000000000 -0800
@@ -1041,6 +1041,9 @@
        if (!len)
                return addr;

+       if ((addr + len) > TASK_SIZE || (addr + len) < addr)
+               return -EINVAL;
+
        /*
         * mlock MCL_FUTURE?
         */

