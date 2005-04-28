Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbVD1TAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbVD1TAY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 15:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVD1TAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 15:00:24 -0400
Received: from kanga.kvack.org ([66.96.29.28]:30696 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S262225AbVD1TAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 15:00:18 -0400
Date: Thu, 28 Apr 2005 14:59:56 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-arch@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] unify semaphore implementations
Message-ID: <20050428185956.GD16545@kvack.org>
References: <20050428182926.GC16545@kvack.org> <1114714089.5022.3.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114714089.5022.3.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 11:48:09AM -0700, James Bottomley wrote:
> Could you come up with a less monolithic way to share this so that we
> can still do a spinlock semaphore implementation instead of an atomic op
> based one?

As I read the code, it doesn't make a difference: parisc will take a 
spin lock within the atomic operation and then release it, which makes 
the old fast path for the semaphores and the new fast path pretty much 
equivalent (they both take and release one spinlock).  The only extra 
cost is the address computation for the spinlock.  If there is contention 
for the atomic spinlocks, then parisc can increase the number of buckets 
in their hashed spinlocks.

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
