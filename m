Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752045AbWCFTvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbWCFTvu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWCFTvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:51:50 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:49469 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1752045AbWCFTvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:51:49 -0500
Date: Mon, 6 Mar 2006 11:51:35 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Daniel Phillips <phillips@google.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com
Subject: Re: [Ocfs2-devel] Ocfs2 performance bugs of doom
Message-ID: <20060306195135.GB27280@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <4408C2E8.4010600@google.com> <20060303233617.51718c8e.akpm@osdl.org> <440B9035.1070404@google.com> <20060306025800.GA27280@ca-server1.us.oracle.com> <440BC1C6.1000606@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440BC1C6.1000606@google.com>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2006 at 08:59:50PM -0800, Daniel Phillips wrote:
> So that hack apparently improves the bucket distribution quite a bit, but
> look, the bad old linear systime creep is still very obvious.  For that
> there is no substitute for lots of buckets.
Yes, I think the way to go right now is to allocate an array of pages and
index into that. We can make the array size a mount option so that the
default can be something reasonable ;)

> Speaking of that, the qstr is so far away from the list.next pointer that
> you're most probably getting an extra cache line load there too. Just move
> the qstr up next to the hash list.
Ahh, good catch.

> Notice, those wildly gyrating real times are still manifesting.  Seen
> them over there?
Yes - times from a test run are below.

    Real  User  Sys
   14.35 3.82 11.99
   16.75 3.62 13.90
   32.12 4.06 15.81
   18.94 3.99 16.69 
   35.18 3.96 15.80
   18.66 3.89 16.44
   52.09 4.24 16.66
   21.25 3.85 17.09
   19.73 4.00 17.20
   35.40 3.88 16.60

So this definitely reproduces elsewhere.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
