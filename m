Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWBXUGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWBXUGw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWBXUGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:06:52 -0500
Received: from mail.atl.external.lmco.com ([192.35.37.50]:25005 "EHLO
	enterprise.atl.lmco.com") by vger.kernel.org with ESMTP
	id S932168AbWBXUGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:06:51 -0500
Message-ID: <43FF675A.6080305@atl.lmco.com>
Date: Fri, 24 Feb 2006 15:06:50 -0500
From: Gautam H Thaker <gthaker@atl.lmco.com>
Organization: Lockheed Martin -- Advanced Technology Laboratories
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, gautam.h.thaker@lmco.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~5x greater CPU load for a networked application when using 2.6.15-rt15-smp
 vs. 2.6.12-1.1390_FC4
References: <43FE134C.6070600@atl.lmco.com> <20060223205851.GA24321@elte.hu> <20060224041145.5bcdbc97.akpm@osdl.org>
In-Reply-To: <20060224041145.5bcdbc97.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Ingo Molnar <mingo@elte.hu> wrote:
> 
>>To figure out the true overhead of both kernels, could you try the 
>> attached loop_print_thread.c code

> http://www.zip.com.au/~akpm/linux/#zc  <- better ;)

Andrew,

I read the README for the "zc" tests. I wish Ingo can opine on which may be a
better test. Also, i assume that I can run "zcs" and "zcc" on the same
machine. I would do the tests with "send" instead of "sendfile".

I also have some other test data. The graphical summary result can be viewed
at this link:

http://www.atl.external.lmco.com/projects/QoS/LM_ATL_MW_Comparator_7920.png

In these tests I used a single Intel Xeon 3GH dual processor machine with 4
different kernels, all based on 2.6.14

2.6.14              Uniprocessor kernel
2.6.14-rt22         Uniprocessor kernel w/ RT patches
2.6.14-smp          SMP kernel
2.6.14-rt22-smp     SMP kernel w/ RT patches.


The test is similar to "zcs", "zcc" tests. In my tests a client process opens
a TCP connection to the server process (all on same machine) and sends to it
10,000,000 messages of sizes 4 bytes, 8 bytes, 16 bytes, .... , 32Kbytes,
64Kbytes. The server sends back a 1 byte reply. The client measures roundtrip
latencies. The graphic shows mean roundtrip latencies. Since measuremnts are
taken over so many samples I believe that the large differences in mean
latencies capture the relative CPU consumption of various kernel. (This being
loopback there are no NIC card issues or otherwise.) One notices a 3:1 ration
here from uniprocessor, non-RT kernel to SMP-RT kernel. The RT kernel has
nice real-time properties, and there is a lot of pressure in our systems to
use the SMP hardware of the multicore machines, and in some cases we can even
with with a 3x slowdown (since real applications do more than just I/O), but
when I started to note 5x (or more) in my newer tests I thought I would at
least post something.

I suspect that "zcs"/"zcc" tests would pretty much show the same conclusions
as this graphic.

Gautam H. Thaker
Distributed Processing Lab; Lockheed Martin Adv. Tech. Labs
3 Executive Campus; Cherry Hill, NJ 08002
856-792-9754, fax 856-792-9925  email: gthaker@atl.lmco.com
