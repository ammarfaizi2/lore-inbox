Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbULNR1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbULNR1y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 12:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbULNR1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 12:27:54 -0500
Received: from aun.it.uu.se ([130.238.12.36]:56461 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261322AbULNR1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 12:27:52 -0500
Date: Tue, 14 Dec 2004 18:27:38 +0100 (MET)
Message-Id: <200412141727.iBEHRcaj012562@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: cfriesen@nortelnetworks.com, linux-kernel@vger.kernel.org
Subject: Re: how to add 32/64 compatible ioctls at runtime via module?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2004 10:39:14 -0600, Chris Friesen wrote:
>I'm working on a driver for 2.6.
>
>I'd like to be able to load the driver as a module, and have it register for 
>various ioctl() calls on a device node (which can be dynamic, so no problem there).
>
>I'm not sure how to go about registering at runtime for 32/64 bit compatibility 
>so that I can load a module into a ppc64 kernel, and have 32-bit userspace code 
>call those ioctls.
>
>Can anyone give some pointers, or direct me to existing code?

register_ioctl32_conversion(ioctl, handler)

tells your 64-bit kernel that the given ioctl, when issued by
a 32-bit mode task, should be routed to the given handler.
The handler can be NULL, in which case the ioctl is routed to
the normal handler via the filp.

/Mikael
