Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279628AbRJXWoe>; Wed, 24 Oct 2001 18:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279633AbRJXWo3>; Wed, 24 Oct 2001 18:44:29 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3595 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279639AbRJXWoR>; Wed, 24 Oct 2001 18:44:17 -0400
Subject: Re: [RFC] New Driver Model for 2.5
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 24 Oct 2001 23:50:36 +0100 (BST)
Cc: benh@kernel.crashing.org (Benjamin Herrenschmidt),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        mochel@osdl.org (Patrick Mochel),
        jlundell@pobox.com (Jonathan Lundell)
In-Reply-To: <Pine.LNX.4.33.0110240901350.8049-100000@penguin.transmeta.com> from "Linus Torvalds" at Oct 24, 2001 09:15:44 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15wWr6-0002wx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why would you _ever_ get "sg.c" and other crap involved in the suspend
> process?
> 
> The device tree is for _device_ suspend, not for "subsystem suspend". The
> SCSI subsystem is a piece of cr*p, but even if it was perfect it should
> never get involved with the act of suspension.

Well I don't want my laptop to suspend during a CD burn or firmware update.
The device itself doesn't know anything about how busy it is since its
just sending packets, only the subsystem driver controller it does

> by getting involved with sg.c or anything similar, but by basically
> stopping all user apps (think of the equivalent of a "kill -STOP -1", but
> done internally in the kernel without actually using a signal).

Stopping all user apps really tends to ruin the cd and the firmware
update.

> Remember: the main point of suspend is to have a laptop go to sleep, and
> come back up on the order of a few _seconds_.

It also has to avoid unpleasant situations

> Also, realize that the act of suspension is STARTED BY THE USER. Which
> means that before the kernel suspends, you _can_ have user programs that
> basically take disk arrays off-line etc if that is what you want. But
> that's not ae kernel suspend issue.

There are certain practicalities here with trying to make user space dig
around in fuser innards or patching every cd burner. The sg layer is one
that has to get involved (be it as a driver call back or a virtual driver)
