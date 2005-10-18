Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbVJRTgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbVJRTgV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 15:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbVJRTgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 15:36:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49639 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751473AbVJRTgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 15:36:20 -0400
Date: Tue, 18 Oct 2005 15:29:19 -0400
From: Jeff Bailey <jbailey@ubuntu.com>
Subject: Re: Keep initrd tasks running?
In-reply-to: <4355494C.5090707@comcast.net>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org, ubuntu-devel <ubuntu-devel@lists.ubuntu.com>
Message-id: <1129663759.18784.98.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Evolution 2.4.1
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: 8BIT
References: <4355494C.5090707@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 18 octobre 2005 à 15:13 -0400, John Richard Moser a écrit :
> I have no idea who's the best to ask for this.
> 
> I want to start a task in an initrd and have it stay running after init
> is started.  Pretty much:

> What's the feasibility of this without the system balking and vomiting
> chunks everywhere?  I'm pretty sure 'exec /sbin/init' from linuxrc
> (PID=1) will replace the process image of sh (linuxrc) with init,
> keeping PID=1; but I'm worried this may terminate children too.  Haven't
> tried.

This is much more easily supported in Breezy.  usplash is started at the
top of the initramfs (from the init-top hook) and lives until we start
gdm.

The biggest constraint is that you don't have write access to the target
root filesystem (since it's mounted readonly).  However, /dev is a tmpfs
that is move mounted to the new root system.  If you need to have
sockets open or store data, you can use that.  usplash does this for its
socket.

Note that the initramfs startup sequence isn't at all similar to the old
initrd startups.  It should be easy for you to cleanly add what you want
under /etc/mkinitramfs/scripts and not have to modify the
initramfs-tools package.  /usr/share/doc/initramfs-tools/HACKING
contains some starter information.

Hope this helps!

Tks,
Jeff Bailey



