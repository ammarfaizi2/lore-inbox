Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVBTWbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVBTWbP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 17:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVBTWbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 17:31:15 -0500
Received: from zeus.kernel.org ([204.152.189.113]:49070 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261976AbVBTWbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 17:31:10 -0500
Date: Sun, 20 Feb 2005 14:30:23 -0800
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: raybry@sgi.com, ak@suse.de, ak@muc.de, raybry@austin.rr.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
 II
Message-Id: <20050220143023.3d64252b.pj@sgi.com>
In-Reply-To: <20050220214922.GA14486@wotan.suse.de>
References: <m1vf8yf2nu.fsf@muc.de>
	<42114279.5070202@sgi.com>
	<20050215121404.GB25815@muc.de>
	<421241A2.8040407@sgi.com>
	<20050215214831.GC7345@wotan.suse.de>
	<4212C1A9.1050903@sgi.com>
	<20050217235437.GA31591@wotan.suse.de>
	<4215A992.80400@sgi.com>
	<20050218130232.GB13953@wotan.suse.de>
	<42168FF0.30700@sgi.com>
	<20050220214922.GA14486@wotan.suse.de>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:
> I still think it's fundamentally unclean and racy. External processes
> shouldn't mess with virtual addresses of other processes.

It's not really messing with (changing) the virtual addresses of
another process.  It's messing with the physical placement.  It's
using the virtual addresses to help choose which pages to move.

Do you have any better way to suggest, Andi, for a batch manager to
relocate a job?  The typical scenario, as Ray explained it to me, is
thus.  A lower priority job, after running a while, is displaced by a
higher priority job that needs a large number of nodes.  Later on enough
nodes to run the lower priority job become available elsewhere.  The
lower priority job can either continue to wait for its original nodes to
come free (after the high priority job finishes) or it can be relocated
to the nodes available now.

How would you recommend that the batch manager move that job to the
nodes that can run it?  The layout of allocated memory pages and tasks
for that job must be preserved in order to keep the same performance.
The migration method needs to scale to hundreds, or more, of nodes.

(I'm starting to have visions of vma's having externally visible id's,
in a per-task namespace.)

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
