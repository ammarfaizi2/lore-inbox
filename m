Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbUDHNxE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 09:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbUDHNxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 09:53:03 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:34753 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261764AbUDHNw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 09:52:56 -0400
Subject: Re: [parisc-linux] rmap: parisc __flush_dcache_page
From: James Bottomley <James.Bottomley@steeleye.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       parisc-linux@parisc-linux.org
In-Reply-To: <Pine.LNX.4.44.0404081422380.7010-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0404081422380.7010-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 08 Apr 2004 08:52:50 -0500
Message-Id: <1081432370.2105.77.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-08 at 08:41, Hugh Dickins wrote:
> Something to notice about that parisc __flush_dcache_page I sent you:
> there's no locking around searching the tree for vmas; there was never
> any locking around searching the list for vmas.  arm is similar, but
> at least has no CONFIG_SMP, just a preemption issue.  Any ideas?

I don't think you sent it to the parisc list?

I'm afraid we've just been pretty heavily updating flush_dcache_page
recently to fill a number of holes in the implementation.

As far as list traversal goes...we don't require the list to freeze:
acidentally flushing dead vmas would be harmless and added ones wouldn't
need flushing, so all we need would probably be a safe traversal and a
reference to prevent the vma being deallocated.

James


