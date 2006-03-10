Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWCJRWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWCJRWy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 12:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWCJRWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 12:22:54 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:64643
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932182AbWCJRWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 12:22:54 -0500
Subject: Re: 2.6.16-rc5 pppd oops on disconnects
From: Paul Fulghum <paulkf@microgate.com>
To: Bob Copeland <bcopeland@gmail.com>
Cc: paulus@samba.org, Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <b6c5339f0603100625k3410897fy3515d93fa1918c9@mail.gmail.com>
References: <b6c5339f0603100625k3410897fy3515d93fa1918c9@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 11:22:20 -0600
Message-Id: <1142011340.3220.4.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 09:25 -0500, Bob Copeland wrote:
> Unable to handle kernel paging request at virtual address 6b6b6bfb
>  printing eip:
> c027a4f6
> *pde = 00000000
> Oops: 0000 [#1]
> ...
> CPU:    0
> EIP:    0060:[<c027a4f6>]    Not tainted VLI
> EFLAGS: 00210046   (2.6.16-rc5 #16)
> EIP is at __mutex_lock_slowpath+0x70/0x286
> eax: cf549e20   ebx: cf548000   ecx: 00000000   edx: 00000054
> esi: 6b6b6bdb   edi: cea6f030   ebp: c017592e   esp: cf549e20
> ds: 007b   es: 007b   ss: 0068
> Process pppd (pid: 4076, threadinfo=cf548000 task=cea6f030)
> Stack: <0>cf549e20 cf549e20 11111111 11111111 cf549e20 cce32c60
> cf609cc4 cf609ccc
>        cf609c60 c017592e ccabf7a0 cce5466c 6b6b6b6b cce32c60 cf609cc4 cf609ccc
>        cf609c60 c01e756e cce5466c ccabf7a0 cd619aac c029fd21 00000000 ccabf7a0
> Call Trace:
>  [<c017592e>] sysfs_hash_and_remove+0x34/0x10a
>  [<c01e756e>] class_device_del+0xa0/0x11c
>  [<c01e75f5>] class_device_unregister+0xb/0x16
>  [<d01f81f3>] acm_tty_unregister+0x1d/0x63 [cdc_acm]

This looks more like
http://bugzilla.kernel.org/show_bug.cgi?id=5876

The offset from 6b6b6b6b looks like slab poisoning on
the dentry in sysfs_hash_and_remove.

-- 
Paul Fulghum
Microgate Systems, Ltd

