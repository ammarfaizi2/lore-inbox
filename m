Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263044AbUCMEzH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 23:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263046AbUCMEzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 23:55:07 -0500
Received: from gate.crashing.org ([63.228.1.57]:20441 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263044AbUCMEzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 23:55:03 -0500
Subject: Re: [PATCH] ppc32 copy_to_user dcbt fixup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bryan Rittmeyer <bryan@staidm.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <20040313041547.GB11512@staidm.org>
References: <20040313041547.GB11512@staidm.org>
Content-Type: text/plain
Message-Id: <1079153403.2348.82.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 13 Mar 2004 15:50:03 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> [1] csum_partial_copy_generic does not use dcbt/dcbz despite being
> scorching hot in TCP workloads. I'm cooking up another patch to
> dcb?ize it.
> 
> [2] http://staidm.org/linux/ppc/copy_dcbt/copyuser-microbench.tar.bz2

I'll have a good look at it asap. Also, keep in mind that between the
dcbz and the time you can actually write to that cache line, some CPUs
may need some time to complete the L1 dcbz operation, which can lead
to poor performances, at least I've been told this is the case on
POWER3, maybe others. It would be wise to make the dcbz as long as
possible in "advance" before the actual write to the cache line.

Ben.


