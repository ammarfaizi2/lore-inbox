Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264881AbUEQC2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUEQC2o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 22:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbUEQC2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 22:28:44 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:11684 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S264881AbUEQC22
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 22:28:28 -0400
Date: Sun, 16 May 2004 19:28:16 -0700
From: Larry McVoy <lm@bitmover.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: Andrew Morton <akpm@osdl.org>, adi@bitmover.com, scole@lanl.gov,
       support@bitmover.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Message-ID: <20040517022816.GA14939@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Steven Cole <elenstev@mesatop.com>, Andrew Morton <akpm@osdl.org>,
	adi@bitmover.com, scole@lanl.gov, support@bitmover.com,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <200405132232.01484.elenstev@mesatop.com> <5.1.0.14.2.20040515130250.00b84ff8@171.71.163.14> <20040514204153.0d747933.akpm@osdl.org> <200405151923.41353.elenstev@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405151923.41353.elenstev@mesatop.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> renumber: can't read SCCS info in "SCCS/s.ChangeSet".

Be aware that how BK does I/O is with write() on the way out but with 
mmap on the way in.  The process which forked renumber has just written
the file and the renumber process is reading it with mmap.

If there are still any problems with mixing read/write and mmap then that
may be a prolem but I would have expected to see things start going 
wrong on a page boundary and the one core dump I saw was page aligned 
at the tail but not at the head, it started in the middle of the page.

I've told my team to drop this unless someone can show that it happens
on other kernels, this smells like a kernel bug to me, if it were a BK
bug we should have been getting hundreds of complaints by now.  We can
jump back on it if need be, let us know if you think it is a BK problem
after all.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
