Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262926AbTDVDyB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 23:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTDVDyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 23:54:01 -0400
Received: from franka.aracnet.com ([216.99.193.44]:16054 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262926AbTDVDyA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 23:54:00 -0400
Date: Mon, 21 Apr 2003 21:06:03 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 67-mjb2 vs 68-mjb1 (sdet degredation)
Message-ID: <149490000.1050984362@[10.10.2.4]>
In-Reply-To: <147950000.1050981750@[10.10.2.4]>
References: <1425480000.1050959528@flay>
 <20030421144631.4987db46.akpm@digeo.com> <147950000.1050981750@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeah, that fixes it. Ho hum ... I wonder if we can find something that
> works well for both cases? I guess the options would be:
> 
> 1. Some way to make the rwlock mechanism itself faster.
> 2. Try to fix the contention itself somehow for this instance.
> 
> Not sure if 1 is fundamentally futile or not, but would obviously be
> better (more general) if it's possible ;-)

Hmmm. Actually seems like more of a "which test you pick" thing than a
machine thing. Maybe it's the balance of read / write accesses to the
rwlock that matters, or something.

time dd if=/dev/zero of=foo bs=1 count=1M

with backout:

real    0m4.302s
user    0m0.900s
sys     0m3.370s

With patch: 

real    0m4.016s
user    0m0.810s
sys     0m3.200s

So the patch helps that test at least. 

M.

