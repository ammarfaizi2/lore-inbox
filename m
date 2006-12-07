Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162927AbWLGSCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162927AbWLGSCu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 13:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162924AbWLGSCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 13:02:49 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51137 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162922AbWLGSCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 13:02:47 -0500
Date: Thu, 7 Dec 2006 10:01:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: David Howells <dhowells@redhat.com>,
       "Maciej W. Rozycki" <macro@linux-mips.org>,
       Roland Dreier <rdreier@cisco.com>,
       Andy Fleming <afleming@freescale.com>,
       Ben Collins <ben.collins@ubuntu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Export current_is_keventd() for libphy
In-Reply-To: <20061207095253.30059224.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612071000380.3615@woody.osdl.org>
References: <1165125055.5320.14.camel@gullible> <20061203011625.60268114.akpm@osdl.org>
 <Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
 <20061205123958.497a7bd6.akpm@osdl.org> <6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>
 <20061205132643.d16db23b.akpm@osdl.org> <adaac22c9cu.fsf@cisco.com>
 <20061205135753.9c3844f8.akpm@osdl.org> <Pine.LNX.4.64N.0612061506460.29000@blysk.ds.pg.gda.pl>
 <20061206075729.b2b6aa52.akpm@osdl.org> <Pine.LNX.4.64.0612060822260.3542@woody.osdl.org>
 <Pine.LNX.4.64.0612061719420.3542@woody.osdl.org> <20061206224207.8a8335ee.akpm@osdl.org>
 <Pine.LNX.4.64.0612070846550.3615@woody.osdl.org> <20061207095253.30059224.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Dec 2006, Andrew Morton wrote:
> 
> umm..  Putting a work_struct* into struct cpu_workqueue_struct and then
> doing appropriate things with cpu_workqueue_struct.lock might work.

Yeah, that looks sane. We can't hide anything in "struct work", because we 
can't trust it any more once it's been dispatched, but adding a pointer to 
the cpu_workqueue_struct that is only used to compare against another 
pointer sounds fine.

		Linus
