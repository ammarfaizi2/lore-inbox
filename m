Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422738AbWBNWYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422738AbWBNWYV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 17:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422806AbWBNWYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 17:24:21 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:43207 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1422738AbWBNWYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 17:24:20 -0500
Date: Tue, 14 Feb 2006 16:24:17 -0600
From: Cliff Wickman <cpw@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] sys_setrlimit() in 2.6.16
Message-ID: <20060214222417.GA8479@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A test suite uncovered a possible bug in setrlimit(2), in 2.6.16-rc3.

A code that does
        mylimits.rlim_cur = 0;
        setrlimit(RLIMIT_CPU, &mylimits);
does not set a cpu time limit.

No signal is sent to this code when its "limit" of 0 seconds expires.
Whereas, under the 2.6.5 kernel (SuSE SLESS9) a signal was sent.

I don't see any obvious difference in sys_setrlimit() or
set_process_cpu_timer() between 2.6.5 and 2.6.16.

Is this a correction, or a bug?

Is a cpu time limit of 0 supposed to limit a task to 0 seconds, or
leave it unlimited?

-- 
Cliff Wickman
Silicon Graphics, Inc.
cpw@sgi.com
(651) 683-3824
