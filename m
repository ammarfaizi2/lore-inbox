Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270691AbTGUUAX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 16:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270692AbTGUUAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 16:00:23 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:1483 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S270691AbTGUUAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 16:00:18 -0400
Date: Mon, 21 Jul 2003 22:14:17 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: James Simmons <jsimmons@infradead.org>, Amit Shah <shahamit@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1: Framebuffer problem
In-Reply-To: <1058620026.22005.0.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.GSO.4.21.0307212205550.27306-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Jul 2003, Alan Cox wrote:
> On Sad, 2003-07-19 at 07:02, Geert Uytterhoeven wrote:
> > No, that's not so simple, because vesafb requests the linear frame buffer,
> > while vga16fb requests the VGA region.

Correction:
  - vesafb uses
      o request_mem_region() on the linear frame buffer
      o request_region() on the 32 VGA registers (but the return code is
	ignored because of vgacon)
  - vga16fb doesn't use resource management (ugh)
  - vgacon uses
      o request_region() on the MDA/CGA/EGA/VGA registers

> In standard usage mode both of them use the vga registers for palette control..

Vesafb may use a protected mode BIOS call instead.

An additional complexity is that not only vesafb/vga16fb may claim the VGA
registers, but also vgacon. And it's allowed for vesafb/vga16fb to take over
vgacon.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

