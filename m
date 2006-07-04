Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbWGDLlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbWGDLlt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 07:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWGDLlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 07:41:49 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:29838 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S932213AbWGDLls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 07:41:48 -0400
Date: Tue, 4 Jul 2006 13:41:45 +0200 (CEST)
From: Jesper Dangaard Brouer <hawk@diku.dk>
To: Andi Kleen <ak@suse.de>
Cc: Willy Tarreau <w@1wt.eu>, Harry Edmon <harry@atmos.washington.edu>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
In-Reply-To: <200606260723.43209.ak@suse.de>
Message-ID: <Pine.LNX.4.61.0607041333030.18483@ask.diku.dk>
References: <4492D5D3.4000303@atmos.washington.edu> <200606191724.31305.ak@suse.de>
 <20060625222243.GJ13255@w.ods.org> <200606260723.43209.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Jun 2006, Andi Kleen wrote:

>> I encountered the same problem on a dual core opteron equipped with a
>> broadcom NIC (tg3) under 2.4. It could receive 1 Mpps when using TSC
>> as the clock source, but the time jumped back and forth, so I changed
>> it to 'notsc', then the performance dropped dramatically to around the
>> same value as above with one CPU saturated. I suspect that the clock
>> precision is needed by the tg3 driver to correctly decide to switch to
>> polling mode, but unfortunately, the performance drop rendered the
>> solution so much unusable that I finally decided to use it only in
>> uniprocessor with TSC enabled.
>
> 2.6 is more clever at this than 2.4. In particular it does the timestamp
> for each packet only when actually needed, which is relativelt rare.
>
> Old experiences do not always apply to new kernels.

Note, that I experinced this problem on 2.6.

Actually the change happens between kernel version 2.6.15 and 2.6.16. And 
is a result of Andi's changes to arch/x86_64/Kconfig and 
drivers/acpi/Kconfig, which "allows/activates" the use of the timer on 
x86_64.

Cheers,
   Jesper Brouer

--
-------------------------------------------------------------------
MSc. Master of Computer Science
Dept. of Computer Science, University of Copenhagen
Author of http://www.adsl-optimizer.dk
-------------------------------------------------------------------
