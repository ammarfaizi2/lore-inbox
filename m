Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263904AbUCZCKu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 21:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263906AbUCZCKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 21:10:49 -0500
Received: from palrel12.hp.com ([156.153.255.237]:59039 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263904AbUCZCKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 21:10:41 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16483.37151.114594.263358@napali.hpl.hp.com>
Date: Thu, 25 Mar 2004 18:10:39 -0800
To: Andrew Morton <akpm@osdl.org>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, mpm@selenic.com,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: potential /dev/urandom scalability improvement
In-Reply-To: <20040325180014.29e40b65.akpm@osdl.org>
References: <20040325141923.7080c6f0.akpm@osdl.org>
	<20040325224726.GB8366@waste.org>
	<16483.35656.864787.827149@napali.hpl.hp.com>
	<20040325180014.29e40b65.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 25 Mar 2004 18:00:14 -0800, Andrew Morton <akpm@osdl.org> said:

  Andrew> We may as well stick prefetch_range() in prefetch.h.

Fair enough.

  Andrew> And Matt's patch series is not a thing I want to take on
  Andrew> board at present, so let's stick with the straight
  Andrew> scalability patch for now.

  Andrew> I moved the prefetch_range() call to outside the spinlock.
  Andrew> Does that make sense?

The other CPUs will dirty that data, so prefetching it before you hold
the lock is almost certainly bad for performance.  (Well, to be
precise, it really depends on the number of lines dirtied.)

	--david
