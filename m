Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270090AbTGMEgO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 00:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270095AbTGMEgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 00:36:14 -0400
Received: from air-2.osdl.org ([65.172.181.6]:17372 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270090AbTGMEgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 00:36:12 -0400
Date: Sat, 12 Jul 2003 21:50:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: smiler@lanil.mine.nu, linux-kernel@vger.kernel.org
Subject: Re: [2.7.75] Misc compiler warnings
Message-Id: <20030712215058.16f76ebc.akpm@osdl.org>
In-Reply-To: <20030713040801.GA2695@kroah.com>
References: <1058053975.12250.2.camel@sm-wks1.lan.irkk.nu>
	<1058055803.12256.27.camel@sm-wks1.lan.irkk.nu>
	<20030713040801.GA2695@kroah.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> On Sun, Jul 13, 2003 at 02:23:29AM +0200, Christian Axelsson wrote:
> > On Sun, 2003-07-13 at 01:52, Christian Axelsson wrote:
> > > Here are some compiler warnings:
> > > 
> > >   CC      drivers/i2c/i2c-dev.o
> > > drivers/i2c/i2c-dev.c: In function `show_dev':
> > > drivers/i2c/i2c-dev.c:121: warning: unsigned int format, different type
> > > arg (arg 3)
> > > 
> > >   CC      drivers/usb/core/file.o
> > > drivers/usb/core/file.c: In function `show_dev':
> > > drivers/usb/core/file.c:96: warning: unsigned int format, different type
> > > arg (arg 3)
> > > 
> > >   AS      arch/i386/boot/setup.o
> > > arch/i386/boot/setup.S: Assembler messages:
> > > arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to
> > > 0x37ffffff
> > 
> > Ehm sorry, I should say that this is 2.5.75-mm1
> > 
> > On 2.5.75-vanilla only the AS message occour.
> 
> That is due to the size of dev_t being bigger in the -mm tree.  When
> that moves to the main kernel tree, I'll fix up the usb and i2c
> warnings.
> 

No, these need to be fixed anyway.  On ppc64 (at least), dev_t is `unsigned
long'.

So on that platform the code you have in there right now will always
generate zeroes or it will oops, if there are %s's further along.

I'm not sure what's the best fix really.  Maybe casting to `unsigned long
long' and handling it with %llx.

I've fixed lots of these things but have a vague feeling I've been using
`unsigned long'.  That's probably good enough most of the time.

Better would be just to not play around with dev_t's in-kernel in this
manner at all.  Why are we doing it?

