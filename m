Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262877AbSJAWVp>; Tue, 1 Oct 2002 18:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262868AbSJAWUG>; Tue, 1 Oct 2002 18:20:06 -0400
Received: from packet.digeo.com ([12.110.80.53]:29421 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262863AbSJAWSN>;
	Tue, 1 Oct 2002 18:18:13 -0400
Message-ID: <3D9A207A.14BFF440@digeo.com>
Date: Tue, 01 Oct 2002 15:23:54 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Boman <aboman@nerdfest.org>,
       "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.39 "Sleeping function called from illegal context at 
 slab.c:1374"
References: <3D99885B.533C320D@aitel.hist.no> <3D99EF62.3A3E6932@digeo.com> <20021001215907.GA8273@midgaard.us>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Oct 2002 22:23:30.0769 (UTC) FILETIME=[2BED7410:01C26999]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Boman wrote:
> 
> * Andrew Morton (akpm@digeo.com) wrote:
> > Helge Hafting wrote:
> > >
> > > ..
> > >  [<c01146c4>]__might_sleep+0x54/0x60
> > >  [<c012dca0>]kmalloc+0x4c/0x130
> > >  [<c010b6b2>]sys_ioperm+0x82/0x11c
> > >  [<c0106fbb>]syscall_call+0x7/0xb
> > >
> >
> >
> > You up to trying this fix?
> >
> 
> This patch on 2.3.40+xfsfix didnt change anything here, while my trace
> does look different it seems to be related.

It's different.

> I get a similar oops when ide initializes during boot,

It's not an oops.  It's just a warning.

> 
>  Debug: sleeping function called from illegal context at slab.c:1374

See?  I added "Debug:" to the message ;)

>  Call Trace:
>   [__kmem_cache_alloc+255/272]__kmem_cache_alloc+0xff/0x110
>   [get_vm_area+38/256]get_vm_area+0x26/0x100
>   [__vmalloc+75/304]__vmalloc+0x4b/0x130
>   [vmalloc+34/48]vmalloc+0x22/0x30
>   [<e08fe502>]sg_init+0x82/0x130 [sg]
>   [<e09022c7>].rodata.str1.1+0x23/0x2b0 [sg]
>   [<e0903be0>]sg_fops+0x0/0x58 [sg]
>   [<e0903b20>]sg_template+0x0/0x94 [sg]

That is known - sg_init() is blatantly calling vmalloc under
write_lock_irqsave().
