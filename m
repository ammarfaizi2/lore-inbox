Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbVKHPB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbVKHPB1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 10:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbVKHPB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 10:01:27 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:64607 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964973AbVKHPBZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 10:01:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fgsd9CoJqhGV3N8e7qI1Xwcw7jl0MLMlvsnYrK6qTnz7RG5XlgUSe2ETR+fvSUb2LvLAWKpoDadYY5Vb2QZZEkGq1x6o0ZB6ELs9lzD0gLc+gPXAA5fd5suSrQURJURU5rKAwIdtFAezl82WovthSk3D4INHQ8otpZIxUD0ftx0=
Message-ID: <38bdcd1f0511080701p16e13ca4lebef1ed383dfbf0b@mail.gmail.com>
Date: Wed, 9 Nov 2005 00:01:24 +0900
From: Masanari Iida <standby24x7@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: oops with USB Storage on 2.6.14
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       linux-scsi@vger.kernel.org
In-Reply-To: <20051107204055.58a80072.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <38bdcd1f0510290511t65bb16cfkfd1e84fb301424f9@mail.gmail.com>
	 <20051107204055.58a80072.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/05, Andrew Morton <akpm@osdl.org> wrote:
> Masanari Iida <standby24x7@gmail.com> wrote:
> >
> > Hello,
> > I updated my system's kernel from 2.6.13.2 to 2.6.14,
> > then it oops when I connect my Digital Camera via USB connection
> > as USB storage device.
> > I went back to 2.6.14-rc1, still the same panic happen.
> > 2.6.13.2 and before, the kernel has been worked as expected.
> >
> > CPU Intel P4(2.4Ghz)
> > USB Device   Pentax Optio S40.
> >
> > Unable to handle kernel paging request at virtual address dc9d1f4c
> >  printing eip:
> > c02b44cc
> > *pde = 00073067
> > *pte = 1c9d1000
> > Oops: 0000 [#1]
> > SMP DEBUG_PAGEALLOC
> > Modules linked in: autofs e100 ipt_LOG ipt_state ip_conntrack
> > ipt_recent iptable
> > _filter ip_tables video rtc
> > CPU:    1
> > EIP:    0060:[<c02b44cc>]    Not tainted VLI
> > EFLAGS: 00010286   (2.6.14)
> > EIP is at scsi_run_queue+0xc/0xd0
> > eax: 00000001   ebx: dc9d1e3c   ecx: d6b67910   edx: dc9d1e3c
> > esi: d5048eb0   edi: dc9d1e3c   ebp: c1507e98   esp: c1507e84
> > ds: 007b   es: 007b   ss: 0068
> > Process ksoftirqd/1 (pid: 6, threadinfo=c1506000 task=dfe2dad0)
> > Stack: 00000292 de3a7bf8 dc9d1e3c d5048eb0 dc9d1e3c c1507ea8 c02b4612 dc9d1e3c
> >        da51bf60 c1507ecc c02b473f d5048eb0 00000000 00000024 00000286 00000001
> >        d5048eb0 00000000 c1507f10 c02b4b2e d5048eb0 00000000 00000024 00000001
> >
> > Call Trace:
> >  [<c0103abf>] show_stack+0x7f/0xa0
> >  [<c0103c72>] show_registers+0x162/0x1d0
> >  [<c0103e90>] die+0x100/0x1a0
> >  [<c039d7ae>] do_page_fault+0x31e/0x640
> >  [<c0103763>] error_code+0x4f/0x54
> >  [<c02b4612>] scsi_next_command+0x22/0x30
> >  [<c02b473f>] scsi_end_request+0xcf/0xf0
> >  [<c02b4b2e>] scsi_io_completion+0x26e/0x470
> >  [<c02b4fc7>] scsi_generic_done+0x37/0x50
> >  [<c02af9e5>] scsi_finish_command+0x85/0xa0
> >  [<c02af89c>] scsi_softirq+0xcc/0x140
> >  [<c0122085>] __do_softirq+0xd5/0xf0
> >  [<c01220d8>] do_softirq+0x38/0x40
> >  [<c0122685>] ksoftirqd+0x95/0xe0
> >  [<c0131cfa>] kthread+0xba/0xc0
> >  [<c0100ecd>] kernel_thread_helper+0x5/0x18
> > Code: f0 8b 42 44 e8 16 7f 0e 00 89 45 ec 89 1c 24 e8 6b b7 ff ff eb aa 89 f6 8d
> >  bc 27 00 00 00 00 55 89 e5 57 56 53 83 ec 08 8b 55 08 <8b> 82 10 01 00 00 8b 38
> >  f6 80 85 01 00 00 80 0f 85 9e 00 00 00
> >   <0>Kernel panic - not syncing: Fatal exception in interrupt
> >
>
> Has there been any progress on this?
>
> If not, can you please test the latest snapshot from
> ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots and if it still fails, raise a bug at bugzilla.kernel.org?
>
> Thanks.
>

Hello again, Andrew,

I have tested on 2.6.14-git10 with CONFIG_DEBUG_PAGEALLOC=y.
The original oops with USB Storage (Camera)  is fixed now.
Thank you.

Masanari
