Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269456AbUJFUg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269456AbUJFUg5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 16:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269453AbUJFU2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:28:41 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:45227 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269471AbUJFUVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:21:38 -0400
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is
	availlable
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041006174108.GA26797@kroah.com>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de>
	 <20041005212712.I6910@flint.arm.linux.org.uk>
	 <20041005210659.GA5276@kroah.com>
	 <20041005221333.L6910@flint.arm.linux.org.uk>
	 <1097074822.29251.51.camel@localhost.localdomain>
	 <20041006174108.GA26797@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097090333.29706.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 06 Oct 2004 20:18:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-10-06 at 18:41, Greg KH wrote:
> Good point.  So, should we do it in the kernel, in call_usermodehelper,
> so that all users of this function get it correct, or should I do it in
> userspace, in the /sbin/hotplug program?
> 
> Any opinions?

Userspace is more flexible. What does the kernel do if it can't figure
out what to open as fd 0, 1, 2. Either it explodes or asks user space.
While /sbin/hotplug can mknod itself a private /dev/null and
/dev/console in an emergency.
