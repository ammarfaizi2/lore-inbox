Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262993AbTDNNNU (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 09:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbTDNNNU (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 09:13:20 -0400
Received: from ms-smtp-03.tampabay.rr.com ([65.32.1.41]:65000 "EHLO
	ms-smtp-03.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S262993AbTDNNNS (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 09:13:18 -0400
Message-ID: <001301c3028a$25374f30$6801a8c0@epimetheus>
From: "Timothy Miller" <tmiller10@cfl.rr.com>
To: <linux-kernel@vger.kernel.org>
Cc: <nicoya@apia.dhs.org>
Subject: Re: Quick question about hyper-threading (also some NUMA stuff)
Date: Mon, 14 Apr 2003 09:31:24 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony 'Nicoya' Mantler (nicoya@apia.dhs.org)



> Perhaps the same effect could be obtained by preferentially scheduling
processes
> to execute on the "node" (a node being a single cpu in an SMP system, or
an HT
> virtual CPU pair, or a NUMA node) that they were last running on.


> I think the ideal semantics would probably be something along the lines
of:


>  - a newly fork()ed thread executes on the same node as the creating
thread
>  - calling exec() sets a "feel free to shuffle me elsewhere" flag
>  - threads are otherwise only shuffled to other nodes when a certain load
ratio
> is exceeded (current-node:idle-node)


This sounds like the most sensible approach.  I like considering the
extremes of performance, but sometimes, the time for math required for some
optimization can be worse than any benefit you get out of it.  Your
suggestion is simple.  It increases the likelihood (10% better for little
extra effort is better than 10% worse) of related processes being run on the
same node, while not impacting the system's ability to balance load.  This,
as you say, is also very important for NUMA.



Does the NUMA support migrate pages to the node which is running a process?
Or would processes jump nodes often enough to make that not worth the
effort?



In order for page migration to be worth it, node affinity would have to be
fairly strong.  It's particularly important when a process maps pages which
belong to another node.  Is there any logic there to duplicate pages in
cases where there is enough free memory for it?  We'd have to tag the pages
as duplicates so the VM could reclaim them.





