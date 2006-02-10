Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbWBJArV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWBJArV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 19:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWBJArV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 19:47:21 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:37750 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750904AbWBJArU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 19:47:20 -0500
Date: Thu, 09 Feb 2006 18:48:47 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Help with 2.6.10 concurrency issue
In-reply-to: <5Erdv-5iS-39@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43EBE2EF.4080204@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5Erdv-5iS-39@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

martin rogers wrote:
> Problem is, the function writeList can be called from a H/W intr,
> and a workqueue (and that intr could of course happen while either
> the workqueue or the tasklet is running, right?).
> 
> If I use spin_lock_irqsave in writeList, it protects against the intr
> but not the tasklet.

Yes, it protects against the tasklet as well. Disabling interrupts also 
implicity disables BH execution (tasklets).

   If I use spin_lock_bh, I don't get protection
> from the intr I think; plus, I get :
> 
> Badness in local_bh_enable at kernel/softirq.c:142
> 
> when the intr runs (what does this mean?).

It means you're enabling BHs when interrupts are disabled, which doesn't 
make any sense. You can't use spin_lock_bh/spin_unlock_bh when 
interrupts are disabled.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

