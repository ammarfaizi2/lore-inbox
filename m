Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbULPTeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbULPTeF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 14:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbULPTeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 14:34:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32737 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261989AbULPTeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 14:34:00 -0500
Date: Thu, 16 Dec 2004 11:33:57 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: debugfs in the namespace
Message-ID: <20041216113357.4c2714bb@lembas.zaitcev.lan>
In-Reply-To: <20041216190835.GE5654@kroah.com>
References: <20041216110002.3e0ddf52@lembas.zaitcev.lan>
	<20041216190835.GE5654@kroah.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2004 11:08:35 -0800, Greg KH <greg@kroah.com> wrote:

> On Thu, Dec 16, 2004 at 11:00:02AM -0800, Pete Zaitcev wrote:
> > what is the canonic place to mount debugfs: /debug, /debugfs, or anything
> > else? The reason I'm asking is that USBMon has to find it somewhere and
> > I'd really hate to see it varying from distro to distro.
> 
> Hm, in my testing I've been putting it in /dbg, but I don't like vowels :)

Oh, that's right: usr and creat. How could I forget.

> Anyway, I don't really know.  /dev/debug/ ?  /proc/debug ?  /debug ?
> 
> What do people want?  I guess it's time to write up a LSB proposal :(

I use /debug but it's not too late to change. Fedora does not ship it yet,
so I don't think we have an institutional opinion about it.

Personally, I'm against the doubles to prevent issues with the mounting
order on boot, but that's rather weak. The /dev can be specially managed
and I'm concerned with people running find(1) on it. The /proc sounds
better, but mounting anything under /proc requires a kernel component
to create a directory, does it not?

[root@lembas root]# mount -t debugfs any /proc/debug
mount: mount point /proc/debug does not exist
[root@lembas root]# mkdir /proc/debug
mkdir: cannot create directory `/proc/debug': No such file or directory
[root@lembas root]# 

-- Pete
