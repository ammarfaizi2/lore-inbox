Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030666AbWLET7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030666AbWLET7G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 14:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030822AbWLET7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 14:59:06 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34669 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030666AbWLET7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 14:59:03 -0500
Date: Tue, 5 Dec 2006 19:59:01 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Yu Luming <luming.yu@gmail.com>,
       Miguel Ojeda Sandonis <maxextreme@gmail.com>
Subject: Re: -mm merge plans for 2.6.20
In-Reply-To: <20061205114310.e85d4c7e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612051946280.14114@pentafluge.infradead.org>
References: <20061204204024.2401148d.akpm@osdl.org>
 <Pine.LNX.4.64.0612051538280.15711@pentafluge.infradead.org>
 <20061205100140.24888a96.akpm@osdl.org> <Pine.LNX.4.64.0612051822140.7917@pentafluge.infradead.org>
 <20061205114310.e85d4c7e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > > video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register.patch
> > > > 
> > > > Does this patch update the fbdev drivers?
> > > 
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc6/2.6.19-rc6-mm2/broken-out/video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register.patch
> > > 
> > > Seems not.  Should it?
> > 
> > Yes. Its bizarre.
> 
> It is.
> 
> > The drivers compile with the wrong method prototype.
> 
> No, it doesn't get compiled at all.
> 
> CONFIG_FB_ATY128_BACKLIGHT has no Kconfig record at all.
> 
> CONFIG_FB_NVIDIA_BACKLIGHT has no Kconfig record at all.
> 
> CONFIG_FB_RIVA_BACKLIGHT has no Kconfig record at all.
> 
> So this is all dead code.  There is no way to enable any of it within the
> config system.

Ug. Kconfig in drivers/video has all the above drivers enable the 
backlight only if PMAC_BACKLIGHT is set. The problem is backlight
is after the framebuffer. We should move the backlight menu before
the framebuffer configuration.

