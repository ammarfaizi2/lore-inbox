Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269578AbUICJgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269578AbUICJgx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 05:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269605AbUICJgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:36:53 -0400
Received: from plam.fujitsu-siemens.com ([217.115.66.9]:40498 "EHLO
	plam.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S269578AbUICJgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 05:36:00 -0400
Message-ID: <41383F33.4050503@fujitsu-siemens.com>
Date: Fri, 03 Sep 2004 11:53:55 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [1/4] standardize bit waiting data type
References: <2xoKb-2Pa-27@gated-at.bofh.it> <2y3X5-73V-37@gated-at.bofh.it> <2y46A-798-17@gated-at.bofh.it> <2y4T1-7GM-17@gated-at.bofh.it> <2y52E-7Li-11@gated-at.bofh.it> <2y5ci-7Qz-7@gated-at.bofh.it> <2y5m3-7VH-5@gated-at.bofh.it> <2y7Hd-1aP-21@gated-at.bofh.it>
In-Reply-To: <2y7Hd-1aP-21@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

> @@ -153,15 +119,13 @@
>  void __wait_on_buffer(struct buffer_head * bh)
>  {
>  	wait_queue_head_t *wqh = bh_waitq_head(bh);
> -	DEFINE_BH_WAIT(wait, bh);
> +	DEFINE_WAIT_BIT(wait, &bh->b_state, BH_Lock);
>  
> -	do {
> -		prepare_to_wait(wqh, &wait.wait, TASK_UNINTERRUPTIBLE);
> -		if (buffer_locked(bh)) {
> -			sync_buffer(bh);
> -			io_schedule();
> -		}
> -	} while (buffer_locked(bh));
> +	prepare_to_wait(wqh, &wait.wait, TASK_UNINTERRUPTIBLE);
> +	if (buffer_locked(bh)) {
> +		sync_buffer(bh);
> +		io_schedule();
> +	}
>  	finish_wait(wqh, &wait.wait);
>  }

Why don't you need a do..while loop any more ?

There is also no loop in __wait_on_bit() in the completed patch series.

Cheers
Martin
