Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261725AbSJQSoQ>; Thu, 17 Oct 2002 14:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261744AbSJQSoQ>; Thu, 17 Oct 2002 14:44:16 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:61598 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261725AbSJQSoO>;
	Thu, 17 Oct 2002 14:44:14 -0400
Date: Thu, 17 Oct 2002 19:52:27 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Robin Holt <holt@sgi.com>
Cc: Dave Jones <davej@codemonkey.org.uk>, John Hesterberg <jh@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.43 CSA, Job, and PAGG
Message-ID: <20021017185227.GA3267@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Robin Holt <holt@sgi.com>, John Hesterberg <jh@sgi.com>,
	linux-kernel@vger.kernel.org
References: <20021017162140.GA26026@suse.de> <Pine.SGI.4.33.0210171249500.23137-100000@fsgi123.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.4.33.0210171249500.23137-100000@fsgi123.americas.sgi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 12:50:52PM -0500, Robin Holt wrote:

 > > The first two lines in the csa patch contain an obvious jiffy-wrap bug.
 > 
 > Fixed.  The patch file named above is now a link to
 > linux-2.5.43_002-csa.patch.  The old file is linux-2.5.43_001-csa.patch
 > 
 > If you could re-review, I would appreciate it.

Casting it to a ulong won't help you.
Imagine jiffies begins at 0xffffffff

	unsigned long start_wait = jiffies;
	...
	current->bwtime += (unsigned long) jiffies - start_wait;

and when you read it the second time, it's rolled over to 0x00000001

You now increment bwtime by $BIGNUM

-- 
| Dave Jones.        http://www.codemonkey.org.uk
