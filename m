Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317705AbSGVRQk>; Mon, 22 Jul 2002 13:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317707AbSGVRQj>; Mon, 22 Jul 2002 13:16:39 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:46069 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317705AbSGVRQT>; Mon, 22 Jul 2002 13:16:19 -0400
Subject: Re: [PATCH] low-latency zap_page_range
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3D3B960C.C56D4FE2@zip.com.au>
References: <mailman.1027196701.28591.linux-kernel2news@redhat.com>
	<200207210247.g6L2lXE13782@devserv.devel.redhat.com> 
	<3D3B960C.C56D4FE2@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 22 Jul 2002 10:19:18 -0700
Message-Id: <1027358358.932.8.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-21 at 22:20, Andrew Morton wrote:

> There are actually quite a few places in the ll patch which don't
> pass ZPR_COND_RESCHED into zap_page_range.  Places which are
> themselves called under locks, places where not enough pages
> are being zapped to make it necessary, etc. vmtruncate_list,
> some mremap code, others.

The bonus of the approach in my patch is that we won't reschedule unless
the lock count is zero (due to the preemptive kernel), so we do not need
to worry about the above.  The only concern would be if there is ever a
case where the critical region is the entire chunk we want to zap (e.g.
we must zap the entire inputted range atomically) but I do not see that
ever being the case.

	Robert Love

