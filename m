Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWE3TmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWE3TmI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbWE3TmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:42:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43650 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932384AbWE3TmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:42:06 -0400
Date: Tue, 30 May 2006 12:45:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm1
Message-Id: <20060530124553.eea8bf58.akpm@osdl.org>
In-Reply-To: <6bffcb0e0605301155h3b472d79h65e8403e7fa0b214@mail.gmail.com>
References: <20060530022925.8a67b613.akpm@osdl.org>
	<6bffcb0e0605301155h3b472d79h65e8403e7fa0b214@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006 20:55:52 +0200
"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:

> On 30/05/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm1/
> >
> 
> SCSI or libata problem.
> ============================
> [ BUG: illegal lock usage! ]
> ----------------------------
> illegal {in-hardirq-W} -> {hardirq-on-W} usage.
> init/1 [HC0[0]:SC0[0]:HE1:SE1] takes:
>  (&base->lock#2){++..}, at: [<c0129a24>] lock_timer_base+0x29/0x55
> {in-hardirq-W} state was registered at:
>   [<c0139a56>] lockdep_acquire+0x69/0x82
>   [<c02f237c>] _spin_lock_irqsave+0x2a/0x3a
>   [<c0129a24>] lock_timer_base+0x29/0x55
>   [<c0129e48>] del_timer+0x19/0x4c
>   [<c02651e2>] scsi_delete_timer+0xe/0x1f
>   [<c0262964>] scsi_done+0xb/0x19
>   [<c0273ed3>] ata_scsi_qc_complete+0x73/0x7f
>   [<c027024a>] __ata_qc_complete+0x26c/0x274
>   [<c02704f0>] ata_qc_complete+0xd5/0xdc
>   [<c0270c42>] ata_hsm_qc_complete+0x201/0x210
>   [<c02713e7>] ata_hsm_move+0x796/0x7ac
>   [<c027314e>] ata_interrupt+0x173/0x1b4
>   [<c014c4f4>] handle_IRQ_event+0x20/0x50
>   [<c014d76e>] handle_level_irq+0xa1/0xeb
>   [<c010579c>] do_IRQ+0xa1/0xc9

That's the second report of del_timer-in-hardirq being a bug.

Unfortunately I'm unable to decrypt the local validator's output.  Perhaps
when Arjan and Ingo do the analysis of these reports they could provide a
little guidance into what the traces are actually telling us, so that
others can learn to use them?
