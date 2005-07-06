Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262207AbVGFTTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbVGFTTs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbVGFTTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:19:48 -0400
Received: from unthought.net ([212.97.129.88]:16569 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S262299AbVGFOFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 10:05:17 -0400
Date: Wed, 6 Jul 2005 16:05:16 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Rob Prowel <tempest766@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: please remove reserved word "new" from kernel headers
Message-ID: <20050706140515.GM422@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Rob Prowel <tempest766@yahoo.com>, linux-kernel@vger.kernel.org
References: <20050706092657.95280.qmail@web60012.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050706092657.95280.qmail@web60012.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 02:26:57AM -0700, Rob Prowel wrote:
> [1.] One line summary of the problem:    
> 
> 2.4 and 2.6 kernel headers use c++ reserved word "new"
> as identifier in function prototypes.

Correction:

[1.] One line summary of problem:

Userspace application is making use of private kernel headers.

> 
> [2.] Full description of the problem/report:
> 
> When kernel headers are included in compilation of c++
> programs the compile fails because some header files
> use "new" in a way that is illegal for c++.  This
> shows up when compiling mySQL under linux 2.6.  It
> uses $KERNELSOURCE/include/asm-i386/system.h.

Corrected:

[2.] Full description of the problem/report:

When userspace applications include headers they shouldn't, all kinds of
problems can appear. One example of this shows up when compiling mySQL
under linux 2.6.  It uses $KERNELSOURCE/include/asm-i386/system.h.

...
> While not an error, per se, it is kind of sloppy and
> it is amazing that it hasn't shown up before now. 

It has shown up, and it has been discussed. Search the archives. I'm
pretty sure the exact problem you're reporting was discussed here a few
months back.

> using the identifier "new" in kernel headers that are
> visible to applications programs is a bad idea.

Noone's doing that. Because the headers aren't meant to be visible.

This is not a C vs. C++ problem and it has nothing to do with
'sloppiness'. Something much subtler could have happened had it been C
application code which would have parsed cleanly but just broken in
strange ways (due to assumptions in kernel header code which just happen
to not be met in the userspace code). Actually, you should be greatful
someone used 'new' - at least now the error is caught at compile time ;)

It should be simple to fix MySQL to keep it's dirty little fingers off
of the kernel's private parts..

Really, that is the solution.

Take a look at *what* MySQL is doing with the header. If it is the same
problem (I have not double checked, but I guess chances are good) as was
reported earlier, it's really just a small braindamage in MySQL which is
easily fixed (thus removing the need for inclusion of the header in
question).

-- 

 / jakob

