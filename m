Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269316AbUJFQDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269316AbUJFQDP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 12:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269206AbUJFQDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 12:03:15 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:11435 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269316AbUJFQDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 12:03:04 -0400
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is
	availlable
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Greg KH <greg@kroah.com>, J?rn Engel <joern@wohnheim.fh-wedel.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041005221333.L6910@flint.arm.linux.org.uk>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de>
	 <20041005212712.I6910@flint.arm.linux.org.uk>
	 <20041005210659.GA5276@kroah.com>
	 <20041005221333.L6910@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097074822.29251.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 06 Oct 2004 16:00:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-10-05 at 22:13, Russell King wrote:
> I'm redirecting them in the /sbin/hotplug script to something sane,
> but I think the kernel itself should be directing these three fd's
> to somewhere whenever it invokes any user program, even if it is
> /dev/null.

Someone should yes. There are lots of fascinating things happen when
hotplug opens a system file, it gets assigned fd 2 and then we write to
stderr.

> I think Alan disagrees with me, but I think the history that these
> types of problems _keep_ cropping up over and over is proof enough
> that it's necessary for sane userspace.

Userspace to userspace execution is quite precisely defined. What
happens for kernel->userspace isn't so I have no problem with the kernel
attaching hotplug to the system console.
