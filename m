Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWEESUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWEESUr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 14:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWEESUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 14:20:47 -0400
Received: from terminus.zytor.com ([192.83.249.54]:22763 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751203AbWEESUq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 14:20:46 -0400
Message-ID: <445B96D2.9070301@zytor.com>
Date: Fri, 05 May 2006 11:17:54 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: John Coffman <johninsd@san.rr.com>
CC: Alon Bar-Lev <alon.barlev@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Barry K. Nathan" <barryn@pobox.com>, Adrian Bunk <bunk@fs.tum.de>,
       Riley@Williams.Name, tony.luck@intel.com
Subject: Re: [PATCH][TAKE 4] THE LINUX/I386 BOOT PROTOCOL - Breaking  the
 256 limit
References: <445B5524.2090001@gmail.com> <445B5C92.5070401@zytor.com> <445B610A.7020009@gmail.com> <445B62AC.90600@zytor.com> <6.2.3.4.0.20060505110517.036df928@pop-server.san.rr.com>
In-Reply-To: <6.2.3.4.0.20060505110517.036df928@pop-server.san.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Coffman wrote:
> It is probably fairly easy to increase the LILO command line to 512 
> bytes (including terminator).  Beyond 512 there are complicating factors:
> 
> 1.  "lilo -R ..." -- the space reserved for the stored command line is 1 
> sector.
> 2.  configuration option "fallback" -- again 1 sector is the amount 
> reserved.
> 
> There are 2 buffers used for the command line.  Since these are 
> allocated on sector boundaries, 512 should present no serious problems.
> 

The problem isn't that LILO can't handle more than some number of characters; that's a 
LILO issue and doesn't affect the kernel.

The problem is that some people have reported that the kernel crashes if booted with LILO 
and the size limit is more than 255.  They haven't so far commented on how they observed 
that, and that's a major problem.

If the issue is that LILO doesn't null-terminate overlong command lines, then that's 
pretty easy to deal with:

- If the kernel sees protocol version <= 2.01, limit is 255+null.
- If the kernel sees protocol version >= 2.02, but ID is 0x1X, limit is 255+null.
- Otherwise limit is higher.

When LILO is fixed, it has to bump the ID byte version number.

What ID byte values has LILO used?

	-hpa

