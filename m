Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264163AbTLOWDr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 17:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTLOWDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 17:03:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:15818 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264163AbTLOWDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 17:03:42 -0500
Date: Mon, 15 Dec 2003 14:04:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Olien <dmo@osdl.org>
Cc: linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: [PATCH] 2.6.0-test11 DAC960 request queue per disk
Message-Id: <20031215140438.4371dbdb.akpm@osdl.org>
In-Reply-To: <20031215214053.GA3308@osdl.org>
References: <20031215214053.GA3308@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Olien <dmo@osdl.org> wrote:
>
> 
> Here's a patch that changes the DAC960 driver from having one request
> queue for ALL disks on the controller, to having a request queue for
> each logical disk.  This turns out to make little difference for deadline
> scheduler, nor for AS scheduler under light IO load.  But under AS
> scheduler with heavy IO, it makes about a 40% difference on dbt2
> workload.  Here are the measured numbers:
> 
> The 2.6.0-test11-D kernel version includes this mutli-queue patch to the
> DAC960 driver.
> 
> For non-cached dbt2 workload  (heavy IO load)
> 
> Scheduler	kernel/driver	NOTPM(bigger is better)
> AS		2.6.0-test11-D  1598
> AS		2.6.0-test11     973
> deadline	2.6.0-test11    1640
> deadline	2.6.0-test11-D  1645
> 
> For cached dbt2 workload (lighter IO load)
> 
> AS		2.6.0-test11-D  4993
> AS		2.6.-test6-mm4  4976, 4890, 4972
> deadline	2.6.0-test11-D  4998

Looks nice.

> Can this be included in 2.6.0?  I know it's not a "critical patch"
> in the sense that something won't work without it.  On the other hand,
> the change is isolated to a driver.

Let's queue it for 2.6.1 please.  The default IO scheduler in 2.6.0 will
have some (known) efficiency problems anyway.  (I thought those were fixed
in current -mm but we still seem to have tiobench randread problems).


