Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316824AbSF0MiB>; Thu, 27 Jun 2002 08:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316832AbSF0MiB>; Thu, 27 Jun 2002 08:38:01 -0400
Received: from mailrelay2.lrz-muenchen.de ([129.187.254.102]:5853 "EHLO
	mailrelay2.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S316824AbSF0MiA>; Thu, 27 Jun 2002 08:38:00 -0400
Date: Thu, 27 Jun 2002 14:36:24 +0200 (MET DST)
From: Oliver.Neukum@lrz.uni-muenchen.de
X-X-Sender: ui222bq@sun4.lrz-muenchen.de
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: David Woodhouse <dwmw2@infradead.org>,
       Nicolas Bougues <nbougues-listes@axialys.net>,
       Andries Brouwer <aebr@win.tue.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: Problems with wait queues 
In-Reply-To: <Pine.LNX.3.95.1020627073831.4174A-101000@chaos.analogic.com>
Message-Id: <Pine.SOL.4.44.0206271432020.4650-100000@sun4.lrz-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Do not ever use sleep_on() and friends. Almost all usage of these
> > functions will be buggy.
> >
>
> Whatever your message means; perhaps it was a way of saying "Hello"
> to an old friend?
>
> Attached is a file showing about 485 usages of 'sleep_on' in the
> kernel drivers. If this usage is, as you say, buggy then will you
> please inform us unwashed hordes what we should use to replace these?

The simplest way is with the wait_event[_interruptible] macros.
In newer versions of the USB drivers, you'll find examples.
You may also set your task's state and put yourself on a waitqueue,
before you do something that will cause you to be woken up.


And yes, most examples you found are buggy, as they can miss
a wakeup.
To use sleep_on safely you must make sure that you cannot be woken up
before you begin to sleep.

	Regards
		Oliver


