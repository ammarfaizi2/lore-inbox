Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265405AbUFHXgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265405AbUFHXgS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 19:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265428AbUFHXgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 19:36:18 -0400
Received: from holomorphy.com ([207.189.100.168]:3713 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265405AbUFHXgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 19:36:17 -0400
Date: Tue, 8 Jun 2004 16:36:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] staircase scheduler v6.4 for 2.6.7-rc3
Message-ID: <20040608233610.GC1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Williams <pwil3058@bigpond.net.au>,
	Con Kolivas <kernel@kolivas.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Zwane Mwaikambo <zwane@linuxpower.ca>
References: <200406090023.54421.kernel@kolivas.org> <40C645F7.6070704@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C645F7.6070704@bigpond.net.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 09:04:23AM +1000, Peter Williams wrote:
> There was no need to add the extra overhead of a flag to indicate that a 
> task was queued for scheduling.  Testing whether run_list is empty 
> achieves the same thing as reliably as the old array == NULL test did.

Overhead? Doubtful. Also, that requires the use of list_del_init()
while dequeueing, which is not in place now. Please do back the claim
with measurements. It should be easy enough to nop out set_task_queued(),
implement task_queued() via !list_empty(), and clear_task_queued() via
INIT_LIST_HEAD() for a quick performance comparison. But I'd say to
merge it even if there's no difference, as it's more self-contained.


-- wli
