Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264296AbUAIWmi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 17:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264323AbUAIWmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 17:42:38 -0500
Received: from mail1.nmu.edu ([198.110.192.44]:3598 "EHLO mail1.nmu.edu")
	by vger.kernel.org with ESMTP id S264296AbUAIWmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 17:42:35 -0500
Message-ID: <3FFF3931.4030202@nmu.edu>
Date: Fri, 09 Jan 2004 18:28:49 -0500
From: Randy Appleton <rappleto@nmu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Unneeded Code Found??
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I have found some useless code in the Linux kernel
in the block request functions.
                                                                                         
 
I have modified the __make_request function in ll_rw_blk.c.
Now every request for a block off the hard drive is logged.
                                                                                         
 
The function __make_request has code to attempt to merge the current
block request with some contigious existing request for better
performance. This merge function keeps a one-entry cache pointing to the
last block request made.  An attempt is made to merge the current
request with the last request, and if that is not possible then
a search of the whole queue is done, looking at merger possibililites.
                                                                                         
 
Looking at the data from my logs, I notice that over 50% of all requests
can be merged.  However, a merge only ever happens between the
current request and the previous one.  It never happens between the
current request and any other request that might be in the queue (for
more than 50,000 requests examined).
                                                                                         
 
This is true for several test runs, including "daily usage" and doing
two kernel compiles at the same time.  I have only tested on a
single-CPU machine.
                                                                                         
 
I wonder if the code (and CPU time) used to search the entire request
queue is actually useful.  Would this be a reasonable candidate for code
elimination?

-Much Thanks
-Randy Appleton
rappleto@nmu.edu


