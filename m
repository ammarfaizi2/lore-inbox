Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVEKOqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVEKOqU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 10:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVEKOn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 10:43:57 -0400
Received: from smtp-ext-02.mx.pitdc1.expedient.net ([206.210.69.142]:36744
	"EHLO smtp-ext-02.mx.pitdc1.expedient.net") by vger.kernel.org
	with ESMTP id S261986AbVEKOlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 10:41:42 -0400
Message-ID: <42821A77.30301@psc.edu>
Date: Wed, 11 May 2005 10:45:11 -0400
From: Paul Nowoczynski <pauln@psc.edu>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: E1000 - page allocation failure - saga continues :( message 1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the problem is related to dma activity by the e1000 and the page 
cache hoarding
all the pages in the system.  I've been using min_free_kbytes to get 
around this - setting it
at 131072.  Even at that amount I still see the page_alloc errors, 
raising the limit to 262144
actually lowers the amount of memory the system reserves (to about 
90MB)!   I've seen this
on both 2.6.7 and recently 2.6.11. 

I'd like to see more control over the page cache.  My machine do tons of 
disk IO and really
I find it a waste that 1.8 GB of memory is sitting idle in the page 
cache, meanwhile the kernel
is unable to free it fast enough when the ethernet card needs to dma.

If I'm missing something please let me know.
paul

linuxkernel2.20.sandos@spamgourmet.com wrote:
 > Nick Piggin - nickpiggin@yahoo.com.au wrote:
 >
 >> linuxkernel2.20.sandos@spamgourmet.com wrote:

 >>> It would be nice with a "cleaner" solution though.
 >>>
 >>
 >> What kernel are you using?
 >> Are you doing a lot of block IO as well?
 >
 >
 > I am using 2.6.11.8.
 >
 > Yes, the server is a fileserver for both the internet (~10Mbit) and
 > internally (1Gbit e1000). Hardware is pretty old so is pretty heavily
 > loaded and with 256MB RAM.
 >

OK, well there are some patches in 2.6.12 that should make
things slightly better, and then some more patches in -mm
(not sure if they'll make it for 2.6.12) that should make
things slightly better again.

Basically they work towards reducing the memory allocation
"priority" for block IO requests, in relation to networking
and other atomic allocation requirements.

If you can't test the latest -mm, or 2.6.12-rc4, then wait
for 2.6.12 and 2.6.13 and check back on the problem.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

-
