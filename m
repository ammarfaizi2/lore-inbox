Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263731AbUGLVjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbUGLVjV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 17:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbUGLVjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 17:39:21 -0400
Received: from mail.gurulabs.com ([67.137.148.7]:50604 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S263731AbUGLVjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 17:39:19 -0400
Subject: Re: pcmcia on the T42p
From: Dax Kelson <dax@gurulabs.com>
To: Rasmus Lerdorf <rasmus@lerdorf.com>
Cc: linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
In-Reply-To: <Pine.LNX.4.58.0407102320180.1145@t42p>
References: <Pine.LNX.4.58.0407102320180.1145@t42p>
Content-Type: text/plain
Message-Id: <1089668369.3848.25.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 12 Jul 2004 15:39:29 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-07-11 at 00:27, Rasmus Lerdorf wrote:
> You mentioned you couldn't get your T42 to see any pcmcia events with a
> Cisco Aironet 350 card.  I just tried it on mine and it worked fine.  I
> didn't boot with it and plugged it in and it came right up.  cardctl eject
> and re-inserted it about 10 times and each time it came back up fine.

More details and resolution.

When I tried Debian stable (with a 2.4 kernel), everything worked great
including audible "beeps" when I inserted/removed PCMCIA cards.

I upgraded to Debian testing and then unstable with the 2.6.7 kernel and
PCMCIA devices would only work if inserted prior to booting. This
matched my Fedora Core v2 experience with the latest errata kernel, or
with 2.6.7-mm.

With Debian testing/unstable using the Debian stable 2.4 kernel
everything was peachy.

I found that loading the BIOS default setting that made everything work
(minus the audible beeps). The default BIOS settings has a screen where
all IRQs are *forced* to be IRQ 11, and sure enough, cat
/proc/interrupts showed everything on 11. I had changed it to "Auto"
instead of "11" and cat /proc/interrupts showed everything spread
around. Everything seemed to work great, except PCMCIA.

Resetting my BIOS back to defaults and now PCMCIA hotplug is working.

It seems that it *should* work with interrupts not all clumped up on
IRQ 11 (and indeed, Windows does work with that config), but for now
at least, my PCMCIA slots are working.

Dax Kelson

