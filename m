Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030594AbWJCWHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030594AbWJCWHw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030599AbWJCWHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:07:52 -0400
Received: from us01smtp1.synopsys.com ([198.182.44.79]:25515 "EHLO
	boden.synopsys.com") by vger.kernel.org with ESMTP id S1030596AbWJCWHu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:07:50 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: System hang problem.
Date: Tue, 3 Oct 2006 15:07:52 -0700
Message-ID: <C9A861D62D068643A0F4A7B1BCB38E2C0327B5A0@US01WEMBX1.internal.synopsys.com>
Thread-Topic: System hang problem.
Thread-Index: AcbnOF7IPNQ9hELCRKG8xOeXVR314w==
From: "Manish Neema" <Manish.Neema@synopsys.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 03 Oct 2006 22:07:49.0378 (UTC) FILETIME=[5D28D620:01C6E738]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I've lost my patience with RedHat so posting here....

We see this problem frequently on RHEL3.0 U5 and U7. System would
completely hang upon memory shortage. The only option left is
power-cycle (or 'sysrq + b'). System hang occurs with any of the below 3
overcommit settings:

   - default (heuristic) overcommit (overcommit_memory=0) 
   - no overcommit handling by kernel (overcommit_memory=1)
   - restrictive overcommit with ratio=100% (overcommit_memory=2;
overcommit_ratio=100)

RHEL3.0 U3 would generate an OOM kill "each and every time" it sensed
system hang but due to other bugs, we had to move away from it. RedHat
calls the timely (at least for us) invocation of OOM in U3 a buggy
implementation and the delayed OOM kill in U5 and U7 the right
implementation (which we rarely get to see resulting in at least 5
systems hanging daily!)

Changing overcommit to 2 (and ratio to any where from 1 to 99) would
result in certain OS processes (automount daemon for e.g.) getting
killed when all the allowed memory is committed. What is the point in
reserving some memory if a random root process would get killed leaving
the system in a totally unknown state?

Any suggestions on how we can prevent system-hang + not have automount
(and any other root process) die? 

TIA,
-Manish Neema

P.S. Sorry, we cannot move away from RHEL3.0 U7 for a while.
