Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbTKDUdQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 15:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbTKDUdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 15:33:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:47545 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262461AbTKDUdP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 15:33:15 -0500
Date: Tue, 4 Nov 2003 12:30:23 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
cc: Paul Venezia <pvenezia@jpj.net>, <linux-kernel@vger.kernel.org>
Subject: Re: ext3 performance inconsistencies, 2.4/2.6
In-Reply-To: <20031104202037.GB30612@ti19.telemetry-investments.com>
Message-ID: <Pine.LNX.4.44.0311041227180.20373-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Nov 2003, Bill Rugolsky Jr. wrote:
> 
> Unless bonnie++ is using the _unlocked() variants, it might be an issue of
> the mutex overhead from NPTL v. LinuxThreads.  Red Hat 9 has its share
> of NPTL bugs.

Hmm.. That would easily explain the differences, since NPTL will trigger 
both on 2.6.0 and the RH-2.4 kernel, but not on the standard 2.4.22 
kernel.

But there really should be zero contention on the stdio data structures, 
so the locking would have to be _seriously_ broken to make that kind o 
fdifference (not necessarily buggy, but seriously badly implemented). 

A non-contended lock should be at most one locked instruction if well 
done, both on LinuxThreads and NPTL.

> It is probably worth rerunning the tests with LD_ASSUME_KERNEL=2.4.1 on
> the Red Hat kernel.

That would be interesting.

		Linus

