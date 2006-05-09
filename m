Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWEISgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWEISgL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 14:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWEISgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 14:36:11 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:45988 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1750795AbWEISgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 14:36:10 -0400
X-IronPort-AV: i="4.05,106,1146466800"; 
   d="scan'208"; a="274043008:sNHT33283686"
To: Shirley Ma <xma@us.ibm.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, linuxppc-dev@ozlabs.org,
       Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       openib-general-bounces@openib.org
Subject: Re: [openib-general] Re: [PATCH 07/16] ehca: interrupt handling routines
X-Message-Flag: Warning: May contain useful information
References: <OF22D08323.20D303C1-ON87257169.0063C980-88257169.006A41AB@us.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 09 May 2006 11:36:07 -0700
In-Reply-To: <OF22D08323.20D303C1-ON87257169.0063C980-88257169.006A41AB@us.ibm.com> (Shirley Ma's message of "Tue, 9 May 2006 11:27:29 -0700")
Message-ID: <adar733avvs.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 May 2006 18:36:08.0463 (UTC) FILETIME=[7019C1F0:01C67397]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Shirley> I have done some patch like that on top of splitting
    Shirley> CQ. The problem I found that hardware interrupt favors
    Shirley> one CPU. Most of the time these two threads are running
    Shirley> on the same cpu according to my debug output. You can
    Shirley> easily find out by cat /proc/interrupts and
    Shirley> /proc/irq/XXX/smp_affinity.  ehca has distributed
    Shirley> interrupts evenly on SMP, so it gets the benefits of two
    Shirley> threads, and gains much better throughputs.

Yes, an interrupt will likely be delivered to one CPU.

But there's no reason why the two threads can't be pinned to different
CPUs or given exclusive CPU masks, exactly the same way that ehca
implements it.

 - R.
