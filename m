Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315536AbSGSCNZ>; Thu, 18 Jul 2002 22:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318301AbSGSCNZ>; Thu, 18 Jul 2002 22:13:25 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:61681 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315536AbSGSCNX>;
	Thu, 18 Jul 2002 22:13:23 -0400
Message-ID: <3D377654.5000100@us.ibm.com>
Date: Thu, 18 Jul 2002 19:15:48 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a+) Gecko/20020712
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: linux-kernel@vger.kernel.org, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: success with atomic kmap patches
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was using a little script to warm up my file cache for Specweb runs 
when Martin Bligh said that it might be a good test of your kmap 
patches.  I ran 8 greps in parallel (1-per-cpu) through a 10-gigabyte 
Specweb file set which is on a RAID array.  The RAID is how I can do a 
cold run in 3 minutes 30 sec :).  Each grep works on a disjoint set of 
data.

Here's a run with the cache already warm:
http://www.sr71.net/~specweb99/run-pgrepwarm-2.5.26+lm+kmapfun-07-18-2002-18.24.38/
You'll probably only care about greptime.total, and lockstat.  The 
network stuff is cruft from when I actually run Specweb.

Here's a cold cache run:
http://www.sr71.net/~specweb99/run-pgrep-cold-2.5.26+lm+kmapfun-07-18-2002-18.25.55/

Here are warm and cold, without the kmap patches
http://www.sr71.net/~specweb99/run-pgrep-cold-2.5.26+lm-07-18-2002-18.46.27/
http://www.sr71.net/~specweb99/run-pgrep-warm-2.5.26+lm-07-18-2002-18.56.09/

I would give you oprofile data, but it appears that NMIs wreak havoc 
on a certain vendor's hardware.  When oprofile is compiled in, my box 
gets quite unstable.
-- 
Dave Hansen
haveblue@us.ibm.com

