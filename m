Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbTKVHOb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 02:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbTKVHOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 02:14:30 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:13029 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262072AbTKVHO1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 02:14:27 -0500
Message-ID: <3FBF0CCF.7060401@cyberone.com.au>
Date: Sat, 22 Nov 2003 18:14:23 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, John Hawkes <hawkes@sgi.com>
Subject: [PATCH][CFT] NUMA / SMP scheduler "improvements"
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,
I would like people to test my scheduler improvements if possible,
if you are interested in that sort of thing. Patch at:
http://www.kerneltrap.org/~npiggin/w22/

For those following my patches, the big thing in this release is
balancing backoff needed for the bigger boxes. I'm not sure how
this compares to your stuff John, and it probably isn't tuned too
well for all sizes of boxes.

I use a log(num_online_cpus()) function to scale the global balancing
interval, so this might not be appropriate. It also probably doesn't
do global balances quite enough for 1CPU/node boxes.

Benchmarks are generally as good or better, although idle time may
be up due to more conservative balancing and the backoff stuff.

The good metric is the number of tasks being pulled to another node
dbench pulls    72%
tbench pulls     0.28%
make -j         11.7%
hackbench       17%
reaim           56%

Number of local tasks pulled off CPU is generally down too
dbench    44%
tbench    71%
make -j   76%
hackbench 114%
reaim     100%

This is on osdl's 16 way NUMA (4x4). Testing on other platforms welcome.

Best regards,
Nick

