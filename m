Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267655AbTGHU7m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 16:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267656AbTGHU7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 16:59:42 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:17575 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S267655AbTGHU7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 16:59:39 -0400
Date: Tue, 8 Jul 2003 23:16:22 +0200
From: Vincent Touquet <vincent.touquet@pandora.be>
To: Vincent Touquet <vincent.touquet@pandora.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bug report] System lockups on Tyan S2469 and lots of io [smp boot time problems too :(]
Message-ID: <20030708211621.GB17673@ns.mine.dnsalias.org>
Reply-To: vincent.touquet@pandora.be
References: <20030706210243.GA25645@lea.ulyssis.org> <20030707124747.GF7233@ns.mine.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030707124747.GF7233@ns.mine.dnsalias.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another way to lockup the system:
dd if=/dev/zero of=/array/file bs=1024k count=10000

So now I didn't even use any code that came near ide
(unless you take into account swapping ?)

The process ends again in a hangup:
Jul  8 22:54:55 kalimero kernel: 3w-xxxx: scsi0: AEN drain failed,
retrying.
Jul  8 22:54:55 kalimero kernel: 3w-xxxx: scsi0: Controller errors, card
not responding, check all cabling.
Jul  8 22:54:55 kalimero kernel: 3w-xxxx: scsi0: Reset sequence failed.
Jul  8 22:54:55 kalimero kernel: 3w-xxxx: scsi0: Unit #0: Command
(f7c1cc00) timed out, resetting card.

Some interesting bits in the traces show the scsi being in a limbo:
Jul  8 22:54:55 kalimero kernel: kupdated      D 00000046  5052     7
1             8     6 (L-TLB)
Jul  8 22:54:55 kalimero kernel: Call Trace:
[call_reschedule_interrupt+5/11] [__down+192/352] [__down_failed+11/20]
[.text.lock.super+279/518] [sync_old_buffers+102/336]
Jul  8 22:54:55 kalimero kernel:   [kupdate+418/480] [kupdate+0/480]
[arch_kernel_thread+46/64] [kupdate+0/480]
Jul  8 22:54:55 kalimero kernel: scsi_eh_0     R F7C64080  5760     8
1             9     7 (L-TLB)
Jul  8 22:54:55 kalimero kernel: Call Trace:
[tw_scsi_eh_abort+504/768] [scsi_try_to_abort_command+136/208]
[__down_interruptible+373/416]
[scsi_unjam_host+2045/2672] [scsi_error_handler+376/608]
Jul  8 22:54:55 kalimero kernel:   [arch_kernel_thread+46/64]
[scsi_error_handler+0/608]

And of course the dd process is in state 'D'...

I should start browsing the sources for these scsi_* functions.

I would really like to know if I'm looking at a software or a hardware
issue here.

best regards,

Vincent
