Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbTJHXSX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 19:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTJHXSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 19:18:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:59300 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261817AbTJHXSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 19:18:22 -0400
Subject: Re: 2.6.0-test6-mm4 - oops in __aio_run_iocbs()
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>, Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <20031005013326.3c103538.akpm@osdl.org>
References: <20031005013326.3c103538.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1065655095.1842.34.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Oct 2003 16:18:15 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm been testing AIO on test6-mm4 using a ext3 file system and
copying a 88MB file to an already existing preallocated file of 88MB.
I been using my aiocp program to copy the file using i/o sizes of
1k to 512k and outstanding aio requests of between 1 and 64 using
O_DIRECT, O_SYNC and O_DIRECT & O_SYNC.  Everything works as long
as the file is pre-allocated.  When copying the file to a new file
(O_CREAT|O_DIRECT), I get the following oops:


Unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
c018fa34
*pde = 00000000
Oops: 0000 [#1]
SMP
CPU:    1
EIP:    0060:[<c018fa34>]    Not tainted VLI
EFLAGS: 00010002
EIP is at __aio_run_iocbs+0x19/0xa2
eax: 00000000   ebx: d443b318   ecx: d4055c78   edx: 6b6b6b6b
esi: d4055c78   edi: d4055cb0   ebp: dfd6df48   esp: dfd6df34
ds: 007b   es: 007b   ss: 0068
Process aio/1 (pid: 16, threadinfo=dfd6c000 task=dfd71340)
Stack: 00010000 dfd71914 d4055c78 d4055c9c dfd72790 dfd6df68 c018faf6 d4055c78
       dfd6df54 dfd6df54 dfd6c000 d4055cfc 00000287 dfd6dfec c0138ad8 d4055c78
       dfd6dfa0 00000000 5a5a5a5a dfd727b8 dfd727a8 d4055c78 c018fabd dfd727a0

Call Trace:
 [<c018faf6>] aio_kick_handler+0x39/0x96
 [<c0138ad8>] worker_thread+0x1e6/0x346
 [<c018fabd>] aio_kick_handler+0x0/0x96
 [<c0122041>] default_wake_function+0x0/0x2e


Daniel

