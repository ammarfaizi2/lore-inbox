Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264364AbTLVJaJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 04:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264367AbTLVJaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 04:30:09 -0500
Received: from mail.kroah.org ([65.200.24.183]:10410 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264364AbTLVJaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 04:30:05 -0500
Date: Mon, 22 Dec 2003 01:23:29 -0800
From: Greg KH <greg@kroah.com>
To: Scott James Remnant <scott@netsplit.com>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: udev LABEL not working: sysfs_path_is_file: stat() failed
Message-ID: <20031222092329.GA30235@kroah.com>
References: <1072054829.1225.11.camel@descent.netsplit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072054829.1225.11.camel@descent.netsplit.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 01:00:29AM +0000, Scott James Remnant wrote:
> [I am not subscribed to linux-kernel, please Cc: me on replies.]

The linux-hotplug-devel mailing list is best place for questions about
udev, not lkml...

> I'm having a problem getting udev to honour my LABEL lines in
> /etc/udev/udev.rules.  At the top of this I've got:
> 
> LABEL, BUS="usb", SYSFS_vendor="Fujifilm", SYSFS_model="FinePix 1400Zoom", NAME="camera"

Try changing BUS="usb" to BUS="scsi".  Also make sure that the model
file doesn't contain any trailing spaces.  That's a very common thing on
usb devices.

And you are trying to match up 2 files, right now udev only supports 1,
so the last one (model) is used.  The vendor rule there is ignored.

There is also a problem with udev beating the kernel.  It can easily get
the hotplug event before the kernel has created the sysfs file.  I'm
currently working on fixing this in udev, should have it done by the
next release.  You can tell if you are seeing this race by just running
the test.block script in the test directory in udev.  If your device
node is created properly with that script, but not when you plug the
device in, you have that problem.

And people tried to tell us that the hotplug interface was slow without
ever testing it out...

Hope this helps,

greg k-h
