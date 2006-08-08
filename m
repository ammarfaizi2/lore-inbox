Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbWHHVF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbWHHVF2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWHHVF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:05:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52115 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964940AbWHHVF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:05:27 -0400
Date: Tue, 8 Aug 2006 14:05:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>,
       Jan Beulich <jbeulich@novell.com>
Subject: Re: mm snapshot broken-out-2006-08-08-00-59.tar.gz uploaded
Message-Id: <20060808140511.def9b13c.akpm@osdl.org>
In-Reply-To: <6bffcb0e0608081329r732e191dsec0f391ea70f7d28@mail.gmail.com>
References: <200608080800.k7880noU028915@shell0.pdx.osdl.net>
	<6bffcb0e0608081329r732e191dsec0f391ea70f7d28@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2006 22:29:03 +0200
"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:

> Hi Andrew,
> 
> On 08/08/06, akpm@osdl.org <akpm@osdl.org> wrote:
> > The mm snapshot broken-out-2006-08-08-00-59.tar.gz has been uploaded to
> >
> >    ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/mm/broken-out-2006-08-08-00-59.tar.gz
> >
> > It contains the following patches against 2.6.18-rc4:
> 
> It appears very early. 2.6.18-rc3-mm2 was fine.
> 
> DWARF2 unwinder stuck at error_code+0x39/0x40

The novelty of this thing has worn off.  Guys, please let's not release 2.6.18 in
this state.

> Leftover inexact backtrace
> [<c0104194>] show_stack_log_lvl+0x8c/0x97
> [<c0104320>] show_registers+0x181/0x215
> [<c0104576>] die+0x1c2/0x2dd
> [<c0117419>] do_page_fault+ox410/0x4f3
> [<c02f5271>] error_code+0x39/0x40
> [<c0104194>] show_stack_log_lvl+0x8c/0x97
> [<c0104320>] show_registers+0x181/0x215
> [<c0104576>] die+0x1c2/0x2dd
> [<c0117419>] do_page_fault+0x410/0x4f3
> [<c02f5271>] error_code+0x39/0x40
> [<c047b609>] start_kernel+0x224/0x3a2
> [<c0100210>] 0xc0100210
> Code: 00 39 .......
> EIP:[<c01040ca>] show_trace_log_lvl+0x11b/0x159 SS:ESP 0068:c0479e74
> <0> Kernel panic - not syncing: Attempted to kill idle task!
> 
> http://www.stardust.webpages.pl/files/mm/2.6.18-rc4-mm1/mm-config
> 

So I guess the dwarf unwinder oopsed and wrecked our oops.  Perhaps you'll
get better info with CONFIG_UNWIND_INFO=n, CONFIG_STACK_UNWIND=n.

Now, _perhaps_ it oopsed at "[<c047b609>] start_kernel+0x224/0x3a2".  You
can look these things up in gdb or using addr2line, provided you have
CONFIG_DEBUG_INFO=y.

