Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbVCAMtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVCAMtk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 07:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVCAMtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 07:49:40 -0500
Received: from smtp-out.hotpop.com ([38.113.3.61]:45541 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261890AbVCAMti
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 07:49:38 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net, Adrian Bunk <bunk@stusta.de>,
       adaplas@pol.net
Subject: Re: [Linux-fbdev-devel] RFC: disallow modular framebuffers
Date: Tue, 1 Mar 2005 20:49:25 +0800
User-Agent: KMail/1.5.4
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050301024118.GF4021@stusta.de>
In-Reply-To: <20050301024118.GF4021@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503012049.25809.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 March 2005 10:41, Adrian Bunk wrote:
> Hi,
>
> while looking how to fix modular FB_SAVAGE_* (both FB_SAVAGE_I2C=m and
> FB_SAVAGE_ACCEL=m are currently broken) I asked myself:
>
> Do modular framebuffers really make sense?
>
> OK, distributions like to make everything modular, but all the
> framebuffer drivers I've looked at parse driver specific options in
> their *_setup function only in the non-modular case.
>
> And most framebuffer drivers contain a module_exit function.
> Is there really any case where this is both reasonable and working?

Only a few drivers are capable of being unloaded with the possiblity of
restoring the vga console (i810fb and rivafb), when CONFIG_FBCON = n.

If CONFIG_FBCON=y, it's not possible to unload the module unless 2 drivers
are loaded at the same time. One driver can be mapped to the console, so the
other can be unloaded.  Although not important from the user's POV, it is
quite helpful when debugging/developing drivers.

Currently fbcon cannot be unloaded, it will freeze the system.

Tony


