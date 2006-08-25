Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422796AbWHYTfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422796AbWHYTfL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 15:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422795AbWHYTfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 15:35:10 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:64392 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1422799AbWHYTfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 15:35:09 -0400
X-IronPort-AV: i="4.08,169,1154934000"; 
   d="scan'208"; a="314145430:sNHT30315154"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22 of 23] IB/ipath - print warning if LID not acquired within one minute
X-Message-Flag: Warning: May contain useful information
References: <1a41dc627c5a1bc2f7e9.1156530287@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 25 Aug 2006 12:35:06 -0700
In-Reply-To: <1a41dc627c5a1bc2f7e9.1156530287@eng-12.pathscale.com> (Bryan O'Sullivan's message of "Fri, 25 Aug 2006 11:24:47 -0700")
Message-ID: <adafyfktxqt.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 25 Aug 2006 19:35:08.0569 (UTC) FILETIME=[92C81090:01C6C87D]
Authentication-Results: sj-dkim-5.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1) What makes ipath special so that we want this warning for ipath
devices but not other IB hardware?  If this warning is actually
useful, then I think it would make more sense to start a timer when
any IB device is added, and warn if ports with a physical link don't
become active after the timeout time.  But I'm having a hard time
seeing why we want this message in the kernel log.

2) You do cancel_delayed_work() but not flush_scheduled_work(), so
it's possible for your timeout function to be running after the module
text is gone.

 - R.
