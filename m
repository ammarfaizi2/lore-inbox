Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbVLOSf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbVLOSf1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 13:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbVLOSf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 13:35:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:1453 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750880AbVLOSf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 13:35:26 -0500
Date: Thu, 15 Dec 2005 10:35:07 -0800
From: Greg KH <greg@kroah.com>
To: Patrick Fritzsch <fritzsch@cip.physik.uni-muenchen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: slow sync of fat 32 hotplugged devices
Message-ID: <20051215183506.GA16574@kroah.com>
References: <43A1B5B9.2040307@cip.physik.uni-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A1B5B9.2040307@cip.physik.uni-muenchen.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 07:28:09PM +0100, Patrick Fritzsch wrote:
> Hallo,
> I checked out suse10 lately and discovered some annoying behaviour in
> hotplugging an USB Stick.
> 
> It seems that the hal daemon mounts a usbstick in fat32 mode, where
> default the sync option ist on. Actually this is a nice behaviour,
> because a cp to the stick should last so long until the file was
> completly written.

This is a HAL issue, just have it mount without sync enabled and your
speed will return.

> Actually the performance is very bad. A 200 MB file needs around 10
> Minutes in sync mode, while it needs around 1 Minute in not synchronous
> mode + executing a sync command later.
> 
> I guess that the kernel checks after every block of the file, which is
> written, if the stick has really written it, which leads to such a big
> slowdown. There are already lots of comments of this in the web, where
> the solution is always to disable the sync mode in the hal daemon device
> files.
> 
> Wouldnt it be a nice behaviour, if you could mount a file in a new sync
> mode, where it isnt synchronized during writing a file, only when a
> close ioctl command was executed on a filehandle?
> sync writing to hotplugged devices would be a lot faster then.

Yes it would, and I'm pretty sure people are already working on this :)

But if you have some patches that enable this functionality already,
please post them.

thanks,

greg k-h
