Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263724AbTJORYd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 13:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbTJORYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 13:24:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:38072 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263724AbTJORYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 13:24:30 -0400
Date: Wed, 15 Oct 2003 10:28:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bradley Chapman <kakadu_croc@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: 2.6.0-test7-mm1
Message-Id: <20031015102810.4017950f.akpm@osdl.org>
In-Reply-To: <20031015123444.46223.qmail@web40904.mail.yahoo.com>
References: <20031015032215.58d832c1.akpm@osdl.org>
	<20031015123444.46223.qmail@web40904.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bradley Chapman <kakadu_croc@yahoo.com> wrote:
>
> You're welcome. Unfortunately I got this non-fatal Oops when I first booted:
> 
>  ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
>  ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[e8207000-e82077ff]  Max
>  Packet=[2048]
>  Debug: sleeping function called from invalid context at mm/slab.c:1869
>  in_atomic():1, irqs_disabled():0
>  Call Trace:
>   [<c0123fc6>] __might_sleep+0xa0/0xc2
>   [<c0156bc4>] __kmalloc+0x204/0x216
>   [<e08a9ed4>] hpsb_create_hostinfo+0x6b/0xe8 [ieee1394]
>   [<e08af0e6>] nodemgr_add_host+0x23/0x1d2 [ieee1394]
>   [<c0216bd4>] sprintf+0x1f/0x23
>   [<e08aa789>] highlevel_add_host+0x6b/0x6f [ieee1394]
>   [<e08a9cce>] hpsb_add_host+0x6d/0x95 [ieee1394]

highlevel_add_host() does read_lock() and then proceeds to do things like
starting kernel threads under that lock.  The locking is pretty broken
in there :(


