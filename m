Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbUKIXT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbUKIXT6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 18:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUKIXTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 18:19:42 -0500
Received: from rproxy.gmail.com ([64.233.170.192]:34392 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261764AbUKIXTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 18:19:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=WKNrLr/2t1pxHdDllLSnRUaWOdFPKD5AN0Gdv/28Hc90xAKc8gTbZamGEaVwb8GRIBzqI6fmvDmXiw1FsM0QCJd8xxPT7swbU27eAkUCiE5yVYBswwhXEwG6oVFRBxmvkDtMsunNprAezpMgooCo4WLHdk3xJ7FBKhP8l8UdirA=
Message-ID: <d120d50004110915196517dd37@mail.gmail.com>
Date: Tue, 9 Nov 2004 18:19:05 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Greg KH <greg@kroah.com>
Subject: Re: /sys/devices/system/timer registered twice
Cc: Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20041109225245.GB7618@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041109193043.GA8767@vrfy.org> <20041109225245.GB7618@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Nov 2004 14:52:45 -0800, Greg KH <greg@kroah.com> wrote:
> 
> 
> On Tue, Nov 09, 2004 at 08:30:43PM +0100, Kay Sievers wrote:
> > Hi,
> > I got this on a Centrino box with the latest bk:
> >
> >   [kay@pim linux.kay]$ ls -l /sys/devices/system/
> >   total 0
> >   drwxr-xr-x  7 root root 0 Nov  8 15:12 .
> >   drwxr-xr-x  5 root root 0 Nov  8 15:12 ..
> >   drwxr-xr-x  3 root root 0 Nov  8 15:12 cpu
> >   drwxr-xr-x  3 root root 0 Nov  8 15:12 i8259
> >   drwxr-xr-x  2 root root 0 Nov  8 15:12 ioapic
> >   drwxr-xr-x  3 root root 0 Nov  8 15:12 irqrouter
> >   ?---------  ? ?    ?    ?            ? timer
> >
> >
> > It is caused by registering two devices with the name "timer" from:
> >
> >   arch/i386/kernel/time.c
> >   arch/i386/kernel/timers/timer_pit.c
> >
> > If I change one of the names, I get two correct looking sysfs entries.
> >
> > Greg, shouldn't the driver core prevent the corruption of the first
> > device if another one tries to register with the same name?
> 
> Hm, this looks like an issue for Dmitry, as there shouldn't be too
> sysdev_class structures with the same name, right?
> 

I agree, but I think you got the wrong man here ;) You need to talk to
Venkatesh.

http://linux.bkbits.net:8080/linux-2.5/cset@41810e4aGZ0E5bn_hMb4JgIY5u90zA?nav=index.html|src/.|src/arch|src/arch/i386|src/arch/i386/kernel|related/arch/i386/kernel/time.c

-- 
Dmitry
