Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263995AbUFFSxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263995AbUFFSxR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 14:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264012AbUFFSxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 14:53:17 -0400
Received: from gprs214-14.eurotel.cz ([160.218.214.14]:31105 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263995AbUFFSxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 14:53:11 -0400
Date: Sun, 6 Jun 2004 20:51:59 +0200
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: locking in psmouse
Message-ID: <20040606185158.GA3169@elf.ucw.cz>
References: <20040428213040.GA954@elf.ucw.cz> <200404282347.47411.dtor_core@ameritech.net> <20040429095830.GD390@elf.ucw.cz> <200404290740.18182.dtor_core@ameritech.net> <20040606174143.GA6561@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040606174143.GA6561@ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > > psmouse-base.c does not have any locking. For example psmouse_command
> > > > > could race with data coming from the mouse, resulting in problem. This
> > > > > should fix it.
> > > > 
> > > > Although I am not arguing that locking might be needed in psmouse module I
> > > > am somewhat confused how it will help in case of data stream coming from the
> > > > mouse... If mouse sent a byte before the kernel issue a command then it will
> > > > be delivered by KBC controller and will be processed by the interrupt handler,
> > > > probably messing up detection process. That's why as soon as we decide that
> > > > the device behind PS/2 port is some kind of mouse we disable the stream mode.
> > > 
> > > Does that mean that mouse can not talk while we are sending commands
> > > to it? That would help a bit.
> > > 
> > 
> > Yes, check psmouse_probe. As soon as PSMOUSE_CMD_RESET_DIS acknowledged mouse
> > should cease sending motion data. That still leaves possibility of screwing up
> > detection if you are moving mouse while psmouse doing PSMOUSE_CMD_GETID.
> > But I don't think we can do much about it as we'd like to know that the device
> > is some kind of a mouse before we start messing with it.
> 
> I've updated the atkbd_command/atkbd_interrupt mechanism so that even
> bytes coming from the keyboard when we're issuing a command shouldn't
> disturb us. I've tested by banging my head at the keyboard while
> plugging it in. ;)
> 
> Something like that might be worth implementing for psmouse as well.

Well, psmouse case should be just converting int foo:1 into
set_bit(&flags, BIT_FOO), no?

But I guess autorepeat and higher layers of keyboard might be
"interesting".
							Pavel 

-- 
934a471f20d6580d5aad759bf0d97ddc
