Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318815AbSHWOZZ>; Fri, 23 Aug 2002 10:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318816AbSHWOZZ>; Fri, 23 Aug 2002 10:25:25 -0400
Received: from pD9E2385F.dip.t-dialin.net ([217.226.56.95]:54168 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318815AbSHWOZY>; Fri, 23 Aug 2002 10:25:24 -0400
Date: Fri, 23 Aug 2002 08:29:20 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
cc: Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre4-ac1 (this time regarding 2.5.31)
In-Reply-To: <3D664167.44A188CC@eyal.emu.id.au>
Message-ID: <Pine.LNX.4.44.0208230826180.3234-100000@hawkeye.luckynet.adm>
X-Location: Potsdam-Babelsberg; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 24 Aug 2002, Eyal Lebedinsky wrote:
> linux/drivers/usb/brlvger.c compile error
> 
> You would think that gcc, having had the same problem for a while,
> would have smarted up by now. And they say computers are our
> future...

Can't believe! In 2.5 we still use concatenation w/__FUNCTION__.

#define dbgprint(args...) \
    ({ printk(KERN_DEBUG "Voyager: " __FUNCTION__ ": " args); \
       printk("\n"); })

Shall we fix it?

#define dbgprint(args...) \
	printk(KERN_DEBUG "Voyager: %s: " args "\n", __FUNCTION__ );

should cut it, but

#define dbgprint(fmt, args...) \
	printk(KERN_DEBUG "Voyager: %s: " fmt "\n", __FUNCTION__ , args);

might be better.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

