Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWIVMed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWIVMed (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 08:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWIVMed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 08:34:33 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:65432 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S932384AbWIVMec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 08:34:32 -0400
Message-ID: <4513D747.7000003@s5r6.in-berlin.de>
Date: Fri, 22 Sep 2006 14:29:59 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Miles Lane <miles.lane@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 -- INFO: possible recursive locking detected
References: <a44ae5cd0609211447i41ae58f3xa59d2ae4c5dc5f65@mail.gmail.com>
In-Reply-To: <a44ae5cd0609211447i41ae58f3xa59d2ae4c5dc5f65@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:
> =============================================
> [ INFO: possible recursive locking detected ]
> ---------------------------------------------
> knodemgrd_1/13913 is trying to acquire lock:
>  (&s->rwsem){..--}, at: [<f8960817>] nodemgr_probe_ne+0x22d/0x36c [ieee1394]
> 
> but task is already holding lock:
>  (&s->rwsem){..--}, at: [<f89610d8>] nodemgr_host_thread+0x739/0x8a7 [ieee1394]

Thanks for the report.

There is already a fix in -mm and linux1394-2.6.git which will
presumably appear in 2.6.19-rc1.
http://kernel.org/git/?p=linux/kernel/git/ieee1394/linux1394-2.6.git;a=commitdiff_plain;h=9b516010863195ba7db061233a3eeffe779130e8

To verify the fix, you can probably apply this patch as-is to Linux
2.6.18. Alternatively you can get it with this patchset:
http://me.in-berlin.de/~s5r6/linux1394/updates/2.6.18-rc6/
(You need v159 or later to get the recursive locking fix. I will ready a
patchset against 2.6.18 soon but I expect it to be the same as against
2.6.18-rc6.)

> other info that might help us debug this:
> 1 lock held by knodemgrd_1/13913:
>  #0:  (&s->rwsem){..--}, at: [<f89610d8>]
> nodemgr_host_thread+0x739/0x8a7 [ieee1394]
> 
> stack backtrace:
>  [<c1003ef5>] show_trace_log_lvl+0x58/0x16a
>  [<c100506d>] show_trace+0xd/0x10
>  [<c1005087>] dump_stack+0x17/0x1c
>  [<c102e485>] __lock_acquire+0x79b/0x9ef
>  [<c102e9b6>] lock_acquire+0x5e/0x80
>  [<c102b73e>] down_read+0x28/0x3a
>  [<f8960817>] nodemgr_probe_ne+0x22d/0x36c [ieee1394]
>  [<f89610f7>] nodemgr_host_thread+0x758/0x8a7 [ieee1394]
>  [<c1001005>] kernel_thread_helper+0x5/0xb
> DWARF2 unwinder stuck at kernel_thread_helper+0x5/0xb
> Leftover inexact backtrace:
>  [<c100506d>] show_trace+0xd/0x10
>  [<c1005087>] dump_stack+0x17/0x1c
>  [<c102e485>] __lock_acquire+0x79b/0x9ef
>  [<c102e9b6>] lock_acquire+0x5e/0x80
>  [<c102b73e>] down_read+0x28/0x3a
>  [<f8960817>] nodemgr_probe_ne+0x22d/0x36c [ieee1394]
>  [<f89610f7>] nodemgr_host_thread+0x758/0x8a7 [ieee1394]
>  [<c1001005>] kernel_thread_helper+0x5/0xb
> ieee1394: send packet at S400: ffc0a140 ffc1ffff f0000234
> -

-- 
Stefan Richter
-=====-=-==- =--= =--==
http://arcgraph.de/sr/
