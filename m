Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVA1PYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVA1PYt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 10:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVA1PYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 10:24:48 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:50482 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261454AbVA1PWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 10:22:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=CE64OD7HESjS4OeVOhz/8hwSziDEY3qHKMlxJ3wYhcqdOZu87mobvTccIiRdq9/l5CHXWnCttIEjwefPc5WFJGWCgVdEPmquO7zNTklQ450UiDdJ6jJ6IxG2Ag1y3ZnPhRSnaqRfJukWXhqxaeIMVp3jOZ2hl7AKRUAkNjzFI7k=
Message-ID: <d120d500050128072268a5c2f0@mail.gmail.com>
Date: Fri, 28 Jan 2005 10:22:18 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Olaf Hering <olh@suse.de>
Subject: Re: atkbd_init lockup with 2.6.11-rc1
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
In-Reply-To: <20050128145511.GA29340@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050128132202.GA27323@suse.de> <20050128135827.GA28784@suse.de>
	 <d120d50005012806435a17fe98@mail.gmail.com>
	 <20050128145511.GA29340@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005 15:55:11 +0100, Olaf Hering <olh@suse.de> wrote:
> On Fri, Jan 28, Dmitry Torokhov wrote:
> 
> > On Fri, 28 Jan 2005 14:58:27 +0100, Olaf Hering <olh@suse.de> wrote:
> > > On Fri, Jan 28, Olaf Hering wrote:
> > >
> > > >
> > > > My IBM RS/6000 B50 locks up with 2.6.11rc1, it dies in atkbd_init():
> > >
> > > It fails also on PReP, not only on CHRP. 2.6.10 looks like this:
> > >
> > > Calling initcall 0xc03bc430: atkbd_init+0x0/0x2c()
> > > atkbd.c: keyboard reset failed on isa0060/serio1
> > > atkbd.c: keyboard reset failed on isa0060/serio0
> > >
> >
> > So it could not reset it even before, but it was not getting stuch
> > tough... What about passing atkbd.reset=0?
> 
> I will try that.
> Adding a printk after the outb() fixes it as well.

Fixes as in "it reports that reset fails" again or it resets the
keyboard cleanly and works fine?

> Do you have a version of that i8042 delay patch for 2.6.11-rc2-bk6?
> Maybe it will help.
> 

No I don't, and I don't think you need all of it. What happens if you
edit drivers/input/serio/i8042.c manually and stick udelay(7); in
front of calls to i8042_write_data() in i8042_kbd_write() and
i8042_aux_write()?

-- 
Dmitry
