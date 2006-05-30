Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWE3Mqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWE3Mqf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 08:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWE3Mqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 08:46:35 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:41303 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751490AbWE3Mqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 08:46:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r9V/C/rh//9A5az5S+Dc2fVCHjHcLd7x0HuV4QrZqHVLw4DMbdE+DlYKC6av5LHK8niNw5t/tnzEQvbWXB8+3Mc8W/qQ2ERIN9xvX7pfENAiWnbp4xD07L+VhTlOOaJFox6w4HPS9vInZsKzcN4Tg0fYYjyEiGn6hKwqxBauuc8=
Message-ID: <6bffcb0e0605300546k26090790s54581ca16855de2d@mail.gmail.com>
Date: Tue, 30 May 2006 14:46:33 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060530022925.8a67b613.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060530022925.8a67b613.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30/05/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm1/
>

============================
[ BUG: illegal lock usage! ]
----------------------------
illegal {in-hardirq-W} -> {hardirq-on-W} usage.
udevd/415 [HC0[0]:SC1[1]:HE1:SE0] takes:
 (&base->lock#2){++..}, at: [<c012900a>] run_timer_softirq+0x3d/0x164
{in-hardirq-W} state was registered at:
  [<c0139a56>] lockdep_acquire+0x69/0x82
  [<c02f23ac>] _spin_lock_irqsave+0x2a/0x3a
  [<c0129a24>] lock_timer_base+0x29/0x55
  [<c0129e48>] del_timer+0x19/0x4c
  [<c025925d>] ide_intr+0x13b/0x1a9
  [<c014c524>] handle_IRQ_event+0x20/0x50
  [<c014d48c>] handle_edge_irq+0x10a/0x14f
  [<c010579c>] do_IRQ+0xa1/0xc9
irq event stamp: 351479
hardirqs last  enabled at (351478): [<c02f274c>] _spin_unlock_irq+0x22/0x53
hardirqs last disabled at (351479): [<c02f2324>] _spin_lock_irq+0xc/0x35
softirqs last  enabled at (351434): [<c0125873>] __do_softirq+0xea/0xf0
softirqs last disabled at (351475): [<c0105689>] do_softirq+0x59/0xcb

other info that might help us debug this:
3 locks held by udevd/415:
  #0:  (&inode->i_mutex/1){--..}, at: [<c018150e>] lookup_create+0x1e/0x77
 #1:  (inode_lock){--..}, at: [<c018bf13>] new_inode+0x27/0x8e
 #2:  (&base->lock#2){++..}, at: [<c012900a>] run_timer_softirq+0x3d/0x164

stack backtrace:
 [<c0103e52>] show_trace_log_lvl+0x4b/0xf4
 [<c01044b3>] show_trace+0xd/0x10
 [<c010457b>] dump_stack+0x19/0x1b
 [<c0137d63>] print_usage_bug+0x1a1/0x1ab
 [<c0138458>] mark_lock+0x2d7/0x514
 [<c01386dc>] mark_held_locks+0x47/0x65
 [<c0139745>] trace_hardirqs_on+0x12b/0x16f
 [<c02f2b91>] restore_nocheck+0x8/0xb

Here is dmesg
http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm1/mm-dmesg
Here is config
http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm1/mm-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
