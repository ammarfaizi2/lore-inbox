Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262853AbSJAXob>; Tue, 1 Oct 2002 19:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262871AbSJAXob>; Tue, 1 Oct 2002 19:44:31 -0400
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:33263 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262853AbSJAXoa> convert rfc822-to-8bit; Tue, 1 Oct 2002 19:44:30 -0400
Subject: Re: 2.4.39 "Sleeping function called from illegal context at 
	slab.c:1374"
From: Joaquim Fellmann <mljf@altern.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Andreas Boman <aboman@nerdfest.org>, linux-kernel@vger.kernel.org
In-Reply-To: <3D9A207A.14BFF440@digeo.com>
References: <3D99885B.533C320D@aitel.hist.no> <3D99EF62.3A3E6932@digeo.com>
	<20021001215907.GA8273@midgaard.us>  <3D9A207A.14BFF440@digeo.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 
Date: 02 Oct 2002 01:24:02 +0200
Message-Id: <1033514643.451.7.camel@kro>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer 02/10/2002 à 00:23, Andrew Morton a écrit :


> >  Call Trace:
> >   [__kmem_cache_alloc+255/272]__kmem_cache_alloc+0xff/0x110
> >   [get_vm_area+38/256]get_vm_area+0x26/0x100
> >   [__vmalloc+75/304]__vmalloc+0x4b/0x130
> >   [vmalloc+34/48]vmalloc+0x22/0x30
> >   [<e08fe502>]sg_init+0x82/0x130 [sg]
> >   [<e09022c7>].rodata.str1.1+0x23/0x2b0 [sg]
> >   [<e0903be0>]sg_fops+0x0/0x58 [sg]
> >   [<e0903b20>]sg_template+0x0/0x94 [sg]
> 
> That is known - sg_init() is blatantly calling vmalloc under
> write_lock_irqsave().

Hye,

is that the same problem ?
Apparently it's not scsi related as the one above:

Debug: sleeping function called from illegal context at slab.c:1374
c72a5f60 c01170b4 c02809c0 c0284df1 0000055e c72dfc80 c01311aa c0284df1
0000055e 00000000 00000400 bffffd24 c72dfc80 c01aebcf c72df960 00000011
c010d142 00000080 000001d0 c72a4000 00000100 bffffd24 bffffc2c 00000000
Call Trace:
[<c01170b4>]__might_sleep+0x54/0x60
[<c01311aa>]kmalloc+0x56/0x214
[<c01aebcf>]capable+0x1b/0x34
[<c010d142>]sys_ioperm+0x82/0x11c
[<c0108a3f>]syscall_call+0x7/0xb


It's from a 2.5.40 pulled from bk.

Regards

-- 
Joaquim Fellmann


