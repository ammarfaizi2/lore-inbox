Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268384AbTBYW1U>; Tue, 25 Feb 2003 17:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268385AbTBYW1T>; Tue, 25 Feb 2003 17:27:19 -0500
Received: from air-2.osdl.org ([65.172.181.6]:5768 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268384AbTBYW1R>;
	Tue, 25 Feb 2003 17:27:17 -0500
Message-Id: <200302252237.h1PMbWe07624@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Andrew Morton <akpm@digeo.com>
cc: Cliff White <cliffw@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, dmccr@us.ibm.com
Subject: 2.5.62-mm3 -DBT2 (was) Re: 2.5.62-mm3 -Panics during dbt2 run 
In-Reply-To: Message from Andrew Morton <akpm@digeo.com> 
   of "Tue, 25 Feb 2003 11:12:15 PST." <20030225111215.27c14ac7.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Feb 2003 14:37:32 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Cliff White <cliffw@osdl.org> wrote:
> >
> > 
> > Tried hard to test this, but all it does for me is panic.
> > Is this fixed in 2.5.63?
> > This is 4-way PIII system. 
> >  panic, while booting
> > Press Y within 1 seconds to force file system integrity check...
> >  [<c02409e8>] as_next_request+0x38/0x50
> 
> We have some rough edges in the anticipatory scheduler.  Please
> boot with elevator=deadline for now.
> 
That was the ticket. Runs DBT2 fine now. 
Detailed results for 2.5.62-mm3 w/plm-1592 (flock)
http://www.osdl.org/archive/cliffw/flock/mm3/index.html

I didn't have profiling turned on for this run. will be doing
a few more runs to get profile data. 

The results are a very tiny bit faster than 2.5.62 stock. 
(TPM change < 10% ) 

VMstat looks a bit different. a quick snap below.

2.5.62 - stock (+ plm-1592)

   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 5  0  0    280 151340  29292 1396592    0    0   159 12443 1891  5497 95  4  1
 4  0  0    280 145564  29536 1396976    0    0   193  1000 1149  3412 95  2  3
 5  1  0    280 136972  29884 1397376    0    0   192  1036 1153  3554 95  2  3
 5  0  0    280 129044  30116 1397764    0    0   178  1042 1152  3479 95  2  3
 5  0  0    280 122260  30344 1398140    0    0   153  1011 1145  3356 95  2  3
 5  1  0    280 114968  30576 1398520    0    0   153  1023 1146  3426 95  2  3
 4  0  0    280 108252  30808 1398908    0    0   149  1007 1144  3340 95  2  3
 4  0  0    280 101416  31140 1399300    0    0   133  1038 1147  3444 95  2  3

2.5.62-mm3 (+ plm-1592)

   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 7  1  0    980  10296  25656 1528952    0    0   207  1123 1259  3741 94  3  3
 6  2  0    980   9592  25752 1521964    0    0   190  1116 1256  3673 94  3  3
 5  2  0    980   9848  25912 1514212    0    0   177  1117 1255  3641 94  3  3
 6  1  0    980  13368  26040 1504004    0    0   157  1128 1253  3779 94  3  3
 6  1  0    980   9912  26164 1501048    0    0   145  1107 1249  3606 94  3  3
 6  1  0    980   9656  26244 1494832    0    0   151  1134 1253  3721 95  3  2
 7  2  0    980   9896  26296 1487988    0    0   144  1139 1253  3761 94  3  3
12  9  0    980  10176  26348 1480312    0    0   103 12019 1986  5867 94  5  1

----------------------
cliffw


