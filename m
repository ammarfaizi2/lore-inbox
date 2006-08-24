Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbWHXPVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbWHXPVR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 11:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWHXPVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 11:21:17 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:57793 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964993AbWHXPVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 11:21:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C2VsDznV6MgDIxSEv/cbqzlvqAeoJgZfz+m32/tKNc/yE8cf0b5/2LrZPnzlMjNe1DlFq8FUg7Fz2vomYLM7+qqmXH7w6zMITxduYj9Yd74/k3qTptzoiueEwkW+Oxs57YnYk7UHgpnTgmDKopTP0njN6TRlLwZXrvuP8slpbB0=
Message-ID: <6bffcb0e0608240821i57f2cbf1qd3a362311e94b9ef@mail.gmail.com>
Date: Thu, 24 Aug 2006 17:21:16 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: mm snapshot broken-out-2006-08-24-00-22.tar.gz uploaded
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060824073817.2f50f6e0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608240723.k7O7NsBB025642@shell0.pdx.osdl.net>
	 <6bffcb0e0608240452w6c17586djaab20855d9356139@mail.gmail.com>
	 <20060824073817.2f50f6e0.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/06, Andrew Morton <akpm@osdl.org> wrote:
> On Thu, 24 Aug 2006 13:52:28 +0200
> "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
>
> > Hi,
> >
> > On 24/08/06, akpm@osdl.org <akpm@osdl.org> wrote:
> > > The mm snapshot broken-out-2006-08-24-00-22.tar.gz has been uploaded to
> > >
> > >    ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/broken-out-2006-08-24-00-22.tar.gz
> > >
> > > It contains the following patches against 2.6.18-rc4:
> >
> > I haven't seen this on 2.6.18-rc4-mm2. Any idea which patch is causing
> > this soft lockup?
> >
> > BUG: soft lockup detected on CPU#0!
> > [<c01041b5>] dump_trace+0x64/0x1b2
> > [<c0104315>] show_trace_log_lvl+0x12/0x25
> > [<c0104985>] show_trace+0xd/0x10
> > [<c0104a4d>] dump_stack+0x19/0x1b
> > [<c014f40d>] softlockup_tick+0xc5/0xd9
> > [<c012a0c7>] run_local_timers+0x12/0x14
> > [<c012a329>] update_process_times+0x40/0x65
> > [<c0113cc7>] smp_apic_timer_interrupt+0x6e/0x77
> > [<c0103ce2>] apic_timer_interrupt+0x2a/0x30
> > DWARF2 unwinder stuck at apic_timer_interrupt+0x2a/0x30
> > Leftover inexact backtrace:
>
> Sigh, useless.
>
> > [<c0104315>] show_trace_log_lvl+0x12/0x25
> > [<c0104985>] show_trace+0xd/0x10
> > [<c0104a4d>] dump_stack+0x19/0x1b
> > [<c014f40d>] softlockup_tick+0xc5/0xd9
> > [<c012a0c7>] run_local_timers+0x12/0x14
> > [<c012a329>] update_process_times+0x40/0x65
> > [<c0113cc7>] smp_apic_timer_interrupt+0x6e/0x77
> > [<c0103ce2>] apic_timer_interrupt+0x2a/0x30
> > [<c01f3010>] __delay+0x9/0xb
> > [<c01ffc47>] _raw_spin_lock+0xca/0x11d
> > [<c02f86a8>] _spin_lock+0x2a/0x32
> > [<c013cc4e>] do_futex+0xee/0xd9a
> > [<c013d9d4>] sys_futex+0xda/0xf0
> > [<c01031b5>] sysenter_past_esp+0x56/0x8d
>
>
> There are a couple of recent futex changes, but they're fairly
> innocent-looking.  What is the workload?
>
>

This script -> http://www.stardust.webpages.pl/files/mm/2.6.18-rc4-mm3/test_mount_fs.sh
+ Amarok.

ls -sh /home/fs-farm/
razem 3,6G
513M ext2.img  513M ext3.img  513M ext4.img  513M jfs.img  513M
reiser3.img  513M reiser4.img  513M xfs.img

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
