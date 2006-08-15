Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965376AbWHOQFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965376AbWHOQFl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 12:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965380AbWHOQFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 12:05:40 -0400
Received: from mail.everytruckjob.com ([198.87.235.158]:57269 "EHLO
	mail.everytruckjob.com") by vger.kernel.org with ESMTP
	id S965376AbWHOQFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 12:05:40 -0400
Message-ID: <44E1F0CD.7000003@everytruckjob.com>
Date: Tue, 15 Aug 2006 11:05:33 -0500
From: Mark Reidenbach <m.reidenbach@everytruckjob.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How to find a sick router with 2.6.17+ and tcp_window_scaling enabled
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had made an earlier post concerning very poor network performance 
after upgrading to 2.6.17 and later kernels.  The solution provided by 
the e1000 developers was that it was in fact a change to the default tcp 
window scaling settings and that there was a router somewhere between my 
computer and its destination.

After scouring the net for many days trying to find an answer as to how 
to find the broken router, I've come up empty and there are many 
references as to why you don't want to disable window scaling completely 
which so far has been my only working solution.   Can anyone give 
instructions or references as to what the requirements are for a router 
to work (specifically Cisco routers)?  Is there a minimum required IOS 
or certain commands that must be enabled such as any of the following?
ip tcp window-size 8388480
ip tcp selective-ack
ip tcp timestamp

Does anyone have a way to find the broken router if you are not running 
the networks involved?  I'm almost positive it's our T1 provider, but 
after being on the phone with them for a couple hours they insist it's 
not their problem and that their routers are configured properly (what 
else would you expect them to say after all).  There are only 5 hops in 
the traceroute between us and a test file they have set.  Below is the 
traceroute info:

 1  192.168.13.1 (192.168.13.1)  0.319 ms  0.332 ms  0.245 ms
 2  nsc69.38.0-110.newsouth.net (69.38.0.110)  2.484 ms  2.107 ms  1.985 ms
 3  nsc69.38.3-17.newsouth.net (69.38.3.17)  6.612 ms  6.403 ms  5.986 ms
 4  66.64.228.106.nw.nuvox.net (66.64.228.106)  15.357 ms  14.885 ms  
15.353 ms
 5  virt4.rhetoric.nuvox.net (66.83.21.33)  14.982 ms  14.880 ms  15.102 ms

The only information I have on the routers is:
192.168.13.1:  This is our office router and is a Cisco 1811 running 
12.3(8)YI1.
69.38.0.110:   T1 provider's router installed at our office.
                 This is a Cisco 2600 series that I was told was running 
12.2(10)R
                 even though I can't find a 10R release on Cisco's website.


My computer has 2GB of ram if that helps since it seems the new defaults 
are based on system ram.

Below is the start of a tcpdump when trying to retrieve the test file 
from my T1 provider's server with tcp_window_scaling = 1.  I'm somewhat 
confused why performance drops from more than 225kB/s with window 
scaling disabled to less than 50kB/s with it enabled since it looks like 
the test server acks with a wscale of 0 and I thought that would have 
the same behavior as setting tcp_window_scaling to 0.

tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on eth0, link-type EN10MB (Ethernet), capture size 96 bytes
10:49:01.890275 IP backup.truckersexit.com.55805 > 
virt4.rhetoric.nuvox.net.http: S 906926812:906926812(0) win 5840 <mss 
1460,sackOK,timestamp 6583784 0,nop,wscale 7>
10:49:01.905118 IP virt4.rhetoric.nuvox.net.http > 
backup.truckersexit.com.55805: S 4149240349:4149240349(0) ack 906926813 
win 5792 <mss 1460,sackOK,timestamp 514424107 6583784,nop,wscale 0>
10:49:01.905128 IP backup.truckersexit.com.55805 > 
virt4.rhetoric.nuvox.net.http: . ack 1 win 46 <nop,nop,timestamp 6583786 
514424107>
10:49:01.905229 IP backup.truckersexit.com.55805 > 
virt4.rhetoric.nuvox.net.http: P 1:115(114) ack 1 win 46 
<nop,nop,timestamp 6583786 514424107>
10:49:01.920359 IP virt4.rhetoric.nuvox.net.http > 
backup.truckersexit.com.55805: . ack 115 win 5792 <nop,nop,timestamp 
514424109 6583786>
10:49:01.932477 IP virt4.rhetoric.nuvox.net.http > 
backup.truckersexit.com.55805: . 1:1449(1448) ack 115 win 5792 
<nop,nop,timestamp 514424109 6583786>
10:49:01.932484 IP backup.truckersexit.com.55805 > 
virt4.rhetoric.nuvox.net.http: . ack 1449 win 69 <nop,nop,timestamp 
6583789 514424109>
10:49:01.938473 IP virt4.rhetoric.nuvox.net.http > 
backup.truckersexit.com.55805: . 1449:2897(1448) ack 115 win 5792 
<nop,nop,timestamp 514424109 6583786>
10:49:01.938481 IP backup.truckersexit.com.55805 > 
virt4.rhetoric.nuvox.net.http: . ack 2897 win 91 <nop,nop,timestamp 
6583789 514424109>
10:49:01.956837 IP virt4.rhetoric.nuvox.net.http > 
backup.truckersexit.com.55805: P 2897:4345(1448) ack 115 win 5792 
<nop,nop,timestamp 514424111 6583789>
10:49:01.956843 IP backup.truckersexit.com.55805 > 
virt4.rhetoric.nuvox.net.http: . ack 4345 win 114 <nop,nop,timestamp 
6583791 514424111>
10:49:01.962834 IP virt4.rhetoric.nuvox.net.http > 
backup.truckersexit.com.55805: . 4345:5793(1448) ack 115 win 5792 
<nop,nop,timestamp 514424111 6583789>
10:49:01.962839 IP backup.truckersexit.com.55805 > 
virt4.rhetoric.nuvox.net.http: . ack 5793 win 137 <nop,nop,timestamp 
6583792 514424111>
10:49:01.968830 IP virt4.rhetoric.nuvox.net.http > 
backup.truckersexit.com.55805: . 5793:7241(1448) ack 115 win 5792 
<nop,nop,timestamp 514424112 6583789>
10:49:01.968835 IP backup.truckersexit.com.55805 > 
virt4.rhetoric.nuvox.net.http: . ack 7241 win 159 <nop,nop,timestamp 
6583792 514424112>
10:49:01.974952 IP virt4.rhetoric.nuvox.net.http > 
backup.truckersexit.com.55805: . 7241:8689(1448) ack 115 win 5792 
<nop,nop,timestamp 514424112 6583789>
10:49:01.974956 IP backup.truckersexit.com.55805 > 
virt4.rhetoric.nuvox.net.http: . ack 8689 win 182 <nop,nop,timestamp 
6583793 514424112>
10:49:01.981323 IP virt4.rhetoric.nuvox.net.http > 
backup.truckersexit.com.55805: . 8689:10137(1448) ack 115 win 5792 
<nop,nop,timestamp 514424114 6583791>
10:49:01.981327 IP backup.truckersexit.com.55805 > 
virt4.rhetoric.nuvox.net.http: . ack 10137 win 204 <nop,nop,timestamp 
6583793 514424114>
10:49:01.987319 IP virt4.rhetoric.nuvox.net.http > 
backup.truckersexit.com.55805: P 10137:11585(1448) ack 115 win 5792 
<nop,nop,timestamp 514424114 6583791>
10:49:01.987323 IP backup.truckersexit.com.55805 > 
virt4.rhetoric.nuvox.net.http: . ack 11585 win 227 <nop,nop,timestamp 
6583794 514424114>
10:49:01.993316 IP virt4.rhetoric.nuvox.net.http > 
backup.truckersexit.com.55805: . 11585:13033(1448) ack 115 win 5792 
<nop,nop,timestamp 514424114 6583792>
10:49:01.993320 IP backup.truckersexit.com.55805 > 
virt4.rhetoric.nuvox.net.http: . ack 13033 win 250 <nop,nop,timestamp 
6583795 514424114>
10:49:01.999437 IP virt4.rhetoric.nuvox.net.http > 
backup.truckersexit.com.55805: P 13033:14481(1448) ack 115 win 5792 
<nop,nop,timestamp 514424114 6583792>
10:49:01.999441 IP backup.truckersexit.com.55805 > 
virt4.rhetoric.nuvox.net.http: . ack 14481 win 272 <nop,nop,timestamp 
6583795 514424114>
10:49:02.005434 IP virt4.rhetoric.nuvox.net.http > 
backup.truckersexit.com.55805: . 14481:15929(1448) ack 115 win 5792 
<nop,nop,timestamp 514424115 6583792>
10:49:02.005438 IP backup.truckersexit.com.55805 > 
virt4.rhetoric.nuvox.net.http: . ack 15929 win 295 <nop,nop,timestamp 
6583796 514424115>
10:49:02.011306 IP virt4.rhetoric.nuvox.net.http > 
backup.truckersexit.com.55805: . 15929:17377(1448) ack 115 win 5792 
<nop,nop,timestamp 514424115 6583792> 


Please CC me on any replies as I'm not subscribed to the list.
-- 
Mark Reidenbach
EveryTruckJob.com
M.Reidenbach@EveryTruckJob.com
Phone: (205)722-9112

