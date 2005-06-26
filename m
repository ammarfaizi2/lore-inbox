Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVFZWeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVFZWeX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 18:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVFZWeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 18:34:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11419 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261423AbVFZWeU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 18:34:20 -0400
Date: Sun, 26 Jun 2005 18:34:14 -0400 (EDT)
From: Rik Van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org, Song Jiang <sjiang@lanl.gov>
Subject: [PATCH] 0/2 swap token tuning
Message-ID: <Pine.LNX.4.61.0506261827500.18834@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A while ago the swap token (aka token based thrashing control)
mechanism was introduced into Linux.  This code improves performance
under heavy VM loads, but can reduce performance under very light
VM loads.

The cause turns out to be me overlooking something in the original
token based thrashing control paper: the swap token is only supposed
to be enforced while the task holding the swap token is paging data
in, not while the task is running (and referencing its working set).

The temporary solution in Linux was to disable the swap token code
and have users turn it on again via /proc.  The following patch
instead approximates the "only enforce the swap token if the task
holding it is swapping something in" idea.  This should make sure
the swap token is effectively disabled when the VM load is low.

I have not benchmarked these patches yet; instead, I'm posting
them before the weekend is over, hoping to catch a bit of test
time from others while my own tests are being run ;)

-- 
The Theory of Escalating Commitment: "The cost of continuing mistakes is
borne by others, while the cost of admitting mistakes is borne by yourself."
  -- Joseph Stiglitz, Nobel Laureate in Economics
