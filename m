Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268828AbUJEGGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268828AbUJEGGJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 02:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268824AbUJEGGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 02:06:09 -0400
Received: from adsl-65-68-135-106.dsl.stlsmo.swbell.net ([65.68.135.106]:8104
	"EHLO ramius.hardwarefreak.com") by vger.kernel.org with ESMTP
	id S268828AbUJEGGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 02:06:04 -0400
Message-ID: <65717CC11CAED4118C1100A02401ECAA072C75@RAMIUS>
From: Stan Hoeppner <stan@hardwarefreak.com>
To: "'Paul Jackson'" <pj@sgi.com>, "Martin J. Bligh" <mbligh@aracnet.com>
Cc: pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: RE: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
	 memory placement
Date: Tue, 5 Oct 2004 01:05:53 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Lindsley wrote:
Will cpus in exclusive cpusets be asked to service interrupts?

Paul Jackson wrote:
Let's take my big 256 CPU system, divided into portions of 128, 64 and
64. At this level, these are three, mutually exclusive cpusets, and
interaction between them is minimized.  In the first two portions, the
128 and the first 64, a couple of "company jewel" applications run.
These are highly tuned, highly parallel applications that are sucking up
99% of every CPU cycle, bus cycle, cache line and memory page available,
for hours on end, in a closely synchronized dance.  They cannot tolerate
anything else interfering in their area.  Frankly, they have little use
for CKRM, fancy schedulers or sophisticated allocators.  They know
what's there, it's all their's, and they know exactly what they want to
do with it.  Get out of the way and let them do their job.  Industrial
strength computing at its finest.


In Paul's example 256 Altix system here, there are 3 cpusets.  Assuming each
cpuset will consist of:
128 / 4 = 32 C-bricks
64  / 4 = 16 C-bricks
64  / 4 = 16 C-Bricks

Which C-bricks have P-bricks (PCI-X I/O) attached to them, and to which
P-bricks are the Gig-E cards and PCI-X fiber channel cards with TP9500 disk
arrays attached?  And thus, where is the network and disk I/O interrupt load
concentrated?  I would assume that all the network I/O will be on a single
"Interactive" C-brick (4 CPUs = 2 NUMA nodes).  In which cpuset are the
fiber channel cards/disk arrays concentrated?  Or are they physically spread
out evenly across the entire system for balance?  Does the system even use
"local" storage, or will there be a few C-bricks/nodes with P-bricks and
many fiber channel cards that talk to a CXFS SAN host?

If all the I/O is concentrated in one of these 3 cpusets, then it would make
sense to "lock" I/O interrupts to CPUs within that cpuset.  Additionally, if
a user is running an application in one of the *other* cpusets and he/she
needs "guaranteed rate I/O", I can see where something like the CKRM
framework would be needed within the "I/O heavy" cpuset.  So maybe CKRM
within a cpuset could assist in getting something like the IRIX XFS GRIO
feature into Altix?

Stan Hoeppner
TheHardwareFreak
stan@hardwarefreak.com
