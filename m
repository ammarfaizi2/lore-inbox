Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266445AbUFWMKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266445AbUFWMKo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 08:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266452AbUFWMKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 08:10:44 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:51691 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S266445AbUFWMKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 08:10:42 -0400
Date: Wed, 23 Jun 2004 21:11:58 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: [3/4] [PATCH]Diskdump - yet another crash dump function
In-reply-to: <20040622101914.GA20623@elte.hu>
To: Ingo Molnar <mingo@elte.hu>
Cc: Nobuhiro Tachino <ntachino@redhat.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@muc.de>
Message-id: <F1C4591B482AC7indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 3.55
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <20040622101914.GA20623@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 22 Jun 2004 12:19:14 +0200, Ingo Molnar wrote:

>indeed!
>
>luckily we can solve this in the upstream kernel without too much fuss,
>see the patch below. All callers of __run_timers() run with irqs
>enabled.
>
>(NOTE: we unconditionally disable interrupts after having run the timer
>fn - this solves the problem of a timer fn keeping irqs disabled.)

My patch posted on 22 Jun had a bug!
http://marc.theaimsgroup.com/?l=linux-kernel&m=108791355225806&w=2
In the __run_timers, I missed spin_unlock_irq before fn(data). Your
patch correct rightly. Thanks!


>does this patch stabilize diskdump?

No. There is one thing I need correct. I need replace proc interface
with sysfs, as Christoph and Arjan commented.
After fix this, I'll release stable version 1.0.

Best Regards,
Takao Indoh
