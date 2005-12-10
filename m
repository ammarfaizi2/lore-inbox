Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbVLJOck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbVLJOck (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 09:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbVLJOcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 09:32:39 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:21086 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932414AbVLJOcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 09:32:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=BP8CGDg16lZQr0bWLWzEwlZq8vnThvOb8J/uhlzAuA6cn8C6OHNBDG/ENQCdWWpCx/BMznzd5mgqLh4Lhwz/l6gFRnz6tCi3uhRwdQeuXO40LAseOI40LNhisSETvwlMSrGeYT0x+h3Hxfki0o1X451uS4TiecsYAdFCE1yL1Pk=
Message-ID: <439AE6EF.6070006@gmail.com>
Date: Sat, 10 Dec 2005 22:32:15 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Knut Petersen <Knut_Petersen@t-online.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/1 2.6.15-rc4-git1] Fixing switch to KD_TEXT, enhanced
 version
References: <439A81AE.5030509@t-online.de>
In-Reply-To: <439A81AE.5030509@t-online.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Knut Petersen wrote:
> Every framebuffer driver relies on the assumption that the
> set_par() function of the driver is called before drawing
> functions and other functions dependent on the hardware
> state are executed.
> 
> Whenever you switch from X to a framebuffer console for the
> very first time, there is a chance that a broken X system has
> _not_ set the mode to KD_GRAPHICS, thus the vt and framebuffer
> code executes a screen redraw and several other functions
> before a set_par() is executed. This is believed to be not a
> bug of linux but a bug of X/xdm. At least some X releases
> used by SuSE and Debian show this behaviour.
> 
> There was a 2nd case, but that has been fixed by Antonino
> Daplas on 10-dec-2005.
> 
> This patch allows drivers to set a flag to inform fbcon_switch()
> that they prefer a set_par() call on every console switch,
> working around the problems caused by the broken X releases.
> 
> The flag will be used by the next release of cyblafb and might
> help other drivers that assume a hardware state different to
> the one used by X.
> 
> As the default behaviour does not change, this patch should
> be acceptable to everybody.
> 
> Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>

Acked-by: Antonino Daplas <adaplas@pol.net>

> +#define FBINFO_MISC_ALLWAYS_SETPAR   0x40000
                       ^^^^^^^
Please post a follow up patch to fix the spelling.

Tony
