Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbTKTBH1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 20:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbTKTBH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 20:07:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:967 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261190AbTKTBH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 20:07:26 -0500
Date: Wed, 19 Nov 2003 17:07:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: pinotj@club-internet.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Message-Id: <20031119170753.06ba5fb2.akpm@osdl.org>
In-Reply-To: <mnet1.1069265993.8009.pinotj@club-internet.fr>
References: <mnet1.1069265993.8009.pinotj@club-internet.fr>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pinotj@club-internet.fr wrote:
>
> kernel BUG at mm/slab.c:1957!
> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[free_block+336/752]    Not tainted
> EIP:    0060:[<c015ad40>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010096
> eax: 00000045   ebx: 00000006   ecx: c0693854   edx: c056e4f8
> esi: cd09a000   edi: cd09a018   ebp: cf821c68   esp: cf821c3c
> ds: 007b   es: 007b   ss: 0068
> Stack: c0502240 c0502e1d cd09af18 c0652a00 00000001 0000003a cd09af18 0000000f
>        cffdef08 c4bcd180 00000010 cf821ca0 c015afba cffed800 cffdef08 00000010
>        00000282 c1161ca0 00000000 00000001 cffee730 00000010 00010c00 c4bcd180
> Call Trace:
>  [<c015afba>] cache_flusharray+0xda/0x2b0
>  [<c015b7ad>] kmem_cache_free+0x1ad/0x3a0
>  [<c018158c>] free_buffer_head+0x2c/0x60
>  [<c018158c>] free_buffer_head+0x2c/0x60

urgh, there are several reports of this and it's always the buffer_head
slab.  The code in there is trivial so perhaps it's just that the large
number of buffer_heads makes them a fat target.

You should have also seen the message "slab: double free detected in cache
'buffer_head', objp 0xNNNNNNNN".

Don't know, sorry.
