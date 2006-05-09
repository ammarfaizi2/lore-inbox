Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWEIQX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWEIQX6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWEIQX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:23:57 -0400
Received: from test-iport-2.cisco.com ([171.71.176.105]:16038 "EHLO
	test-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1751314AbWEIQX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:23:56 -0400
To: Heiko J Schick <schihei@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
Subject: Re: [openib-general] [PATCH 07/16] ehca: interrupt handling routines
X-Message-Flag: Warning: May contain useful information
References: <4450A196.2050901@de.ibm.com> <adaejz9o4vh.fsf@cisco.com>
	<445B4DA9.9040601@de.ibm.com> <adafyjomsrd.fsf@cisco.com>
	<44608C90.30909@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 09 May 2006 09:23:38 -0700
In-Reply-To: <44608C90.30909@de.ibm.com> (Heiko J. Schick's message of "Tue, 09 May 2006 14:35:28 +0200")
Message-ID: <adalktbcgl1.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 May 2006 16:23:45.0932 (UTC) FILETIME=[F1FBB4C0:01C67384]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Heiko> Yes, I agree. It would not be an optimal solution, because
    Heiko> other upper level protocols (e.g. SDP, SRP, etc.) or
    Heiko> userspace verbs would not be affected by this
    Heiko> changes. Nevertheless, how can an improved "scaling" or
    Heiko> "SMP" version of IPoIB look like. How could it be
    Heiko> implemented?

The trivial way to do it would be to use the same idea as the current
ehca driver: just create a thread for receive CQ events and a thread
for send CQ events, and defer CQ polling into those two threads.

Something even better may be possible by specializing to IPoIB of course.

 - R.
