Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTECNai (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 09:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTECNai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 09:30:38 -0400
Received: from smtp.terra.es ([213.4.129.129]:11557 "EHLO tsmtp6.mail.isp")
	by vger.kernel.org with ESMTP id S263310AbTECNah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 09:30:37 -0400
Date: Sat, 3 May 2003 15:51:42 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Andrew Morton <akpm@digeo.com>
Cc: mb--lkml@dcs.qmul.ac.uk, ak@muc.de, elenstev@mesatop.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.68-mm4
Message-Id: <20030503155142.06b0f714.diegocg@teleline.es>
In-Reply-To: <20030502164159.4434e5f1.akpm@digeo.com>
References: <20030502020149.1ec3e54f.akpm@digeo.com>
	<1051905879.2166.34.camel@spc9.esa.lanl.gov>
	<20030502133405.57207c48.akpm@digeo.com>
	<1051908541.2166.40.camel@spc9.esa.lanl.gov>
	<20030502140508.02d13449.akpm@digeo.com>
	<1051910420.2166.55.camel@spc9.esa.lanl.gov>
	<Pine.LNX.4.55.0305030014130.1304@jester.mews>
	<20030502164159.4434e5f1.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 May 2003 16:41:59 -0700
Andrew Morton <akpm@digeo.com> wrote:

> > 	http://www.dcs.qmul.ac.uk/~mb/oops/
> > 
> 
> Andi, it died in the middle of modprobe->apply_alternatives()

I just got this oops under -mm4 while connecting with a ppp link:

Probably it was modprobe'ing one of those:

ppp_deflate             5312  0 [unsafe]
zlib_deflate           21912  1 ppp_deflate
zlib_inflate           21408  1 ppp_deflate
bsd_comp                5600  0 [unsafe]
ppp_async              10496  1 [unsafe]
ppp_generic            27080  5 ppp_deflate,bsd_comp,ppp_async
slhc                    5952  1 ppp_generic


CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
Unable to handle kernel paging request at virtual address c03390df
 printing eip:
c0110a39
*pde = 00102027
*pte = 00339000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0110a39>]    Not tainted VLI
EFLAGS: 00013202
EIP is at apply_alternatives+0xd9/0x120
eax: 00000001   ebx: d088fb8c   ecx: 00000000   edx: 00000001
esi: c03390df   edi: d08898cf   ebp: ccfe5eec   esp: ccfe5ed8
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 375, threadinfo=ccfe4000 task=ce236690)
Stack: c02f68e0 00000003 d0883880 0000008f d08835b7 ccfe5f0c c011a436 d088fb8c
       d088fc1b d0883504 d087c000 d0891b20 00000460 ccfe5f94 c013c8ae d087c000
       d0883600 d0891b20 00000016 d0891b20 00000000 00000000 00000000 00000488
Call Trace:
 [<c011a436>] module_finalize+0x96/0xa0
 [<c013c8ae>] load_module+0x64e/0x870
 [<c013cb6c>] sys_init_module+0x9c/0x2b0
 [<c0109aef>] syscall_call+0x7/0xb

Code: 00 00 8b 0b 83 fa 09 b8 08 00 00 00 0f 4c c2 8b 7d f0 01 cf 8b 4d ec 8b 34
 81 89 c1 c1 e9 02 f3 a5 a8 02 74 02 66 a5 a8 01 74 01 <a4> 01 45 f0 29 c2 85 d2
 7f cd 83 c3 0c 3b 5d 0c 0f 82 71 ff ff




