Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263851AbUFFRq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUFFRq0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 13:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbUFFRqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 13:46:25 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:22912 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S263851AbUFFRlL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 13:41:11 -0400
Date: Sun, 6 Jun 2004 19:41:44 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: locking in psmouse
Message-ID: <20040606174143.GA6561@ucw.cz>
References: <20040428213040.GA954@elf.ucw.cz> <200404282347.47411.dtor_core@ameritech.net> <20040429095830.GD390@elf.ucw.cz> <200404290740.18182.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404290740.18182.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 07:40:17AM -0500, Dmitry Torokhov wrote:

> On Thursday 29 April 2004 04:58 am, Pavel Machek wrote:
> > Hi!
> > 
> > > > psmouse-base.c does not have any locking. For example psmouse_command
> > > > could race with data coming from the mouse, resulting in problem. This
> > > > should fix it.
> > > 
> > > Although I am not arguing that locking might be needed in psmouse module I
> > > am somewhat confused how it will help in case of data stream coming from the
> > > mouse... If mouse sent a byte before the kernel issue a command then it will
> > > be delivered by KBC controller and will be processed by the interrupt handler,
> > > probably messing up detection process. That's why as soon as we decide that
> > > the device behind PS/2 port is some kind of mouse we disable the stream mode.
> > 
> > Does that mean that mouse can not talk while we are sending commands
> > to it? That would help a bit.
> > 
> 
> Yes, check psmouse_probe. As soon as PSMOUSE_CMD_RESET_DIS acknowledged mouse
> should cease sending motion data. That still leaves possibility of screwing up
> detection if you are moving mouse while psmouse doing PSMOUSE_CMD_GETID.
> But I don't think we can do much about it as we'd like to know that the device
> is some kind of a mouse before we start messing with it.

I've updated the atkbd_command/atkbd_interrupt mechanism so that even
bytes coming from the keyboard when we're issuing a command shouldn't
disturb us. I've tested by banging my head at the keyboard while
plugging it in. ;)

Something like that might be worth implementing for psmouse as well.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
