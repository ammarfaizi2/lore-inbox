Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131647AbRCOEsY>; Wed, 14 Mar 2001 23:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131634AbRCOEsO>; Wed, 14 Mar 2001 23:48:14 -0500
Received: from falcon.prod.itd.earthlink.net ([207.217.120.74]:22941 "EHLO
	falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S131647AbRCOEsD>; Wed, 14 Mar 2001 23:48:03 -0500
Date: Wed, 14 Mar 2001 12:48:34 -0800 (PST)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Brad Douglas <brad@neruo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [RFC] fbdev & power management
Message-ID: <Pine.LNX.4.31.0103141239070.779-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>So the fbdev drivers would register PM with fbcon, not PCI, correct?
>
>Either that, or the fbdev would register with PCI (or whatever), _and_
>fbcon would too independently. In that scenario, fbcon would only handle
>things like disabling the cursor timer, while fbdev's would handle HW
>issues. THe only problem is for fbcon to know that a given fbdev is
>asleep, this could be an exported per-fbdev flag, an error code, or
>whatever. In this case, fbcon can either buffer text input, or fallback
>to the cfb working on the backed up fb image (that last thing can be
>handled entirely within the fbdev I guess).

Hi!
  I had to give it some thought. I like to see this handles inside the
fbdev driver itself instead of inside fbcon. For 2.5.X it will be possible
to use /dev/fb with vgacon. Even better yet it will be possible to use
just a serial console and not use a VT but still use /dev/fb. So we will
want to to have fbdev doing power management itself. As for handling the
cursors I recently purposed a standardize cursor api so X can use it as
well via userland and a standard fbcon_cursor can be written. With this
api it would be easy to handle suspending and restoring the cursor for
fbcon for /dev/fb.
  As for fbcon knowing when it is asleep. Hum. We could have a flags to
tell it to have text data updates to be placed in the shadow buffer
(struct vc_datas->vc_screenbuffer) only;

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

