Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265654AbVBEAUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265654AbVBEAUR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 19:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264641AbVBEAUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 19:20:16 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:38309 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S264285AbVBEAT2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 19:19:28 -0500
Subject: Re: Patch to add usbmon
From: Marcel Holtmann <marcel@holtmann.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050202105454.3f85dbdf@localhost.localdomain>
References: <20050131212903.6e3a35e5@localhost.localdomain>
	 <20050201071000.GF20783@kroah.com>
	 <20050201003218.478f031e@localhost.localdomain>
	 <1107256383.9652.26.camel@pegasus>
	 <20050201095526.0ee2e0f4@localhost.localdomain>
	 <1107293870.9652.76.camel@pegasus>
	 <20050201215936.029be631@localhost.localdomain>
	 <1107362417.11944.7.camel@pegasus>
	 <20050202105454.3f85dbdf@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 05 Feb 2005 01:19:15 +0100
Message-Id: <1107562755.6921.123.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pete,

> > While I am really thinking about starting usbdump, I may ask why you
> > have choosen to use debugfs as interface. This will not be available in
> > normal distribution kernels and I think a general USB monitoring ability
> > would be great. For example like we have it for Ethernet, Bluetooth and
> > IrDA. So my idea is to create some /dev/usbmonX (for each bus one) where
> > usbdump can read its information from. What do you think?
> 
> The debugfs will be available in distributions. And it's no different from
> having SOCK_PACKET enabled before tcpdump can work. There's no practical
> disadvantage, unless we consider a backport of usbmon into a legacy distribution
> such as RHEL 4 or SuSE 9.1.

I am not interested in a backport.

> Since usbmon rides raw file_operations, it can use a chardev interface with
> a minimal change. The advantage of debugfs is only not needing to allocate
> a major and dealing with minor partitioning. I also thought it would help
> to shut up the namespace pollution whiners (the debate of /dbg versus
> /sys/kernel/debug was rather mild by comparison).

Getting a major number should be no problem and the minor partitioning
is also easy, because the root hubs are already numbered by USB.

> It should make little difference for the tool anyway, the base path ought to
> be configurable. The biggest difference would be to scripts which launch the
> tool: in one case they need to mount debugfs if not mounted (if initscripts
> haven't), in other case they mknod if necessary (if hal hasn't done it).

The mknod reason is no reason for, because we have udev (not hal btw)
and this working perfect.

> It is too early to care about this anyway.

Since I am really thinking of writing usbdump, it is not to early. What
stuff is missing in your usbmon patch?

Regards

Marcel


