Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263555AbUE2E7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbUE2E7Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 00:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263609AbUE2E7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 00:59:22 -0400
Received: from palrel13.hp.com ([156.153.255.238]:11422 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263555AbUE2E7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 00:59:19 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16568.6306.306924.154136@napali.hpl.hp.com>
Date: Fri, 28 May 2004 21:59:14 -0700
To: nickpiggin@yahoo.com.au, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: big bw_pipe drop due to sched-domain patch?
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today I noticed that going from 2.6.6 to 2.6.7-rc1 caused a big drop
in LMbench2 bw_pipe throughput on a dual-CPU machine (2.6.7-rc1 shows
10 times lower bandwidth than 2.6.6).  It appears that the drop is due
to the two tasks being distributed across the two CPUs, rather than
being kept on the same CPU.  If I force the tasks to be pinned on a
single CPU, e.g., like so:

	$ taskset 1 ./bw_pipe

then performance is "only" about 10% worse than with 2.6.6.

Is this kind of drop expected?

	--david
