Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932802AbWJINKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932802AbWJINKz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 09:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932801AbWJINKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 09:10:55 -0400
Received: from witte.sonytel.be ([80.88.33.193]:4069 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S932799AbWJINKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 09:10:54 -0400
Date: Mon, 9 Oct 2006 15:09:34 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Kyle Moffett <mrmacman_g4@mac.com>, David Howells <dhowells@redhat.com>,
       Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, sfr@canb.auug.org.au,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in
 the kernel [try #4]
In-Reply-To: <Pine.LNX.4.61.0610091416290.4279@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.62.0610091508240.16048@pademelon.sonytel.be>
References: <Pine.LNX.4.61.0610062250090.30417@yvahk01.tjqt.qr>
 <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com>
 <Pine.LNX.4.61.0610062232210.30417@yvahk01.tjqt.qr> <20061006203919.GS2563@parisc-linux.org>
 <5267.1160381168@redhat.com> <Pine.LNX.4.61.0610091032470.24127@yvahk01.tjqt.qr>
 <EE65413A-0E34-40DA-9037-72423C18CD0C@mac.com> <Pine.LNX.4.61.0610091416290.4279@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2006, Jan Engelhardt wrote:
> >> > > > Were you planning on porting Linux to a machine with
> >> > > > non-8-bit-bytes any
> >> > > > time soon?  Because there's a lot more to fix than this.
> >> > > 
> >> > > I am considering the case [assuming 8-bit-byte machines] where
> >> > > sizeof(u32) is not 4. Though I suppose GCC will probably make a
> >> > > 32-bit
> >> > > type up if the hardware does not know one.
> >> > 
> >> > If the machine has 8-bit bytes, how can sizeof(u32) be anything other
> >> > than 4?
> >> 
> >> typedef unsigned int u32;
> >> 
> >> Though this should not be seen in the linux kernel.
> >
> > Well, uhh, actually...
> >
> > All presently-supported architectures do exactly that.  Well, some do:
> >
> > typedef unsigned int __u32;
> > #ifdef __KERNEL__
> > typedef __u32 u32;
> > #endif
> 
> Ouch ouch ouch. It should better be
> 
> typedef uint32_t __u32;

You mean

#ifdef __KERNEL__
typedef __u32 u32;
#else
// Assumed we did #include <stdint.h> before
typedef uint32_t __u32;
#endif

?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
