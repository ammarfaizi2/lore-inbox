Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264416AbTK0BIf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 20:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264418AbTK0BIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 20:08:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:1667 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264416AbTK0BId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 20:08:33 -0500
Date: Wed, 26 Nov 2003 17:15:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Jensen <ej@xmission.com>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: PROBLEM: 2.6.0-test10 BUG/panic in mpage_end_io_read
Message-Id: <20031126171522.6a5fbd24.akpm@osdl.org>
In-Reply-To: <20031126174726.B22441@xmission.xmission.com>
References: <20031126174726.B22441@xmission.xmission.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Jensen <ej@xmission.com> wrote:
>
> kernel BUG at mm/filemap.c:332!
>  invalid operand: 0000 [#1]
>  CPU:    0
>  EIP:    0060:[<c0130f4a>]    Not tainted
>  EFLAGS: 00010246
>  EIP is at unlock_page+0x1a/0x40
>  eax: 00000000   ebx: c1083b08   ecx: 00000017   edx: c1500400
>  esi: c1500cf4   edi: 00000001   ebp: 00000003   esp: dfcc1f0c
>  ds: 007b   es: 007b   ss: 0068
>  Process md0_raid5 (pid: 17, threadinfo=dfcc0000 task=dfcdd2d0)
>  Stack: dffd2e34 cbe5f540 c016201e cbe5f540 dfbcd298 ffffffff dfbcd298 c02a2f75
>         cbe5f540 00000000 00000000 dfbcd298 dfd20b00 dff7ae00 dfd20b08 c17f872c
>  	   c17f8764 00000000 dff7ae74 00000000 00000002 00000001 00000004 ffffffff
>  Call Trace:
>   [<c016201e>] mpage_end_io_read+0x5e/0x80
>   [<c02a2f75>] handle_stripe+0x9e5/0xb30
>   [<c02a341c>] raid5d+0xec/0x110
>   [<c02a9af9>] md_thread+0xf9/0x140
>   [<c02a9a00>] md_thread+0x0/0x140

Could be that the MD layer is calling ->bi_end_io() more than once
for a particular BIO.

