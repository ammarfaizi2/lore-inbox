Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTDKWBe (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbTDKWBe (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:01:34 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:2696 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S261823AbTDKWBd (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 18:01:33 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Greg KH <greg@kroah.com>
Subject: Re: [ANNOUNCE] udev 0.1 release
Date: Sat, 12 Apr 2003 00:12:43 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <20030411204329.GT1821@kroah.com> <200304112111.h3BLBWgu025834@post.webmailer.de> <20030411215755.GX1821@kroah.com>
In-Reply-To: <20030411215755.GX1821@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304120012.43051.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 April 2003 23:57, Greg KH wrote:

> No, you want to make sure you have the same "name" after that.  As any
> userspace apps that had a open file on the original disks are basically
> screwed anyway, we want a way to enable them to recover nicely.
>
> And no, I don't want to go into the whole, remove a device and plug it
> back in, and userspace never noticed the difference while it held an
> open file handle.  That's a problem I don't want to even go near right
> now, and is totally different from what udev is trying to do :)

Ok, but that still leaves the race between creation and removal of devices
files. In my scenario three different bad things can happen:

- The file is removed after the device is added
- The file is added when the device is already unplugged again
- The file gets added with the wrong device number -> worst case

This can be avoided by completely serializing all events, both inside
the kernel and the execution of /sbin/hotplug,  but that might cause
significant downtime.

	Arnd <><
