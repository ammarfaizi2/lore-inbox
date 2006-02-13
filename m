Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030243AbWBMXBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWBMXBI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030256AbWBMXBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:01:07 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:33722 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030243AbWBMXAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:00:55 -0500
Date: Mon, 13 Feb 2006 17:00:51 -0600
From: Cliff Wickman <cpw@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Question: possible bug in setrlimit
Message-ID: <20060213230051.GA29417@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A test suite uncovered a possible bug in setrlimit(2).

A code that does
        mylimits.rlim_cur = 0;
        setrlimit(RLIMIT_CPU, &mylimits);
does not set a cpu time limit.
No signal is sent to this code when its "limit" of 0 seconds expires.

Under the 2.6.5 kernel (SuSE SLESS9) a signal was sent.

I don't see any obvious difference in sys_setrlimit() or
set_process_cpu_timer() between 2.6.5 and 2.6.16.

Is a cpu time limit of 0 supposed to limit to 0 seconds, or be unlimited?

-- 
Cliff Wickman
Silicon Graphics, Inc.
cpw@sgi.com
(651) 683-3824
