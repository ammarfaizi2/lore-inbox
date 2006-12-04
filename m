Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758915AbWLDHWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758915AbWLDHWd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 02:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758931AbWLDHWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 02:22:33 -0500
Received: from smtpout.mac.com ([17.250.248.174]:38124 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1758915AbWLDHWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 02:22:33 -0500
In-Reply-To: <200612040154.kB41sadx019068@ms-smtp-03.texas.rr.com>
References: <200612040154.kB41sadx019068@ms-smtp-03.texas.rr.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5E2B4840-C384-48E2-A5C2-ED3C84FA7A48@mac.com>
Cc: "'Tim Schmielau'" <tim@physik3.uni-rostock.de>,
       "'Andrew Morton'" <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: la la la la ... swappiness
Date: Mon, 4 Dec 2006 02:22:05 -0500
To: Aucoin@Houston.RR.com
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
X-Proofpoint-Virus-Version: vendor=fsecure engine=4.65.5446:2.3.11,1.2.37,4.0.164 definitions=2006-12-04_02:2006-12-01,2006-12-02,2006-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=3.1.0-0610180000 definitions=main-0612030026
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 03, 2006, at 20:54:41, Aucoin wrote:
> As a side note, even now, *hours* after the tar has completed and  
> even though I have swappiness set to 0, cache pressure set to 9999,  
> all dirty timeouts set to 1 and all dirty ratios set to 1, I still  
> have a 360+K inactive page count and my "free" memory is less than  
> 10% of normal.

The point you're missing is that an "inactive" page is a free page  
that happens to have known clean data on it corresponding to  
something on disk.  If you need to use the inactive page for  
something all you have to do is either zero it or fill it with data  
from elsewhere.  There is _no_ practical reason for the kernel to  
turn an "inactive" page into a "free" page.  On my Linux systems  
after heavy local-disk and network intensive read-only load I have no  
more than 2% "free" memory, most of the rest is "inactive" (in one  
case some 2GB of it).  There's nothing _wrong_ with that much  
"inactive" memory, it just means that you were using it for data at  
one point, then didn't need it anymore and haven't reused it since.

> I'm not pretending to understand what's happening here but  
> shouldn't some kind of expiration have kicked in by now and freed  
> up all those inactive pages?

Nope; the pages will continue to contain valid data until you  
overwrite them with new data somehow.  Now, if they were "dirty"  
pages, containing unwritten data, then you would be correct.

> The *instant* I manually push a "3" into drop_caches I have 100% of  
> my normal free memory and the inactive page count drops below 2K.  
> Maybe I completely misunderstood the purpose of all those dials but  
> I really did get the feeling that twisting them all tight would  
> make the housekeeping algorithms more aggressive.

In this case you're telling the kernel to go beyond its normal  
housekeeping and delete perfectly good data from memory.  The only  
reason to do that is usually to make benchmarks mildly more  
repeatable and doing it on a regular basis tends to kill performance.

Cheers,
Kyle Moffett

> [copy of long previous email snipped]

PS: No need to put a copy of the entire message you are replying to  
at the end of your post, it just chews up space.  If anything please  
quote inline immediately before the appropriate portion of your reply  
so we can get the gist, much as I have done above.


