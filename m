Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWF1QCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWF1QCL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWF1QCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:02:11 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:968 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751165AbWF1QCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:02:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=Bg47CuPfhrfzuowkMxapNNCDsfJCkr+T0OtUwFc6JjTI0TB549c2cQGUDZtb1Wi9qaHv1vDl4Skgwr9qtmSLXmtzRm8IJ8loOEjYtnAOimf+IdwMN6dX8rbcnOoD6a4JiPdiEFtMK14xqMhNJprJLzxMHsxUTGPSS8FKqdIYoHQ=
Date: Wed, 28 Jun 2006 18:02:16 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Milan Svoboda <msvoboda@ra.rockwell.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Linux-2.6.17-rt3 on arm ixdp465
In-Reply-To: <44A29AA1.3020202@ra.rockwell.com>
Message-ID: <Pine.LNX.4.64.0606281759340.22288@localhost.localdomain>
References: <44A29AA1.3020202@ra.rockwell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006, Milan Svoboda wrote:

> Hello,
>
> I tried this kernel on arm ixdp465, it works well, but I got many
> of these messages:
>
> BUG: scheduling with irqs disabled: IRQ 25/0x00000000/683
> caller is rt_lock_slowlock+0xd8/0x1c8
> BUG: scheduling with irqs disabled: IRQ 25/0x00000000/683
> caller is rt_lock_slowlock+0xd8/0x1c8
> BUG: scheduling with irqs disabled: IRQ 25/0x00000000/683
> caller is rt_lock_slowlock+0xd8/0x1c8
> BUG: scheduling with irqs disabled: IRQ 25/0x00000000/683
> caller is rt_lock_slowlock+0xd8/0x1c8
> BUG: scheduling with irqs disabled: IRQ 25/0x00000000/683
> caller is rt_lock_slowlock+0xd8/0x1c8
>
> # cat /proc/interrupts
>           CPU0
> 5:      29620   IXP4xx Timer Tick
> 15:        876   serial
> 25:       3813   eth0
> Err:          0
>

Looks like a bug in your ethernet driver, which is?
It could be that that driver is not SMP compliant and uses irq disable/enable
as locking method instead of a spinlock.

Esben

> PS: Please CC me, I'm not subscribed...
>
> Best Regards,
> Milan Svoboda
>
>
>
