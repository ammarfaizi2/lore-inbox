Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262393AbSI2FCg>; Sun, 29 Sep 2002 01:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262397AbSI2FCg>; Sun, 29 Sep 2002 01:02:36 -0400
Received: from packet.digeo.com ([12.110.80.53]:8609 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262393AbSI2FCf>;
	Sun, 29 Sep 2002 01:02:35 -0400
Message-ID: <3D968AA7.C4054EB@digeo.com>
Date: Sat, 28 Sep 2002 22:07:51 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: thunder7@xs4all.nl, Thomas Molina <tmolina@cox.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.39: SMP, pre-empt, ide-scsi 'sleeping function called from 
 illegal context' during boot
References: <20020929044524.GA739@middle.of.nowhere>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Sep 2002 05:07:52.0359 (UTC) FILETIME=[29B90B70:01C26776]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurriaan wrote:
> 
> ...
> Call Trace:
>  [<c0118554>]__might_sleep+0x54/0x58
>  [<c0135dd3>]kmalloc+0x5b/0x1d4
>  [<c0134905>]get_vm_area+0x29/0x11c
>  [<c0134bf2>]__vmalloc+0x32/0x10c
>  [<c0134ce1>]vmalloc+0x15/0x1c
>  [<c021680c>]sg_init+0xa0/0x138
>  [<c01fcace>]scsi_register_device+0x76/0x120
>  [<c01050ab>]init+0x47/0x1bc
>  [<c0105064>]init+0x0/0x1bc
>  [<c0105501>]kernel_thread_helper+0x5/0xc
> 

sg_init() is performing vmalloc() inside
write_lock_irqsave(&sg_dev_arr_lock);
