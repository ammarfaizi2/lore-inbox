Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271756AbTG2OXd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 10:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271808AbTG2OXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 10:23:33 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:13553 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271756AbTG2OWl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 10:22:41 -0400
Subject: Re: 2.4.22-pre4: devfs on initrd stays busy after pivot_root
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreas Haumer <andreas@xss.co.at>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3F267FD7.4040400@xss.co.at>
References: <Pine.LNX.4.55L.0307091918400.5325@freak.distro.conectiva>
	 <3F267FD7.4040400@xss.co.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059488195.3439.7.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Jul 2003 15:16:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-29 at 15:08, Andreas Haumer wrote:
> Beginning with 2.4.22-pre4 I can't unmount devfs on my
> initial ramdisk anymore because of EBUSY
> 
> I use initrd and let the kernel mount devfs on /dev on boot.
> I then set up all the drivers needed to mount the real root
> device, do a "pivot_root" and continue with /sbin/init,
> just like it is described in Documentation/initrd.txt

The kernel opens /dev/tty but doesn't close it on the thread
that isnt forking and execing init. Its on my todo list. 
Basically a crazy piece of the old setup broke because we
imposed sanity. Fixing it however may require a little thought

