Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131626AbRDDTI1>; Wed, 4 Apr 2001 15:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131873AbRDDTIS>; Wed, 4 Apr 2001 15:08:18 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:57310 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S131626AbRDDTIL>;
	Wed, 4 Apr 2001 15:08:11 -0400
Importance: Normal
Subject: Re: a quest for a better scheduler
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFE7B61E08.EBBC35C3-ON85256A24.006740B8@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Wed, 4 Apr 2001 15:06:02 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.7 |March 21, 2001) at
 04/04/2001 03:06:57 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I give you a concrete example:

Running DB2 on an SMP system.

In DB2 there is a processes/thread pool that is sized based
on memory and numcpus. People tell me that the size of this pool
is in the order of 100s for an 8-way system with reasonable
sized database. These <maxagents> determine the number of agents
that can simultaneously execute an SQL statement.

Requests are flying in for transactions (e.g. driven by TPC-W like
applications). The agents are grepped from the pool and concurrently
fire the SQL transactions.
Assuming that there is enough concurrency in the database, there is
no reason to believe that the majority of those active agents is
not effectively running. TPC-W loads have observed 100 of active
transactions at a time.

Ofcourse limiting the number of agents would reduce concurrently
running tasks, but would limit the responsiveness of the system.
Implementing a database in the kernel ala TUX doesn't seem to be
the right approach either (complexity, fault containment, ...)

Hope that is one example people accept.

I can dig up some information on WebSphere Applications.

I'd love to hear from some other applications that fall into
a similar category as the above and substantiate a bit the need
for 100s of running processes, without claiming that the
application is broke.

Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



Mark Hahn <hahn@coffee.psychology.mcmaster.ca> on 04/04/2001 02:28:42 PM

To:   Hubertus Franke/Watson/IBM@IBMUS
cc:
Subject:  Re: a quest for a better scheduler



> ok if the runqueue length is limited to a very small multiple of the
#cpus.
> But that is not what high end server systems encounter.

do you have some example of this in mind?  so far, noone has
actually produced an example of a "high end" server that has
long runqueues.




