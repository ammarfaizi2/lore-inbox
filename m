Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262268AbVBBTDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbVBBTDW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 14:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVBBS6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 13:58:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44680 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262349AbVBBSy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 13:54:59 -0500
Date: Wed, 2 Feb 2005 10:54:54 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       zaitcev@redhat.com
Subject: Re: Patch to add usbmon
Message-ID: <20050202105454.3f85dbdf@localhost.localdomain>
In-Reply-To: <1107362417.11944.7.camel@pegasus>
References: <20050131212903.6e3a35e5@localhost.localdomain>
	<20050201071000.GF20783@kroah.com>
	<20050201003218.478f031e@localhost.localdomain>
	<1107256383.9652.26.camel@pegasus>
	<20050201095526.0ee2e0f4@localhost.localdomain>
	<1107293870.9652.76.camel@pegasus>
	<20050201215936.029be631@localhost.localdomain>
	<1107362417.11944.7.camel@pegasus>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Feb 2005 17:40:17 +0100, Marcel Holtmann <marcel@holtmann.org> wrote:

> While I am really thinking about starting usbdump, I may ask why you
> have choosen to use debugfs as interface. This will not be available in
> normal distribution kernels and I think a general USB monitoring ability
> would be great. For example like we have it for Ethernet, Bluetooth and
> IrDA. So my idea is to create some /dev/usbmonX (for each bus one) where
> usbdump can read its information from. What do you think?

The debugfs will be available in distributions. And it's no different from
having SOCK_PACKET enabled before tcpdump can work. There's no practical
disadvantage, unless we consider a backport of usbmon into a legacy distribution
such as RHEL 4 or SuSE 9.1.

Since usbmon rides raw file_operations, it can use a chardev interface with
a minimal change. The advantage of debugfs is only not needing to allocate
a major and dealing with minor partitioning. I also thought it would help
to shut up the namespace pollution whiners (the debate of /dbg versus
/sys/kernel/debug was rather mild by comparison).

It should make little difference for the tool anyway, the base path ought to
be configurable. The biggest difference would be to scripts which launch the
tool: in one case they need to mount debugfs if not mounted (if initscripts
haven't), in other case they mknod if necessary (if hal hasn't done it).
It is too early to care about this anyway.

-- Pete
