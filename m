Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbUCIRlo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 12:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbUCIRlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 12:41:44 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:64008 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S262073AbUCIRlh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 12:41:37 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Date: Tue, 9 Mar 2004 11:40:34 -0600
Message-ID: <45B36A38D959B44CB032DA427A6E106406F92DD3@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Thread-Index: AcQF+8zxd1bCzmPkSX2opkMVq7ovggAAGKpQ
From: "Bond, Andrew" <andrew.bond@hp.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Andrea Arcangeli" <andrea@suse.de>, "Ingo Molnar" <mingo@elte.hu>
Cc: "Arjan van de Ven" <arjanv@redhat.com>,
       "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Mar 2004 17:41:21.0261 (UTC) FILETIME=[BC0649D0:01C405FD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Martin J. Bligh
> Sent: Tuesday, March 09, 2004 12:23 PM
> To: Andrea Arcangeli; Ingo Molnar
> Cc: Arjan van de Ven; Linus Torvalds; Andrew Morton; linux-
> kernel@vger.kernel.org
> Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid
4:4
> in <=16G machines)
> 
> > what is your point, that OASB is a worthless workload and the only
thing
> > that matters is TPC-C? Maybe you should discuss your point with
Oracle
> > not with me, since I don't know what the two benchmarks are doing
> > differently. TCP-C was tested too of course, but maybe not in 32G
boxes,
> > frankly I thought OASB was harder than TCP-C, as I think Martin
> > mentioned too two days ago.
> 
> OASB seems harder on the VM than TPC-C, yes. It seems to create
thousands
> of processes, and fill the user address space up completely as well
(2GB
> shared segments or whatever).
> 
> M.
> 

Both the OASB and TPC-C workloads put pressure on the VM subsystem, but
in different ways.

The OASB environment has a small (compared to TPC-C) shared memory area,
but 1000's of Oracle user processes will be created that attach to this
shared memory area.  The goal here is to push the maximum amount of
users onto the server.

The TPC-C environment will have a very large shared memory area
(typically the maximum a machine will allow) that may generate a large
number of vmas.  However, there are very few (may be few hundred) Oracle
users processes.

Experience has been that the OASB benchmarks will tend to push VM into
system lockup conditions more than TPC-C.

Andy
