Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWFHMXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWFHMXt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 08:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWFHMXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 08:23:49 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:3494 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751298AbWFHMXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 08:23:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W5ypGcJZenmSc+OMt9dL0e/Gii0VeG+iuCRloI7mzp+wUcJCLY22rJ9tqPxiiRrH51RyaP8EdnTHsi+UeiK+rwI2HLZr0/ZrB4n185jyyaH+lhOwtLyq0Gq0cujrCWU1f8BJR4oXITo3/6AR+d7tQss1YCiGPRer2vjpa+Rp4gg=
Message-ID: <6bffcb0e0606080523p31bddee3hdaa5535d797125ce@mail.gmail.com>
Date: Thu, 8 Jun 2006 14:23:47 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-rc6-rt1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0606080328n1c58f562td20c1ef2bae76327@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060607211455.GA6132@elte.hu>
	 <6bffcb0e0606080328n1c58f562td20c1ef2bae76327@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
[snip]
> EIP: [<c02ba67d>] rt_lock_slowlock+0x99/0x1b2 SS:ESP 0068:eed13d90
>  <6>note: bash[2104] exited with preempt_count 2
> BUG: soft lockup detected on CPU#1!

Here is something similar

EIP: [<c02ba67d>] rt_lock_slowlock+0x99/0x1b2 SS:ESP 0068:f42a2d18
 <1>Fixing recursive fault but reboot is needed!
BUG: scheduling while atomic: make/0x00000002/3014
 [<c0104647>] show_trace+0xd/0xf (8)
 [<c010470c>] dump_stack+0x17/0x19 (12)
 [<c02b8ab1>] __schedule+0x60/0xf01 (148)
 [<c02b9b0e>] schedule+0xaf/0xcd (12)
 [<c0120ccb>] do_exit+0xe0/0x89f (48)
 [<c0104548>] die+0x26b/0x291 (52)
 [<c01045f7>] do_trap+0x89/0xa3 (32)
 [<c0104be7>] do_invalid_op+0x89/0x93 (180)
 [<c0103a07>] error_code+0x4f/0x54 (164)
 [<c02bad05>] rt_lock+0xb/0xd (8)
  [<c015e320>] kfree+0x30/0x86 (24)
 [<c01bd0f2>] selinux_task_free_security+0x1a/0x1c (8)
 [<c011d31c>] __put_task_struct+0x8d/0xc2 (12)
 [<c02b9910>] __schedule+0xebf/0xf01 (132)
 [<c02b9eec>] preempt_schedule_irq+0x37/0x57 (16)
 [<c0102e14>] need_resched+0x20/0x24 (-3656)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c02b8acb>] .... __schedule+0x7a/0xf01
.....[<c02b9eec>] ..   ( <= preempt_schedule_irq+0x37/0x57)
.. [<c02bae55>] .... _raw_spin_lock+0x10/0x21
.....[<c02ba608>] ..   ( <= rt_lock_slowlock+0x24/0x1b2)


>
> Here is dmesg http://www.stardust.webpages.pl/files/rt/2.6.17-rc6-rt1/rt-dmesg
> Here is config http://www.stardust.webpages.pl/files/rt/2.6.17-rc6-rt1/rt-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
