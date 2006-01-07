Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965174AbWAGDTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbWAGDTJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 22:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965177AbWAGDTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 22:19:08 -0500
Received: from mx1.rowland.org ([192.131.102.7]:52744 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S965174AbWAGDTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 22:19:07 -0500
Date: Fri, 6 Jan 2006 22:19:03 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Pavel Machek <pavel@ucw.cz>
cc: Patrick Mochel <mochel@digitalimplant.org>, Andrew Morton <akpm@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys
 interface
In-Reply-To: <20060107000826.GC20399@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44L0.0601062208510.22627-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jan 2006, Pavel Machek wrote:

> > This trend is extremely alarming!!
> 
> It scares me a bit, too. 

> I think we should start with string-based interface, with just two
> states ("on" and "off"). That is easily extensible into future, and
> suits current PCMCIA nicely. It also allows us to experiment with PCI
> power management... I can cook up a patch, but it will be simple
> reintroduction of .../power file under different name.

That sounds good to me, provided you add to dev_pm_info a pointer to an
array of string pointers, the names of the available states.  For now all
devices can share a single array with just two entries ("on" and "off",
or even "0" and "2").  In the future, bus drivers will be able to
substitute a pointer to a private array with device-specific state names.

Of course, this change will require you to add something like

	const char *name;

to the pm_message_t struct.  PM-aware drivers will be able to use it to
see which state was requested, and other drivers can ignore it.

In fact, for PM-aware drivers the name field makes the event field 
unnecessary.  But until all drivers are PM-aware we can't get rid of it.

Alan Stern

