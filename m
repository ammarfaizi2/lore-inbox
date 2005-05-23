Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVEWOok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVEWOok (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 10:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVEWOoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 10:44:39 -0400
Received: from webmail.topspin.com ([12.162.17.3]:1018 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261737AbVEWOob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 10:44:31 -0400
To: "linux" <kernel@wired-net.gr>
Cc: "lkml" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 workqueue's
X-Message-Flag: Warning: May contain useful information
References: <001801c55d56$ccb5bc00$0101010a@dioxide>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 23 May 2005 07:44:25 -0700
Message-ID: <52oeb20zp2.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 23 May 2005 14:44:26.0058 (UTC) FILETIME=[EAA0DAA0:01C55FA5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    >       queue_work(wk,&work); /* Standalone workqueue */
    >         schedule_work(&work); /* Shared workqueue */

You shouldn't queue the same work_struct to two different work queues
at the same time.  You're basically trying to add the same item to two
different linked lists at the same time, which of course is going to
cause problems.

 - R.
