Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262810AbSJTOu6>; Sun, 20 Oct 2002 10:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262824AbSJTOu6>; Sun, 20 Oct 2002 10:50:58 -0400
Received: from rztsun.rz.tu-harburg.de ([134.28.200.14]:62636 "EHLO
	rztsun.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id <S262810AbSJTOu4> convert rfc822-to-8bit; Sun, 20 Oct 2002 10:50:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jan Dittmer <jan@jandittmer.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: Oops on boot with TCQ enabled (VIA KT133A)
Date: Sun, 20 Oct 2002 16:57:52 +0200
User-Agent: KMail/1.4.3
References: <200210190241.49618.jan@jandittmer.de> <20021020104601.C8606@ucw.cz> <20021020093818.GC24484@suse.de>
In-Reply-To: <20021020093818.GC24484@suse.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210201657.52250.jan@jandittmer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > There _may_ be issues with changing depth on the fly. So if you could
> > > just test without fiddling with changing depths that would be great.
> >
> > Ok. No changes in /proc using_tcq after boot, assuming it's enabled
> > automatically (checked that in kernel config0, it works perfectly fine.
>
> Thanks for verifying that! Jan, you appeared to have problems even with
> tcq-per-default enabled and not touching the depth while running io, is
> that correct?

Thats correct. But I couldn't reproduce it, after applying the following 
changeset. But that doesn't seem very related (I got some oops' while playing 
a video). But iirc I always watched a music video when file system corruption 
appeared?!
I'll try tomorrow evening without this change if I can reproduce the 
problem...

jan


--- emufx.c     11 Oct 2002 13:29:36 -0000      1.23
+++ emufx.c     19 Oct 2002 14:29:43 -0000
@@ -413,7 +413,7 @@

        snd_runtime_check(emu, return -EINVAL);
        snd_runtime_check(handler, return -EINVAL);
-       irq = kmalloc(sizeof(*irq), GFP_KERNEL);
+       irq = kmalloc(sizeof(*irq), GFP_ATOMIC);
        if (irq == NULL)
                return -ENOMEM;
        irq->handler = handler;
