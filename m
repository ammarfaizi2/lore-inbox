Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264997AbUEVANO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbUEVANO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 20:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264592AbUEVAEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 20:04:55 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:34650 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264596AbUEUXsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:48:04 -0400
Message-ID: <40ADB062.8050005@yahoo.com.au>
Date: Fri, 21 May 2004 17:31:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: alexeyk@mysql.com, linuxram@us.ibm.com, peter@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Random file I/O regressions in 2.6 [patch+results]
References: <200405022357.59415.alexeyk@mysql.com>	<1084480888.22208.26.camel@dyn319386.beaverton.ibm.com>	<1084815010.13559.3.camel@localhost.localdomain>	<200405200506.03006.alexeyk@mysql.com>	<20040520145902.27647dee.akpm@osdl.org> <20040520152305.3dbfa00b.akpm@osdl.org>
In-Reply-To: <20040520152305.3dbfa00b.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Open questions are:
> 
> a) Why is 2.6 write coalescing so superior to 2.4?
> 
> b) Why is 2.6 issuing more read requests, for less data?
> 
> c) Why is Alexey seeing dissimilar results?
> 


Interesting. I am not too familiar with 2.4's IO scheduler,
but 2.6's have pretty comprehensive merging systems. Could
that be helping, Jens? Or is 2.4 pretty equivalent?

What about things like maximum request size for 2.4 vs 2.6
for example? This is another thing that can have an impact,
especially for writes.

I'll take a guess at b, and say it could be as-iosched.c.
Another thing might be that 2.6 has smaller nr_requests than
2.4, although you are unlikely to hid the read side limit
with only 16 threads if they are doing sync IO.

As for question c, has Alexey confirmed that it is indeed
2.6-bk which has problems?
