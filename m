Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVA1Qnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVA1Qnt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 11:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVA1Qnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 11:43:49 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:15242 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261477AbVA1Qnq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 11:43:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=c8srnTOBIgKe2BAPodzMza8cACwCCI6XQKojlpyY8c05JkJuuU+BABtOLgmdecXx8mVL7DETEaJXJ27ms9B/mQ9TWt4tjWQ+MjvuLZSoHlHzzrCrrpvoJmxvaIKU6jGXfRKKwEi0KtbWotFb57p1JXdKD7oqskOgp3JiqTWcIZc=
Message-ID: <d120d500050128084345bb1abd@mail.gmail.com>
Date: Fri, 28 Jan 2005 11:43:44 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Olaf Hering <olh@suse.de>
Subject: Re: atkbd_init lockup with 2.6.11-rc1
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
In-Reply-To: <20050128161746.GA1092@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050128132202.GA27323@suse.de> <20050128135827.GA28784@suse.de>
	 <d120d50005012806435a17fe98@mail.gmail.com>
	 <20050128145511.GA29340@suse.de>
	 <d120d500050128072268a5c2f0@mail.gmail.com>
	 <20050128161746.GA1092@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005 17:17:46 +0100, Olaf Hering <olh@suse.de> wrote:
> On Fri, Jan 28, Dmitry Torokhov wrote:
> 
> > Fixes as in "it reports that reset fails" again or it resets the
> > keyboard cleanly and works fine?
> 
> It doesnt hang if I add printk around the outb.
> 
> > > Do you have a version of that i8042 delay patch for 2.6.11-rc2-bk6?
> > > Maybe it will help.
> > >
> >
> > No I don't, and I don't think you need all of it. What happens if you
> > edit drivers/input/serio/i8042.c manually and stick udelay(7); in
> > front of calls to i8042_write_data() in i8042_kbd_write() and
> > i8042_aux_write()?
> 
> Doesnt help either, adding printk fixes it.
> 
> /home/olaf/kernel/b50/linux-2.6.11-rc2-bk6-olh/drivers/input/serio/i8042.c: 60 -> i8042 (command) [2264]
> /home/olaf/kernel/b50/linux-2.6.11-rc2-bk6-olh/drivers/input/serio/i8042.c: 61 -> i8042 (parameter) [2264]
> i8042_write_data(56) swapper(1):c0,j4294673158 enter 97
> i8042_write_data(58) swapper(1):c0,j4294673158 leave 97
> /home/olaf/kernel/b50/linux-2.6.11-rc2-bk6-olh/drivers/input/serio/i8042.c: ff -> i8042 (kbd-data) [2640]
> i8042_write_data(56) swapper(1):c0,j4294673534 enter 255
> i8042_write_data(58) swapper(1):c0,j4294673534 leave 255
> /home/olaf/kernel/b50/linux-2.6.11-rc2-bk6-olh/drivers/input/serio/i8042.c: fe <- i8042 (interrupt, kbd, 1, timeout) [2895]
> atkbd.c: keyboard reset failed on isa0060/serio0
> /home/olaf/kernel/b50/linux-2.6.11-rc2-bk6-olh/drivers/input/serio/i8042.c: f2 -> i8042 (kbd-data) [3096]
> i8042_write_data(56) swapper(1):c0,j4294673990 enter 242
> i8042_write_data(58) swapper(1):c0,j4294673990 leave 242
> /home/olaf/kernel/b50/linux-2.6.11-rc2-bk6-olh/drivers/input/serio/i8042.c: fe <- i8042 (interrupt, kbd, 1, timeout) [3351]
> /home/olaf/kernel/b50/linux-2.6.11-rc2-bk6-olh/drivers/input/serio/i8042.c: ed -> i8042 (kbd-data) [3494]
> i8042_write_data(56) swapper(1):c0,j4294674388 enter 237
> i8042_write_data(58) swapper(1):c0,j4294674388 leave 237
> /home/olaf/kernel/b50/linux-2.6.11-rc2-bk6-olh/drivers/input/serio/i8042.c: fe <- i8042 (interrupt, kbd, 1, timeout) [3750]
> /home/olaf/kernel/b50/linux-2.6.11-rc2-bk6-olh/drivers/input/serio/i8042.c: 60 -> i8042 (command) [3893]
> /home/olaf/kernel/b50/linux-2.6.11-rc2-bk6-olh/drivers/input/serio/i8042.c: 60 -> i8042 (parameter) [3893]
> i8042_write_data(56) swapper(1):c0,j4294674787 enter 96
> i8042_write_data(58) swapper(1):c0,j4294674787 leave 96

So this trace is without printk but with udelay, right? This time
keyboard does not hang but NAKs everything instead... What if you aso
add udelay(20) after calls to i8042_write_data()?

> md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
> NET: Registered protocol family 2
> .. here it hangs again.

Do you know where exactly? Is it some IO port access again?

-- 
Dmitry
