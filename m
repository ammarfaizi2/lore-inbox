Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932567AbWAKBOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbWAKBOb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 20:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWAKBOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 20:14:30 -0500
Received: from smtp-out.google.com ([216.239.45.12]:14459 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932567AbWAKBOa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 20:14:30 -0500
Message-ID: <43C45BDC.1050402@google.com>
Date: Tue, 10 Jan 2006 17:14:04 -0800
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: -mm seems significanty slower than mainline on kernbench
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I fixed the graphs so you can actually read them now ;-)

http://test.kernel.org/perf/kernbench.elm3b6.png (x86_64 4x)
http://test.kernel.org/perf/kernbench.moe.png (NUMA-Q)
http://test.kernel.org/perf/kernbench.elm3b132.png (4x SMP ia32)

Both seems significantly slower on -mm (mm is green line)

If I look at diffprofile between 2.6.15 and 2.6.15-mm1, it just looks
like we have lots more idle time. You got strange scheduler changes in
there, that you've been carrying for a long time (2.6.14-mm1 at least)? 
or HZ piddling? See to be mainly getting much more idle time.

Diffprofile:

       1278    39.6% default_idle
       1261    10.1% total
        243  1518.8% find_get_page
        220     0.0% copy_user_generic
        100   357.1% free_hot_cold_page
...
       -106   -93.0% __pagevec_free
       -125  -100.0% __free_pages_ok
       -239  -100.0% copy_user_generic_c
       -242  -100.0% find_trylock_page

Original profiles:
http://test.kernel.org/19657/002.kernbench.test/profiling/profile.text 
(2.6.15)
http://test.kernel.org/19794/002.kernbench.test/profiling/profile.text
(2.6.15-mm1)

