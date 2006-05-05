Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWEEVtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWEEVtB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 17:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWEEVtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 17:49:01 -0400
Received: from ms-smtp-02.socal.rr.com ([66.75.162.134]:10446 "EHLO
	ms-smtp-02.socal.rr.com") by vger.kernel.org with ESMTP
	id S1750791AbWEEVtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 17:49:00 -0400
Message-Id: <6.2.3.4.0.20060505144445.03642988@pop-server.san.rr.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.3.4
Date: Fri, 05 May 2006 14:48:04 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
From: John Coffman <johninsd@san.rr.com>
Subject: Re: [PATCH][TAKE 4] THE LINUX/I386 BOOT PROTOCOL - Breaking 
  the 256 limit
Cc: Alon Bar-Lev <alon.barlev@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Barry K. Nathan" <barryn@pobox.com>, Adrian Bunk <bunk@fs.tum.de>,
       tony.luck@intel.com
In-Reply-To: <445B96D2.9070301@zytor.com>
References: <445B5524.2090001@gmail.com>
 <445B5C92.5070401@zytor.com>
 <445B610A.7020009@gmail.com>
 <445B62AC.90600@zytor.com>
 <6.2.3.4.0.20060505110517.036df928@pop-server.san.rr.com>
 <445B96D2.9070301@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0618-3, 05/05/2006), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:17 AM  Friday 5/5/2006, you wrote:
>John Coffman wrote:
>The problem isn't that LILO can't handle more than some number of 
>characters; that's a LILO issue and doesn't affect the kernel.
>
>The problem is that some people have reported that the kernel 
>crashes if booted with LILO and the size limit is more than 
>255.  They haven't so far commented on how they observed that, and 
>that's a major problem.

Just re-compiling LILO with the  COMMAND_LINE_SIZE  parameter changed 
from 256 to 512 will not work.  A .bss area must be moved to avoid 
clobbering the kernel header.


>If the issue is that LILO doesn't null-terminate overlong command 
>lines, then that's pretty easy to deal with:
>
>- If the kernel sees protocol version <= 2.01, limit is 255+null.
>- If the kernel sees protocol version >= 2.02, but ID is 0x1X, limit 
>is 255+null.
>- Otherwise limit is higher.
>
>When LILO is fixed, it has to bump the ID byte version number.
>
>What ID byte values has LILO used?

For the last 8 years LILO has used 0x02 as the loader ID.

If anyone wishes to test a version of LILO that is able to pass a 512 
byte command line, then the "22.7.2-beta8" version in the "beta" 
directory should be tried.  It moves the offending ".bss" area to 
avoid the header clobber.  However, I have not yet changed the loader ID.

--John



         PGP KeyID: 6781C9C8  (good until 31-Dec-2008)
         Keyserver at  ldap://keyserver.pgp.com  OR  http://pgp.mit.edu
         LILO links at http://freshmeat.net/projects/lilo
         and Help link at http://lilo.go.dyndns.org


