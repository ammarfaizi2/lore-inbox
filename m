Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262302AbSJ0Hl5>; Sun, 27 Oct 2002 02:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262303AbSJ0Hl5>; Sun, 27 Oct 2002 02:41:57 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:25100 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262302AbSJ0Hl4>;
	Sun, 27 Oct 2002 02:41:56 -0500
Date: Sun, 27 Oct 2002 08:48:09 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Miles Bader <miles@gnu.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: linux-2.5.44uc1 (MMU-less support)
Message-ID: <20021027074809.GA985@mars.ravnborg.org>
Mail-Followup-To: Miles Bader <miles@gnu.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <fa.fd5mvtv.9gon33@ifi.uio.no> <87iszosf2g.fsf@tc-1-100.kawasaki.gol.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87iszosf2g.fsf@tc-1-100.kawasaki.gol.ne.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2002 at 01:04:07PM +0900, Miles Bader wrote:
> It may be more readable, but I don't think you can say it's the `normal way
> of doing it,' at least in linux -- almost all the arch Makefiles have code
> pretty much identical to Greg's (presumably all derived from a single
> original source).
> 
> Perhaps they should all be changed.
Well, most arch Makefiles could use some cleaning up - also with respect
to te construct above. My point was that there is no need to list
prerequisites as several rules when they can be combined as one.
And the fact that a temporary is generated could well be hidden.
By the way I made a mistake, it should be:

include/asm-$(ARCH)/asm-offsets.h: arch/$(ARCH)/kernel/asm-offsets.s \
                                 include/asm include/linux/version.h \
                                 include/config/MARKER
	@echo -n '  Generating $@'
	@$(generate-asm-offsets.h) < $< > $@.tmp
	@$(update-if-changed)

	Sam
