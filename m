Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268240AbUJDPsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268240AbUJDPsW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 11:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268253AbUJDPqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 11:46:49 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:49801 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S268259AbUJDPpU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 11:45:20 -0400
From: David Brownell <david-b@pacbell.net>
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Jan De Luyck <lkml@kcore.org>
Subject: Re: [linux-usb-devel] Re: [2.6.9-rc3] suspend-to-disk oddities
Date: Mon, 4 Oct 2004 08:04:04 -0700
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200410041107.12049.lkml@kcore.org> <200410041422.25395.lkml@kcore.org> <200410041456.27350.rjw@sisk.pl>
In-Reply-To: <200410041456.27350.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410040804.04382.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 October 2004 5:56 am, Rafael J. Wysocki wrote:
> On Monday 04 of October 2004 14:22, Jan De Luyck wrote:
> > 
> > UHCI. I just did a test-suspend-resume, currently plugged
> > USB devices don't  work, but it does show up in the devices
> > file. It also responds to  replugging.... I don't get it.
> >  I had no response whatsoever earlier. ...
> 
> Have you tried booting with pci=routeirq?  It may help.

I've seen strangeness on the resume path too, with devices
not responding but still being known to the kernel.  What I
found odd was that I know the OHCI hardware was reinitialized
correctly, and it was just khubd that wasn't responding.  So
it wouldn't  even respond to unplug/replug.  And this is with
known-OK IRQ settings (driver did get IRQs after resume).

There's some other stuff misbehaving still.  I'm hoping to see
the simpler stuff work first -- standby and STR behaving, wakeup
by USB keyboards not ACPI power buttons -- and at that point
the remaining problems will be specific to STD.  There are
enough wierd BIOS and power states with STD that making
that work first is very likely to bork the other stuff.

- Dave
