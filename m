Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVCXV5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVCXV5g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 16:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVCXV5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 16:57:36 -0500
Received: from fmr22.intel.com ([143.183.121.14]:36758 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261625AbVCXV5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 16:57:34 -0500
Message-Id: <200503242156.j2OLung08187@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Oleg Nesterov'" <oleg@tv-sign.ru>, <linux-kernel@vger.kernel.org>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Christoph Lameter" <christoph@lameter.com>,
       "Andrew Morton" <akpm@osdl.org>
Subject: RE: [PATCH 0/5] timers: description
Date: Thu, 24 Mar 2005 13:56:49 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcUuF8zyfnQnWiW7TWOFdI1wfRtqHgCn9F/Q
In-Reply-To: <423ED7E4.2A1F0970@tv-sign.ru>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote on Monday, March 21, 2005 6:19 AM
> These patches are updated version of 'del_timer_sync: proof of concept'
> 2 patches.

Looks good performance wise.  Took a quick micro benchmark measurement on
a 16-node numa box (32-way). Results are pretty nice (to the expectation).

Time to execute del_timer_sync, averaged over 10,000 call:
Vanilla 2.6.11	19,313 ns
2.6.12-rc1-mm1	    81 ns
del_singleshot_timer_sync 74ns

Took another measurement on a 4-way smp box:
Vanilla 2.6.11	648 ns
2.6.12-rc1-mm1	 55 ns
del_singleshot	 41 ns

And Andrew always asks what are the impact on real-world bench, we did
not see performance regression on db transaction processing benchmark
with these set of timer patches versus using del_singleshot_timer_sync.
(del_singleshot_timer_sync is slightly faster, though 14 ns difference
falls well into noise range)

Note: I've only stress tested deleting an un-expired timer.


