Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbVGFXxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbVGFXxr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 19:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbVGFUF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:05:59 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:48097 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S262237AbVGFSXk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 14:23:40 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Wed, 6 Jul 2005 19:23:37 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507061814.23656.s0348365@sms.ed.ac.uk> <20050706172716.GA28755@elte.hu>
In-Reply-To: <20050706172716.GA28755@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507061923.37746.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 Jul 2005 18:27, Ingo Molnar wrote:
> * Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > > great! Do the softlockup warnings still occur?
> >
> > Yes, but in no greater a number.
>
> could you apply the patch below, so that we can see what kind of time
> gap the softlockup detector encountered?
>
> 	Ingo
>

Interesting. They're both exactly 10001 jiffies apart.

BUG: soft lockup detected on CPU#0! -283805--293806
 [<c010421f>] dump_stack+0x1f/0x30 (20)
 [<c01449d7>] softlockup_tick+0x97/0xc0 (32)
 [<c0108607>] timer_interrupt+0x57/0x100 (20)
 [<c0144c85>] handle_IRQ_event+0x85/0x110 (52)
 [<c0144dea>] __do_IRQ+0xda/0x170 (44)
 [<c0105b15>] do_IRQ+0x65/0xa0 (920170428)
 =======================
 [<c0103ceb>] common_interrupt+0x1f/0x24 (-925676316)
------------------------------
| showing all locks held by: |  (usb.agent/2424 [f7140800, 125]):
------------------------------

BUG: soft lockup detected on CPU#0! -251889--261890
 [<c010421f>] dump_stack+0x1f/0x30 (20)
 [<c01449d7>] softlockup_tick+0x97/0xc0 (32)
 [<c0108607>] timer_interrupt+0x57/0x100 (20)
 [<c0144c85>] handle_IRQ_event+0x85/0x110 (52)
 [<c0144dea>] __do_IRQ+0xda/0x170 (44)
 [<c0105b15>] do_IRQ+0x65/0xa0 (-196752)
 =======================
 [<c0103ceb>] common_interrupt+0x1f/0x24 (96)
 [<c0101145>] cpu_idle+0x65/0x90 (16)
 [<c03b0902>] start_kernel+0x182/0x1c0 (32)
 [<c010019f>] 0xc010019f (1076011023)
------------------------------
| showing all locks held by: |  (swapper/0 [c035de00, 140]):
------------------------------

Note the minus sign -- this is only just into the boot process.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
