Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267334AbUJRVT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267334AbUJRVT2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 17:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267361AbUJRVRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 17:17:12 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:16244 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267400AbUJRVQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 17:16:20 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=nep5l8C5dxsIWD8miouCaMi+ddZeKkHSDVA3ybFBdm2/rGfo1I1ksEyQpqpj4AnHjAUgh62N+EjYKeImE99RcBt5z09kmhG63JWXGtRF89O9tjeliegjnx4xNbzcf9oOGQJTtxN5N2OpnOQCfX9pc9R4aVXrD+2LTr48wGqnn6E
Message-ID: <9e47339104101814166bf4cfe5@mail.gmail.com>
Date: Mon, 18 Oct 2004 17:16:15 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <417428F2.2050402@bitworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200410160946.32644.adaplas@hotpop.com>
	 <4173B865.26539.117B09BD@localhost> <417428F2.2050402@bitworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004 15:34:58 -0500, Richard Smith <rsmith@bitworks.com> wrote:
> Kendall Bennett wrote:
> >
> > I would assume however a serial port console would be fine for embedded
> > machines until the framebuffer driver could come up anyway.
> > 
> This would be an incorrect assumption.  Speaking as a developer of one
> said embedded system I must have video at boot and be able to dump
> critical kernel messages to the screen.

I don't see it as the kernel's responsibility to compensate for lack
of something in an embedded system's BIOS. Embedded programmers are
free to go in and add basic display code to their arch specific
directories for printing out this class of messages. Better yet would
be to fix the embedded ROM to support basic display.

What I don't want to do is get a graphics driver system capable of
supporting multi-head console and openGL running before the kernel
initializes. I'm also trying to move big chunks of the display system
(vm86 reset and EDID) out of the kernel and into user space in order
to reduce the size of the graphic drivers. Moving this code means that
the full display system can not initialize until at least early user
space is running.

Every system has to be able to somehow indicate that it can find/load the
kernel image or that the image is corrupt or that hardware diagnostics failed.
Displaying this info is the responsibility of the BIOS.

-- 
Jon Smirl
jonsmirl@gmail.com
