Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbWHHVTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbWHHVTM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbWHHVTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:19:12 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:38550 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030274AbWHHVTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:19:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C90FGvmhCo47AO6dcafTDFYWju4LhroUTyq81RojU/0k35TemLthjT379+4tb0d3U0aR14lIhrKN+oCQz9yj3vKSDCyQ9wSm0fJvLJiTDzWMrNJmyX3pKVJRgOmOCsdkc8mmP2btP9DBeUtadrquYuKQYhdrEhoAXg5NfTi4AzM=
Message-ID: <6bffcb0e0608081419p4430b5cei7b4aa990cd0d4422@mail.gmail.com>
Date: Tue, 8 Aug 2006 23:19:09 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: mm snapshot broken-out-2006-08-08-00-59.tar.gz uploaded
Cc: linux-kernel@vger.kernel.org, "Andi Kleen" <ak@muc.de>,
       "Jan Beulich" <jbeulich@novell.com>
In-Reply-To: <20060808140511.def9b13c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200608080800.k7880noU028915@shell0.pdx.osdl.net>
	 <6bffcb0e0608081329r732e191dsec0f391ea70f7d28@mail.gmail.com>
	 <20060808140511.def9b13c.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/06, Andrew Morton <akpm@osdl.org> wrote:
> On Tue, 8 Aug 2006 22:29:03 +0200
> "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
>
> > Hi Andrew,
> >
> > On 08/08/06, akpm@osdl.org <akpm@osdl.org> wrote:
> > > The mm snapshot broken-out-2006-08-08-00-59.tar.gz has been uploaded to
> > >
> > >    ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/broken-out-2006-08-08-00-59.tar.gz
> > >
> > > It contains the following patches against 2.6.18-rc4:
> >
> > It appears very early. 2.6.18-rc3-mm2 was fine.
> >
> > DWARF2 unwinder stuck at error_code+0x39/0x40
>
> The novelty of this thing has worn off.  Guys, please let's not release 2.6.18 in
> this state.
>
> > Leftover inexact backtrace
> > [<c0104194>] show_stack_log_lvl+0x8c/0x97
> > [<c0104320>] show_registers+0x181/0x215
> > [<c0104576>] die+0x1c2/0x2dd
> > [<c0117419>] do_page_fault+ox410/0x4f3
> > [<c02f5271>] error_code+0x39/0x40
> > [<c0104194>] show_stack_log_lvl+0x8c/0x97
> > [<c0104320>] show_registers+0x181/0x215
> > [<c0104576>] die+0x1c2/0x2dd
> > [<c0117419>] do_page_fault+0x410/0x4f3
> > [<c02f5271>] error_code+0x39/0x40
> > [<c047b609>] start_kernel+0x224/0x3a2
> > [<c0100210>] 0xc0100210
> > Code: 00 39 .......
> > EIP:[<c01040ca>] show_trace_log_lvl+0x11b/0x159 SS:ESP 0068:c0479e74
> > <0> Kernel panic - not syncing: Attempted to kill idle task!
> >
> > http://www.stardust.webpages.pl/files/mm/2.6.18-rc4-mm1/mm-config
> >
>
> So I guess the dwarf unwinder oopsed and wrecked our oops.  Perhaps you'll
> get better info with CONFIG_UNWIND_INFO=n, CONFIG_STACK_UNWIND=n.
>
> Now, _perhaps_ it oopsed at "[<c047b609>] start_kernel+0x224/0x3a2".

eghm... typo.
[<c047d609>]

>  You
> can look these things up in gdb or using addr2line, provided you have
> CONFIG_DEBUG_INFO=y.
>
>

(gdb) list *0xc047d609
0xc047d609 is in start_kernel (/usr/src/linux-work1/init/main.c:577).
572             cpuset_init_early();
573             mem_init();
574             kmem_cache_init();
575             setup_per_cpu_pageset();
576             numa_policy_init();
577             if (late_time_init)
578                     late_time_init();
579             calibrate_delay();
580             pidmap_init();
581             pgtable_cache_init();

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
