Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265506AbTBBTJo>; Sun, 2 Feb 2003 14:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265508AbTBBTJo>; Sun, 2 Feb 2003 14:09:44 -0500
Received: from AMarseille-201-1-6-66.abo.wanadoo.fr ([80.11.137.66]:24946 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id <S265506AbTBBTJn> convert rfc822-to-8bit;
	Sun, 2 Feb 2003 14:09:43 -0500
Subject: Re: AGP aperture is 16MB @ 0x0
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gianni Tedesco <gianni@ecsc.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1044196570.6032.24.camel@lemsip>
References: <1044196570.6032.24.camel@lemsip>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1044213647.586.6.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 02 Feb 2003 20:20:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-02-02 at 15:36, Gianni Tedesco wrote:
> Hi,
> 
> I have a problem getting agpgart/drm to work on my TiBook, I have
> tracked the problem down to that suspect looking message.
> 
> agpgart: AGP aperture is 16MB @ 0x00
> [drm] AGP 0.99 on Unkiwn @ 0x00000000 16MB
> 
> which results in the following messages in my XFree86 logs:
> 
> [agp] ring handle = 0x0000000
> [agp] Could not map ring

Ok, things are a bit weird with UniNorth, AGP base beeing at 0
is actually correct. You probably need fixed DRM which can deal
with UniNorth weirdies. Ask Michel Dänzer <michel@daenzer.net>
for up to date patches against XFree DRI CVS

> Its an ATI Radeon 7500 Mobility M7 on an Apple UniNorth 1.5 chipset.
> 
> I think the correct aperture base is one of:
> 
> AGP special page: 0xdffff000
> aper_base: b8000000 MC_FB_LOC to: bbffb800, MC_AGP_LOC to: ffffc000

No. These are addresses in the card's address space, and things are
setup differently than what is displayed by this debug code actually ;)
What you see there is what I would like to program in the card, but I
had to disable this for now as it's incompatible with current XFree
radeon driver.

-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
