Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132215AbRBDT5s>; Sun, 4 Feb 2001 14:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132244AbRBDT5j>; Sun, 4 Feb 2001 14:57:39 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:2564 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S132217AbRBDT5f>;
	Sun, 4 Feb 2001 14:57:35 -0500
Message-ID: <3A7DB3AD.8A2E996E@sgi.com>
Date: Sun, 04 Feb 2001 11:55:25 -0800
From: LA Walsh <law@sgi.com>
Organization: Trust Technology, SGI
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.4.1 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: System unresponsitive when copying HD/HD
In-Reply-To: <E14PMvB-0001Mq-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> But try 2.4.1 before worrying too much. That fixed a lot of the block
> performance problems I was seeing (2.4.1 ruins the VM performance under paging
> loads but the I/O speed is fixed ;))

---
	Seems to have gotten a bit worse.  Vmstat output after 'vmware' had completed
write -- but system unresponsive and writing out a 155M file...

 1  0  0      0 113960  47528 277152   0   0     0     0  397   861   1  24  75
 1  0  0      0 114060  47560 277152   0   0     4   350  432  1435   4  17  79
 0  0  1      0 127380  47560 266196   0   0     0   516  216   435   7   3  90
 1  0  1      0 127380  47560 266196   0   0     0   240  203   173   0   1  99
 0  0  1      0 127380  47560 266196   0   0     0   434  275   180   0   2  98
 1  0  1      0 127376  47560 266196   0   0     0   218  204   173   0   2  98
 0  0  1      0 127376  47560 266196   0   0     0   288  203   174   0   0 100
 0  0  1      0 127376  47560 266196   0   0     0   337  230   176   0   1  99
 0  0  1      0 127376  47560 266196   0   0     0   267  241   177   0   1  99
 0  0  1      0 127376  47560 266196   0   0     0   210  204   173   0   1  99
 0  0  1      0 127376  47560 266196   0   0     0   204  203   173   0   1  99
 0  0  1      0 127376  47560 266196   0   0     0   216  212   250   0   1  99
 0  0  1      0 127376  47560 266196   0   0     0   208  205   172   0   2  98
 0  0  1      0 127372  47560 266196   0   0     0   225  203   160   0   2  98
 0  0  1      0 127372  47560 266196   0   0     0   316  214   212   0   1  99
 1  0  1      0 127144  47560 266196   0   0     0   281  218   304   1   2  96
 0  0  0      0 127144  47560 266196   0   0     0     1  161   240   1   0  99
 0  0  0      0 127144  47560 266196   0   0     0     0  101   232   0   1  99 
---
	What is the meaning of having a process in the 'w' column?  On other
systems, I was used to that meaning an executable had been *swapped* out completely
(as opposed to no pages mapped in) and that it meant your system vm was 'thrashing'.
But that obviously isn't the case here.

	Those columns are output from a 'vmstat 5'.  Meaning it took about 70 seconds
to write out 158M.  Or about 2.2M/s.  That's probably not bad.  It still locks
up the system for over a minute though -- which is really undesirable performance
for interactive use.  I'm guessing the vmstat output numbers are showing 4K? 8K? 
blocks?  8K would about make sense for the 2.2M average.

-- 
Linda A Walsh                    | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
