Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136815AbRECOGr>; Thu, 3 May 2001 10:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136817AbRECOGi>; Thu, 3 May 2001 10:06:38 -0400
Received: from [32.97.182.101] ([32.97.182.101]:43407 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S136815AbRECOGb>;
	Thu, 3 May 2001 10:06:31 -0400
Importance: Normal
Subject: Re: 2.4.4 sluggish under fork load
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: riel@conectiva.com.br, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFB42DB9D7.DD800F01-ON85256A41.004CE78D@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Thu, 3 May 2001 10:02:41 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.7 |March 21, 2001) at
 05/03/2001 10:05:58 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I pointed that out to the folk who proposed this and
gave him a fix that ensures that the child has at least a value of 2
higher.

Given the child all and the parent nothing is TOTAL BOGUS. The parent
essentially has to wait for a recalculate.
This so-called fix has to go in the next release.


Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



"Adam J. Richter" <adam@yggdrasil.com>@vger.kernel.org on 05/01/2001
12:18:10 AM

Sent by:  linux-kernel-owner@vger.kernel.org


To:   riel@conectiva.com.br
cc:   linux-kernel@vger.kernel.org
Subject:  Re: 2.4.4 sluggish under fork load



>The fact that 2.4.4 gives the whole timeslice to the child
>is just bogus to begin with.

        I only did that because I could not find another way
to make the child run first that worked in practice.  I tried
other things before that.  Since Peter Osterlund's SCHED_YIELD
thing works, we no longer have to give all of the CPU to the
child.  The scheduler time slices are currently enormous, so as
long as the child gets even one clock tick before the parent runs,
it should reach the exec() if that is its plan.  1 tick = 10ms = 10
million cycles on a 1GHz CPU, which should be enough time to encrypt
my /boot/vmlinux in twofish if it's in RAM.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite
104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



