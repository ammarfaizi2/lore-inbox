Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264880AbUD2QCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264880AbUD2QCX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 12:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbUD2QCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 12:02:22 -0400
Received: from r2l237.mistral.cz ([62.245.75.237]:640 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264880AbUD2QCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 12:02:21 -0400
Date: Thu, 29 Apr 2004 18:02:54 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: locking in psmouse
Message-ID: <20040429160254.GA295@ucw.cz>
References: <20040428213040.GA954@elf.ucw.cz> <200404282347.47411.dtor_core@ameritech.net> <20040429095830.GD390@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429095830.GD390@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 11:58:30AM +0200, Pavel Machek wrote:

> > > psmouse-base.c does not have any locking. For example psmouse_command
> > > could race with data coming from the mouse, resulting in problem. This
> > > should fix it.
> > 
> > Although I am not arguing that locking might be needed in psmouse module I
> > am somewhat confused how it will help in case of data stream coming from the
> > mouse... If mouse sent a byte before the kernel issue a command then it will
> > be delivered by KBC controller and will be processed by the interrupt handler,
> > probably messing up detection process. That's why as soon as we decide that
> > the device behind PS/2 port is some kind of mouse we disable the stream mode.

Any PS/2 device is supposed to stop talking as soon as it gets a command
until it's done with it. Supposed to. Namely USB Legacy emulation breaks
this rule.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
