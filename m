Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262673AbSI1BS4>; Fri, 27 Sep 2002 21:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262674AbSI1BS4>; Fri, 27 Sep 2002 21:18:56 -0400
Received: from packet.digeo.com ([12.110.80.53]:37776 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262673AbSI1BSy>;
	Fri, 27 Sep 2002 21:18:54 -0400
Message-ID: <3D9504B7.1C8CB675@digeo.com>
Date: Fri, 27 Sep 2002 18:24:07 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Luc Van Oostenryck <luc.vanoostenryck@easynet.be>,
       Greg KH <greg@kroah.com>, Thomas Molina <tmolina@cox.net>
CC: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: (more) Sleeping function called from illegal context...
References: <20020927233044.GA14234@kroah.com> <3D94EEBF.D6328392@digeo.com> <3D94FB57.40507@easynet.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Sep 2002 01:24:08.0188 (UTC) FILETIME=[BDE15BC0:01C2668D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luc Van Oostenryck wrote:
> 
> With CONFIG_PREEMPT=y on an SMP AMD (2CPU):
> 
> Sleeping function called from illegal context at /kernel/l-2.5.39/include/asm/semaphore.h:119
> c1b4ff7c c0117094 c0280b00 c02bc680 00000077 f7f78540 c01ffc8c c02bc680
>         00000077 c1b4e000 c1b4e000 00000001 c1b4ffdc c1b4ffc0 00000206 f7f78568
>         c1b4e000 00000001 c1b4ffdc c01fff35 c01fff00 00000000 00000000 00000000
> Call Trace:
>   [<c0117094>]__might_sleep+0x54/0x58
>   [<c01ffc8c>]usb_hub_events+0x6c/0x2e0
>   [<c01fff35>]usb_hub_thread+0x35/0xe0
>   [<c01fff00>]usb_hub_thread+0x0/0xe0
>   [<c0115500>]default_wake_function+0x0/0x40
>   [<c010553d>]kernel_thread_helper+0x5/0x18

usb_hub_events() does down() inside hub_event_lock.
