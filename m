Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270248AbTG2CN0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 22:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271224AbTG2CN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 22:13:26 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:34688 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S270248AbTG2CNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 22:13:24 -0400
Date: Tue, 29 Jul 2003 04:13:21 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: =?iso-8859-2?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <0@pervalidus.tk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: matroxfb and 2.6.0-test2
Message-ID: <20030729021321.GA1282@vana.vc.cvut.cz>
References: <Pine.LNX.4.56.0307281958410.193@pervalidus.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.56.0307281958410.193@pervalidus.dyndns.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 08:34:40PM -0300, Frédéric L. W. Meunier wrote:
> The card is a Matrox Millenium G400 M4A32DG (single head).
> 
> 2.6.0-test2 is the first 2.5.x I try, so I may be missing
> something.
> 
> During make modules_install I noticed the following warning
> (yes, I installed the latest module-init-tools):
> 
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.0-test2; fi
> WARNING: /lib/modules/2.6.0-test2/kernel/drivers/video/matrox/matroxfb_crtc2.ko
> needs unknown symbol matroxfb_enable_irq

Yes, I'll fix that. Arpi pointed that out to me when I backported
IRQ support to the 2.4.x. Just adding

EXPORT_SYMBOL(matroxfb_enable_irq);

at the end of drivers/video/matrox/matroxfb_base.c does the trick.
 
> I don't know if it's serious but then I rebooted from 2.4.21.
> 
> My init script contains
> 
> if lspci | grep -q 'MGA G400'; then
> modprobe matroxfb_base
> fi
> 
> and /etc/modprobe.conf options matroxfb_base vesa=440
> 
> After it the screen became corrupted with a dump of my last
> shutdown. All commands still worked. I don't use fbset at all.
> The logs don't have anything about matroxfb.

Try building matroxfb into the kernel. I believe that current VT system
does not take over console anymore if fbdev is loaded after fbcon, but
I never tested it myself.
							Petr Vandrovec

