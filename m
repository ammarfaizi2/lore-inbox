Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129273AbRBUCTY>; Tue, 20 Feb 2001 21:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129713AbRBUCTP>; Tue, 20 Feb 2001 21:19:15 -0500
Received: from external.zumanetworks.com ([64.161.185.13]:47097 "HELO
	external.zumanetworks.com") by vger.kernel.org with SMTP
	id <S129273AbRBUCS6>; Tue, 20 Feb 2001 21:18:58 -0500
Date: Tue, 20 Feb 2001 18:19:55 -0800
From: Nye Liu <nyet@zumanetworks.com>
To: linux-kernel@vger.kernel.org
Subject: Very high bandwith packet based interface and performance problems
Message-ID: <20010220181955.A1994@hobag.internal.zumanetworks.com>
Reply-To: spamnyet@nyet.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Things-That-Suck: Microsoft Corp.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I am working on a very high speed packet based interface but we are having
severe problems related to bandwidth vs cpu horsepower. enclosed is a part
of a summary. PLEASE cc responses directly to spamnyet@nyet.org

Thanks!!!

-- 
"Who would be stupid enough to quote a fictitious character?"
	-- Don Quixote

--AhhlLboLdkugWU4S
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <nyet@zumanetworks.com>
Received: from hobag.internal.zumanetworks.com (IDENT:root@hobag [10.1.1.19])
	by crab.internal.zumanetworks.com (8.10.2/8.10.2) with ESMTP id f1L22vw08982;
	Tue, 20 Feb 2001 18:02:57 -0800
Received: (from nyet@localhost)
	by hobag.internal.zumanetworks.com (8.9.3/8.9.3) id SAA01978;
	Tue, 20 Feb 2001 18:03:56 -0800
Date: Tue, 20 Feb 2001 18:03:56 -0800
From: Nye Liu <nyet@zumanetworks.com>
To: Peter Thommen <pthommen@zumanetworks.com>
Cc: support@mvista.com
Subject: SI/ppc performance issues.
Message-ID: <20010220180356.A1936@hobag.internal.zumanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-AntiVirus: scanned for viruses by AMaViS 0.2.0-pre6 (http://aachalon.de/AMaViS/)

Due to the limited horsepower of our ppc740 (as it has no cache) our
proprietary, 2 Gbit packet based interface is capable of overwhelming
the software throughput capabilities of the kernel. This congestion is
causing severe network performance issues in both UDP and TCP.  In UDP,
if the frame rate exceeds approximately 300Mbit (1500 byte packets),
the kernel usage goes to 100%, leaving no cpu power for user space
applications to even recieve frames, causing severe queuing packet
loss. In the TCP case, there seem to be constant acks from the kernel,
but most data never seems to make it to user space.

Inspecting the /proc/net/dev and /proc/net/snmp counters reveal no errors.

As a control, the private 10/100 ethernet interface is capable of
sustaining 100Mbits of unidirectional UDP and TCP trafic with no problems.

Similary, if a traffic policer is used to limit the load of the
proprietary high speed interface to approx. 200Mbits, there is no packet
loss in UDP. Since we lack a shaper, we can't test TCP reliably, as
the policer drops packets instead of shaping output. We can test this
qualitatively by artificially preventing the TCP source from sending
too quickly.. we can do this by loading the source cpu heavily. however,
results from this are mixed. We seem to be able to attain only approx.
50-60Mbits by this method.

Questions:

There are two options in the 2.0 kernel. One is "Cpu is too slow for
network" or something similar. A second (driver specific option) is a
flow control mechanism.

In 2.4, the first seems to be missing. The second is only available for
a few drivers (e.g. tulip)

What do these options do?

In 2.4, what is the recommended way of keeping a high speed interface
from overwhelming the kernel network queue (e.g. Gig ethernet)?

Does this affect user space programs (e.g. ftpd, apache, etc)?

If so, how?

What are the mechanisms by which the Linux kernel drops frames?

Which mechanisms are accompanied by statistics, and what are they.

Which mechanisms are NOT accompanied by statistics.

Why is the kernel acking a blocked TCP stream? (i.e. when a user space
TCP program is unable to read from a socket because it is not being
schedulued due to kernel cpu load)

(todd... please comment, as this is a prelim document for the problem
description)

-Nye

-- 
"Who would be stupid enough to quote a fictitious character?"
	-- Don Quixote

--AhhlLboLdkugWU4S--
