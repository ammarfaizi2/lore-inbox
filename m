Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbUB0Svc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262919AbUB0Svb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:51:31 -0500
Received: from hera.kernel.org ([63.209.29.2]:11214 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262908AbUB0SvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:51:22 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [BK PATCH] SCSI host num allocation improvement
Date: Fri, 27 Feb 2004 18:51:12 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c1o3j0$ir3$1@terminus.zytor.com>
References: <20040226235412.GA819@phunnypharm.org> <20040226171928.750f5f6f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1077907872 19300 63.209.29.3 (27 Feb 2004 18:51:12 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 27 Feb 2004 18:51:12 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040226171928.750f5f6f.akpm@osdl.org>
By author:    Andrew Morton <akpm@osdl.org>
In newsgroup: linux.dev.kernel
> 
> This allocate-me-the-lowest-available-number is a common idiom in the
> kernel and we really should do it better.  Seems we need to convert the
> dynamic pty allocation to do it as well - it has yet another open-coded
> ad-hoc allocator.
> 

Well, I actually *didn't* want it to be allocate-the-lowest-available
number.  I deliberately went with the same allocation scheme used for
PIDs (continual advance with wraparound and duplication avoidance);
this is a cheap approximation of NRU.

Immediate re-use is *BAD* (in the pty example, it means you're liable
to have "write" write to an unrelated session by mistake, for example)
at least if there is no penalty for expanding into the full allocated
number space.  Lowest available number is architecturally mandated for
file descriptors, but it doesn't mean it's a preferred allocation
scheme by any means.

	-hpa

