Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129523AbQKTQog>; Mon, 20 Nov 2000 11:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129248AbQKTQo1>; Mon, 20 Nov 2000 11:44:27 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:34830 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129199AbQKTQn4>; Mon, 20 Nov 2000 11:43:56 -0500
Message-ID: <07E6E3B8C072D211AC4100A0C9C5758302B270A1@hasmsx52.iil.intel.com>
From: "Hen, Shmulik" <shmulik.hen@intel.com>
To: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>,
        "'LNML'" <linux-net@vger.kernel.org>
Subject: RE: catch 22 - porting net driver from 2.2 to 2.4
Date: Mon, 20 Nov 2000 08:13:21 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried using the kernel thread as demonstrated in your example and again it
failed (panic - scheduling in interrupt).
The difference is that your code executes the thread from within dev->open,
while my code tries to do that from dev->do_ioctl that has spinlocks around
the entire operation (which apparently sleeps).
If I comment out the spin_lock/unlock it will succeed, but then I can't be
sure I don't get any concurrent Tx/Rx/timer which is a bad idea while the
topology is still being created.

is there any way to do something like firing threads/timers atomically ?


	Thanks,
	Shmulik.

-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@mandrakesoft.com]
Sent: Monday, November 13, 2000 4:26 PM
To: Hen, Shmulik
Subject: Re: catch 22 - porting net driver from 2.2 to 2.4


"Hen, Shmulik" wrote:
> 
> Where can I find info about that ?
> My first idea was to fire a timer and let the callback routine do the
work,
> but I worry about synchronization and about passing the list of items for
it
> to handle.
> What is the accepted way of starting a kernel thread and how do I handle
> parameters and sync. ?

Attached is an example.  My "8139too" ethernet driver uses a kernel
thread instead of a timer to perform media checking.  It illustrates how
to start and stop a kernel thread.

-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
