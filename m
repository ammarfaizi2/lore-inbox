Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265424AbUFHX4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265424AbUFHX4a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 19:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265418AbUFHX43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 19:56:29 -0400
Received: from gizmo01bw.bigpond.com ([144.140.70.11]:51426 "HELO
	gizmo01bw.bigpond.com") by vger.kernel.org with SMTP
	id S265424AbUFHX42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 19:56:28 -0400
Message-ID: <40C65227.7030301@bigpond.net.au>
Date: Wed, 09 Jun 2004 09:56:23 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] staircase scheduler v6.4 for 2.6.7-rc3
References: <200406090023.54421.kernel@kolivas.org> <40C645F7.6070704@bigpond.net.au> <20040608233610.GC1444@holomorphy.com>
In-Reply-To: <20040608233610.GC1444@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Wed, Jun 09, 2004 at 09:04:23AM +1000, Peter Williams wrote:
> 
>>There was no need to add the extra overhead of a flag to indicate that a 
>>task was queued for scheduling.  Testing whether run_list is empty 
>>achieves the same thing as reliably as the old array == NULL test did.
> 
> 
> Overhead? Doubtful. Also, that requires the use of list_del_init()

Yes, that's true.

> while dequeueing, which is not in place now. Please do back the claim
> with measurements. It should be easy enough to nop out set_task_queued(),
> implement task_queued() via !list_empty(), and clear_task_queued() via
> INIT_LIST_HEAD() for a quick performance comparison. But I'd say to
> merge it even if there's no difference, as it's more self-contained.
> 

Since the principle use of testing array for NULL or not was to find out 
if the task was on a run list it seems silly to have a flag to determine 
this.  All it does is provide an opportunity for the flag to not 
accurately reflect whether the task is really on a list or not.

It caused the number of files touched by the staircase patch to increase 
  by a factor of five which is another good reason to use the alternative.

Peter
-- 
Dr Peter Williams                                pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

