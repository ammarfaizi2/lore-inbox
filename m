Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbTEFPQA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbTEFPP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:15:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:2025 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263798AbTEFPP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:15:58 -0400
Date: Tue, 06 May 2003 07:20:51 -0700 (PDT)
Message-Id: <20030506.072051.45141886.davem@redhat.com>
To: dipankar@in.ibm.com
Cc: wli@holomorphy.com, akpm@digeo.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.69-mm1
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030506152555.GC9875@in.ibm.com>
References: <20030506110907.GB9875@in.ibm.com>
	<1052222542.983.27.camel@rth.ninka.net>
	<20030506152555.GC9875@in.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dipankar Sarma <dipankar@in.ibm.com>
   Date: Tue, 6 May 2003 20:55:55 +0530

   On Tue, May 06, 2003 at 05:02:22AM -0700, David S. Miller wrote:
   > rwlocks believe it or not tend not to be superior over spinlocks,
   > they actually promote cache line thrashing in the case they
   > are actually being effective (>1 parallel reader)
   
   Provided there isn't a very heavy contention among readers for the
   spin_lock.

Even if there are thousands of readers trying to get the lock
at the same time, unless your hold time is significant these
readers will merely thrash the cache getting the rwlock_t.
And then thrash it again to release the rwlock_t.

This is especially true if the spinlock lives in the same cache
lines as the data it protects.

All of this is magnified on NUMA.
