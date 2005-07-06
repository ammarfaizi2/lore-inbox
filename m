Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262415AbVGFRTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbVGFRTP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 13:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVGFRQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 13:16:50 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:60881 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261155AbVGFMv1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 08:51:27 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Wed, 6 Jul 2005 13:51:18 +0100
User-Agent: KMail/1.8.1
Cc: Ingo Molnar <mingo@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk>
In-Reply-To: <200507061257.36738.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507061351.18410.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 Jul 2005 12:57, Alistair John Strachan wrote:
[snip]
> Which debugging options are most useful for testing purposes? Is what I've
> selected enough? Also, I got a few unexpected messages in dmesg on bootup.

I decided to just enable everything, as I got a lockup within 5 minutes of 
using the patch. The new options have made the BUG warning a bit more 
verbose, and I thought I'd share the information in case it's useful.

[snip]
> Finally, I got this:
>
> BUG: soft lockup detected on CPU#0!
>  [<c013d7e9>] softlockup_tick+0x89/0xb0 (8)
>  [<c0108590>] timer_interrupt+0x50/0xf0 (20)
>  [<c013da91>] handle_IRQ_event+0x81/0x100 (16)
>  [<c013dbfc>] __do_IRQ+0xec/0x190 (48)
>  [<c0105a28>] do_IRQ+0x48/0x70 (40)
>  =======================
>  [<c024df3b>] acpi_processor_idle+0x0/0x258 (8)
>  [<c0103d03>] common_interrupt+0x1f/0x24 (12)
>  [<c024df3b>] acpi_processor_idle+0x0/0x258 (4)
>  [<c024e05e>] acpi_processor_idle+0x123/0x258 (40)
>  [<c024df3b>] acpi_processor_idle+0x0/0x258 (32)
>  [<c0101116>] cpu_idle+0x56/0x80 (16)
>  [<c03a486c>] start_kernel+0x17c/0x1c0 (12)
>  [<c03a43b0>] unknown_bootoption+0x0/0x1f0 (20)
>

BUG: soft lockup detected on CPU#0!
 [<c010421f>] dump_stack+0x1f/0x30 (20)
 [<c0144a3a>] softlockup_tick+0x8a/0xb0 (24)
 [<c0108607>] timer_interrupt+0x57/0x100 (20)
 [<c0144ce5>] handle_IRQ_event+0x85/0x110 (52)
 [<c0144e4a>] __do_IRQ+0xda/0x170 (44)
 [<c0105b15>] do_IRQ+0x65/0xa0 (933642172)
 =======================
 [<c0103ceb>] common_interrupt+0x1f/0x24 (-942757148)
------------------------------
| showing all locks held by: |  (sed/2285 [f7e3c880, 123]):
------------------------------

Then it continues to boot. I'm getting periodic lockups under high network 
load, however, though I suspect that might be the ipw2200 driver I compiled 
against the realtime-preempt kernel. Are there any known issues with external 
modules versus PREEMPT-RT?

Any way to debug these problems?

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
