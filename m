Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbUKQNX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbUKQNX6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 08:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbUKQNX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 08:23:58 -0500
Received: from [202.96.154.178] ([202.96.154.178]:17126 "EHLO mailgw1.963.net")
	by vger.kernel.org with ESMTP id S262304AbUKQNXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 08:23:52 -0500
X-Originating-IP: [202.96.154.159]
Message-ID: <003501c4ccaa$6076c6c0$fd00a8c0@magf>
From: "Paul Ma" <magf@bitland.com.cn>
To: <linux-kernel@vger.kernel.org>
References: <20041116223243.43feddf4@mango.fruits.de><20041116224257.GB27550@elte.hu><20041116230443.452497b9@mango.fruits.de><20041116231145.GC31529@elte.hu><20041116235535.6867290d@mango.fruits.de><20041117002926.32a4b26f@mango.fruits.de><419A961A.2070005@timesys.com><20041117122318.479805fa@mango.fruits.de><20041117130236.GA28240@elte.hu><20041117131400.0c1dbe95@mango.fruits.de><20041117134150.GA29754@elte.hu> <20041117135959.23c98bf0@mango.fruits.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-3
Date: Wed, 17 Nov 2004 21:35:59 +0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After I finished using my USB HDD, I umount it.
When unplug from my computer, there are the following output:

Nov 17 21:13:11 magf1 kernel: usb 1-5: USB disconnect, address 2
Nov 17 21:13:11 magf1 kernel: slab error in kmem_cache_destroy(): cache
`scsi_cmd_cache': Can't free all objects
Nov 17 21:13:11 magf1 kernel:  [<c0104164>] dump_stack+0x23/0x27 (20)
Nov 17 21:13:11 magf1 kernel:  [<c0151ba5>] kmem_cache_destroy+0x106/0x194
(28)
Nov 17 21:13:11 magf1 kernel:  [<c02c99b5>]
scsi_destroy_command_freelist+0x53/0x81 (28)
Nov 17 21:13:11 magf1 kernel:  [<c02ca866>] scsi_host_dev_release+0x43/0x164
(172)
Nov 17 21:13:11 magf1 kernel:  [<c0295b4d>] device_release+0x7c/0x80 (32)
Nov 17 21:13:11 magf1 kernel:  [<c0226b94>] kobject_cleanup+0x94/0x96 (32)
Nov 17 21:13:11 magf1 kernel:  [<c02276ba>] kref_put+0x46/0xf0 (40)
Nov 17 21:13:11 magf1 kernel:  [<c0226bd2>] kobject_put+0x25/0x29 (16)
Nov 17 21:13:11 magf1 kernel:  [<d8880146>]
usb_stor_release_resources+0x7e/0x133 [usb_storage] (24)
Nov 17 21:13:11 magf1 kernel:  [<d88806d6>] storage_disconnect+0x9a/0xa8
[usb_storage] (16)
Nov 17 21:13:11 magf1 kernel:  [<d88a118c>] usb_unbind_interface+0x8b/0x8d
[usbcore] (28)
Nov 17 21:13:11 magf1 kernel:  [<c0296d92>] device_release_driver+0x86/0x88
(28)
Nov 17 21:13:11 magf1 kernel:  [<c0296f98>] bus_remove_device+0x56/0x86 (20)
Nov 17 21:13:11 magf1 kernel:  [<c0295f91>] device_del+0x4f/0x88 (20)
Nov 17 21:13:11 magf1 kernel:  [<d88a947c>] usb_disable_device+0xd1/0x172
[usbcore] (44)
Nov 17 21:13:11 magf1 kernel:  [<d88a3c97>] usb_disconnect+0xb0/0x187
[usbcore] (44)
Nov 17 21:13:11 magf1 kernel:  [<d88a5309>]
hub_port_connect_change+0x471/0x4a0 [usbcore] (72)
Nov 17 21:13:11 magf1 kernel:  [<d88a5779>] hub_events+0x441/0x52d [usbcore]
(76)
Nov 17 21:13:11 magf1 kernel:  [<d88a589c>] hub_thread+0x37/0x120 [usbcore]
(96)
Nov 17 21:13:11 magf1 kernel:  [<c0101329>] kernel_thread_helper+0x5/0xb
(690024468)
Nov 17 21:13:11 magf1 kernel: ---------------------------
Nov 17 21:13:11 magf1 kernel: | preempt count: 00000001 ]
Nov 17 21:13:11 magf1 kernel: | 1-level deep critical section nesting:
Nov 17 21:13:11 magf1 kernel: ----------------------------------------
Nov 17 21:13:11 magf1 kernel: .. [<c013ce8c>] .... print_traces+0x1d/0x56
Nov 17 21:13:11 magf1 kernel: .....[<c0104164>] ..   ( <=
dump_stack+0x23/0x27)
Nov 17 21:13:11 magf1 kernel:

On linux-2.6.6/2.6.7 and Fedora Core 2, My USB HDD is working properly. On
realtime preempt kernel, I
have such problem.

Paul


----- Original Message -----
From: "Florian Schmidt" <mista.tapas@gmx.net>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "john cooper" <john.cooper@timesys.com>; "K.R. Foley" <kr@cybsft.com>;
<Mark_H_Johnson@raytheon.com>; <linux-kernel@vger.kernel.org>; "Lee Revell"
<rlrevell@joe-job.com>; "Rui Nuno Capela" <rncbc@rncbc.org>; "Bill Huey"
<bhuey@lnxw.com>; "Adam Heath" <doogie@debian.org>; "Thomas Gleixner"
<tglx@linutronix.de>; "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>;
"Fernando Pablo Lopez-Lezcano" <nando@ccrma.Stanford.EDU>; "Karsten Wiese"
<annabellesgarden@yahoo.de>; "Gunther Persoons"
<gunther_persoons@spymac.com>; <emann@mrv.com>; "Shane Shrybman"
<shrybman@aei.ca>; "Amit Shah" <amit.shah@codito.com>; "Stefan Schweizer"
<sschweizer@gmail.com>
Sent: Wednesday, November 17, 2004 8:59 PM
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.27-3


> On Wed, 17 Nov 2004 14:41:50 +0100
> Ingo Molnar <mingo@elte.hu> wrote:
>
> >
> > * Florian Schmidt <mista.tapas@gmx.net> wrote:
> >
> > > > could you send me the latest .config you are using on this box?
> > >
> > > sure. attached.
> >
> > > what else would be interesting for you?
> >
> > have you kicked the latency tracer by clearing preempt_max_latency, or
> > is it at the default (off) value?
>
> I didn't touch it.
>
> flo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>



