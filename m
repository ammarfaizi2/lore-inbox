Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbVBCPJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbVBCPJR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 10:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263708AbVBCPIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 10:08:13 -0500
Received: from smtp08.web.de ([217.72.192.226]:22417 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S263410AbVBCPGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 10:06:30 -0500
Message-ID: <42023DC4.4020100@web.de>
Date: Thu, 03 Feb 2005 16:05:40 +0100
From: Victor Hahn <victorhahn@web.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Really annoying bug in the mouse driver
References: <41E91795.9060609@web.de>	 <200502011819.12304.dtor_core@ameritech.net> <42006E79.7070503@web.de>	 <200502020126.37621.dtor_core@ameritech.net> <4200A9F3.80908@web.de> <d120d50005020207443ceb8704@mail.gmail.com>
In-Reply-To: <d120d50005020207443ceb8704@mail.gmail.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:

>Processor load we usually handle well, loaded disks are usually the
>ones that cause >= 0.5 sec delays between bytes received by psmouse.
>Please let me know if it still works with busy disks.
>  
>
Yes, it does work. I was copying several gigs from one partition to 
another and in the meantime copying some data to another computer via a 
100Mbit link and I didn't encounter any problems.

Since I use kernel 2.6.11-rc2 with your patch, I sometimes get a lot of 
very strange messages in /var/log/messages and on the terminal I'm 
currently working with. I mean something like this:

Feb  3 16:02:08 localhost kernel: Badness in local_bh_enable at 
kernel/softirq.c:140
Feb  3 16:02:08 localhost kernel:  [<c0122058>] local_bh_enable+0x88/0x90
Feb  3 16:02:08 localhost kernel:  [<f8a4e1d5>] 
ppp_send_frame+0x225/0x460 [ppp_generic]
Feb  3 16:02:08 localhost kernel:  [<c0125b69>] __mod_timer+0xf9/0x140
Feb  3 16:02:08 localhost kernel:  [<f8a4df42>] 
ppp_xmit_process+0x62/0xd0 [ppp_generic]
Feb  3 16:02:08 localhost kernel:  [<f8a4dbdc>] 
ppp_start_xmit+0xdc/0x250 [ppp_generic]
Feb  3 16:02:08 localhost kernel:  [<c03590bd>] qdisc_restart+0x14d/0x1c0
Feb  3 16:02:08 localhost kernel:  [<c034cbaf>] dev_queue_xmit+0x1cf/0x270
Feb  3 16:02:08 localhost kernel:  [<c0369a4d>] ip_finish_output2+0xdd/0x1b0
Feb  3 16:02:08 localhost kernel:  [<c0369970>] ip_finish_output2+0x0/0x1b0
Feb  3 16:02:08 localhost kernel:  [<c0357fa1>] nf_hook_slow+0xf1/0x130
Feb  3 16:02:08 localhost kernel:  [<c0369970>] ip_finish_output2+0x0/0x1b0
Feb  3 16:02:08 localhost kernel:  [<c0369940>] dst_output+0x0/0x30
Feb  3 16:02:08 localhost kernel:  [<c03673b5>] ip_finish_output+0x205/0x210
Feb  3 16:02:08 localhost kernel:  [<c0369970>] ip_finish_output2+0x0/0x1b0
Feb  3 16:02:08 localhost kernel:  [<c0369940>] dst_output+0x0/0x30
Feb  3 16:02:08 localhost kernel:  [<c0369954>] dst_output+0x14/0x30
Feb  3 16:02:08 localhost kernel:  [<c0357fa1>] nf_hook_slow+0xf1/0x130
Feb  3 16:02:08 localhost kernel:  [<c0369940>] dst_output+0x0/0x30
Feb  3 16:02:08 localhost kernel:  [<c03679bd>] ip_queue_xmit+0x3cd/0x4f0
Feb  3 16:02:08 localhost kernel:  [<c0369940>] dst_output+0x0/0x30
Feb  3 16:02:08 localhost kernel:  [<c036243b>] 
ip_route_output_slow+0x40b/0x880
Feb  3 16:02:08 localhost kernel:  [<c037e8e1>] tcp_v4_send_check+0x51/0xf0
Feb  3 16:02:08 localhost kernel:  [<c03787d0>] tcp_transmit_skb+0x440/0x730
Feb  3 16:02:08 localhost kernel:  [<c037af59>] tcp_connect+0x2c9/0x370
Feb  3 16:02:08 localhost kernel:  [<c037da54>] tcp_v4_connect+0x604/0xb90
Feb  3 16:02:08 localhost kernel:  [<c0342f76>] sock_aio_write+0xf6/0x120
Feb  3 16:02:08 localhost kernel:  [<c038dd1b>] 
inet_stream_connect+0x8b/0x1b0
Feb  3 16:02:08 localhost kernel:  [<c0343f43>] sys_connect+0x83/0xb0
Feb  3 16:02:08 localhost kernel:  [<c0342886>] sock_map_fd+0x116/0x140
Feb  3 16:02:08 localhost kernel:  [<c034385b>] __sock_create+0xfb/0x2a0
Feb  3 16:02:08 localhost kernel:  [<c020b522>] copy_from_user+0x42/0x70
Feb  3 16:02:08 localhost kernel:  [<c03449d1>] sys_socketcall+0xb1/0x260
Feb  3 16:02:08 localhost kernel:  [<c016ff4a>] sys_ioctl+0xaa/0x220
Feb  3 16:02:08 localhost kernel:  [<c0103257>] syscall_call+0x7/0xb
Feb  3 16:02:08 localhost kernel: Badness in local_bh_enable at 
kernel/softirq.c:140
Feb  3 16:02:08 localhost kernel:  [<c0122058>] local_bh_enable+0x88/0x90
Feb  3 16:02:08 localhost kernel:  [<f8a4dbdc>] 
ppp_start_xmit+0xdc/0x250 [ppp_generic]
Feb  3 16:02:08 localhost kernel:  [<c03590bd>] qdisc_restart+0x14d/0x1c0
Feb  3 16:02:08 localhost kernel:  [<c034cbaf>] dev_queue_xmit+0x1cf/0x270
Feb  3 16:02:08 localhost kernel:  [<c0369a4d>] ip_finish_output2+0xdd/0x1b0
Feb  3 16:02:08 localhost kernel:  [<c0369970>] ip_finish_output2+0x0/0x1b0
Feb  3 16:02:08 localhost kernel:  [<c0357fa1>] nf_hook_slow+0xf1/0x130
Feb  3 16:02:08 localhost kernel:  [<c0369970>] ip_finish_output2+0x0/0x1b0
Feb  3 16:02:08 localhost kernel:  [<c0369940>] dst_output+0x0/0x30
Feb  3 16:02:08 localhost kernel:  [<c03673b5>] ip_finish_output+0x205/0x210
Feb  3 16:02:08 localhost kernel:  [<c0369970>] ip_finish_output2+0x0/0x1b0
Feb  3 16:02:08 localhost kernel:  [<c0369940>] dst_output+0x0/0x30
Feb  3 16:02:08 localhost kernel:  [<c0369954>] dst_output+0x14/0x30
Feb  3 16:02:08 localhost kernel:  [<c0357fa1>] nf_hook_slow+0xf1/0x130
Feb  3 16:02:08 localhost kernel:  [<c0369940>] dst_output+0x0/0x30
Feb  3 16:02:08 localhost kernel:  [<c03679bd>] ip_queue_xmit+0x3cd/0x4f0
Feb  3 16:02:08 localhost kernel:  [<c0369940>] dst_output+0x0/0x30
Feb  3 16:02:08 localhost kernel:  [<c036243b>] 
ip_route_output_slow+0x40b/0x880
Feb  3 16:02:08 localhost kernel:  [<c037e8e1>] tcp_v4_send_check+0x51/0xf0
Feb  3 16:02:08 localhost kernel:  [<c03787d0>] tcp_transmit_skb+0x440/0x730
Feb  3 16:02:08 localhost kernel:  [<c037af59>] tcp_connect+0x2c9/0x370
Feb  3 16:02:08 localhost kernel:  [<c037da54>] tcp_v4_connect+0x604/0xb90
Feb  3 16:02:08 localhost kernel:  [<c0342f76>] sock_aio_write+0xf6/0x120
Feb  3 16:02:08 localhost kernel:  [<c038dd1b>] 
inet_stream_connect+0x8b/0x1b0
Feb  3 16:02:08 localhost kernel:  [<c0343f43>] sys_connect+0x83/0xb0
Feb  3 16:02:08 localhost kernel:  [<c0342886>] sock_map_fd+0x116/0x140
Feb  3 16:02:08 localhost kernel:  [<c034385b>] __sock_create+0xfb/0x2a0
Feb  3 16:02:08 localhost kernel:  [<c020b522>] copy_from_user+0x42/0x70
Feb  3 16:02:08 localhost kernel:  [<c03449d1>] sys_socketcall+0xb1/0x260
Feb  3 16:02:08 localhost kernel:  [<c016ff4a>] sys_ioctl+0xaa/0x220
Feb  3 16:02:08 localhost kernel:  [<c0103257>] syscall_call+0x7/0xb

What is it?

Regards,
Victor
