Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbVKMLGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVKMLGW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 06:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbVKMLGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 06:06:22 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:19377 "EHLO
	pilet.ens-lyon.fr") by vger.kernel.org with ESMTP id S932395AbVKMLGV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 06:06:21 -0500
Date: Sun, 13 Nov 2005 12:06:18 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, Jason <dravet@hotmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vgacon: Workaround for resize bug in some chipsets
Message-ID: <20051113110618.GD4117@implementation>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	"Antonino A. Daplas" <adaplas@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Dave Jones <davej@redhat.com>, Jason <dravet@hotmail.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <43766AC5.9080406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43766AC5.9080406@gmail.com>
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonino A. Daplas, le Sun 13 Nov 2005 06:20:53 +0800, a écrit :
> "I updated to the development kernel and now during boot only the top of the
> text is visable. For example the monitor screen the is the lines and I can
> only  see text in the asterik area.
> ---------------------
> | ****************  |
> | *              *  |
> | *              *  |
> | ****************  |
> |                   |
> |                   |
> |                   |
> ---------------------

Are you missing some left and right part too? What are the dimensions of
the text screen at bootup? What bootloader are you using? (It could be a
bug in the boot up text screen dimension discovery).

> I have a Silicon Graphics 1600sw LCD panel with a Number Nine Revolution 4
> video card."

Does vgacon.c properly discovers that it is a VGA board?

> This bug seems to be a glitch in the VGA core of this chipset.  Resizing
> the screen triggers the mentioned bug.

Do vga-only games (like old DOS-mode games) work with it?

> The workaround is to make vgacon avoid calling vgacon_doresize() if the
> display parameters did not change.

I.e. never call it, actually.

> A definitive fix will need to be provided by someone who knows and has the
> hardware.

I'm not sure it is hardware-specific. Maybe you have a combination of
vga bios/bootloader/vga=ask/... that prevents vgacon.c from properly
discovering the dimensions of the text screen.


Well, else it looks like a "safe side" patch: people now hit by such bug
won't be hit any more unless using stty or such.

Regards,
Samuel
