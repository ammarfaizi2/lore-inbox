Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275353AbTHGOmq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275365AbTHGOmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:42:46 -0400
Received: from Mix-Lyon-107-1-204.w193-249.abo.wanadoo.fr ([193.249.22.204]:27008
	"EHLO gaston") by vger.kernel.org with ESMTP id S275353AbTHGOmh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:42:37 -0400
Subject: Re: [Linux-fbdev-devel] [PATCH] Framebuffer: 2nd try: client
	notification mecanism & PM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@suse.cz>
Cc: James Simmons <jsimmons@infradead.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20030807100309.GB166@elf.ucw.cz>
References: <Pine.LNX.4.44.0308070000540.17315-100000@phoenix.infradead.org>
	 <1060249101.1077.67.camel@gaston>  <20030807100309.GB166@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060267031.722.3.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 07 Aug 2003 16:37:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I believe solution to this is simple: always switch to kernel-owned
> console during suspend. (swsusp does it, there's patch for S3 to do
> the same). That way, Xfree (or qtopia or whoever) should clean up
> after themselves and leave the console to the kernel. (See
> kernel/power/console.c)

I tried using it on pmac, but it causes hell with XFree. I'm not sure
what's up yet, I suspect it may be XFree still doing things after
calling the RELDISP ioctl but I'm not completely sure yet.

The setup XFree + DRI is working without switching to suspend console
(with only the apm_bios emulation for XFree to suspend/restore itself)
but not when switching to suspend console right before doing the apm
emulation callbacks (which should be ignored by X since it's no longer
the frontmost process at this point).

For some reason, it seems that after we have switched to the suspend
console, we race with the X server on accel engine, and on resume, the X
server just crashes.

Ben.
 
