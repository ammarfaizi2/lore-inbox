Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWIINHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWIINHQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 09:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWIINHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 09:07:15 -0400
Received: from [88.208.93.65] ([88.208.93.65]:12307 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S932162AbWIINHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 09:07:13 -0400
Date: Sat, 9 Sep 2006 15:07:14 +0200
From: Martin Mares <mj@ucw.cz>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Greg KH <gregkh@suse.de>, torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: State of the Linux PCI Subsystem for 2.6.18-rc6
Message-ID: <mj+md-20060909.125924.13670.albireo@ucw.cz>
References: <20060909081816.GA13058@kroah.com> <mj+md-20060909.082546.5026.albireo@ucw.cz> <20060909125827.GA16084@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060909125827.GA16084@lists.us.dell.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Respectfully, With the current 2.6 development model (i.e. the lack of
> a 2.7), how are we to address this kind of thing?  I'd like to see it
> fixed in all new distro releases that base on 2.6.18-2.6.19, and it'll be an
> individual distro decision to apply to existing releases (somewhat
> unlikely).  I'm open to suggestions.  Udev rules like what opensuse
> use would keep the existing names constant, as would the Red Hat
> ifcfg-eth* method, so at least those distro users are OK.  We really
> need this at install time to get the naming right in the first place.

The problem is that there is nothing as a single "right". There exists no
consistent definition of how should the ordering look like and the fact
that 2.4 and 2.6 differ are just a consequence of that.

>From the point of view of 2.4 users, the "right" definition is the one used
by 2.4 kernels.

>From the point of view of 2.6 users, the only right definition is the current one.

For people installing Linux from scratch, it doesn't matter because neither
definition has any advantage, both give unstable results when new devices
are plugged in.

Moreover, the depth-first order is probably a little bit more stable,
because on-board buses usually have lower numbers than buses where hotpluggable
devices live (e.g., cardbus), so newly plugged devices are nicely ordered
after all built-in ones.

If you want to have stable names, use udev, relying on any order is wrong
as new devices can always appear anywhere.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
How an engineer writes a program: Start by debugging an empty file...
