Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262924AbSJOPQW>; Tue, 15 Oct 2002 11:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263137AbSJOPQU>; Tue, 15 Oct 2002 11:16:20 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:43531 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262924AbSJOPQR>;
	Tue, 15 Oct 2002 11:16:17 -0400
Date: Tue, 15 Oct 2002 17:22:01 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, kai.germaschewski@gmx.de,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.5.42 broke ARM zImage/Image
Message-ID: <20021015172201.A1406@mars.ravnborg.org>
Mail-Followup-To: Russell King <rmk@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org, kai.germaschewski@gmx.de,
	Linus Torvalds <torvalds@transmeta.com>
References: <20021012123256.C12955@flint.arm.linux.org.uk> <20021012233818.A9394@mars.ravnborg.org> <20021015002243.F2902@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021015002243.F2902@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Tue, Oct 15, 2002 at 12:22:43AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 12:22:43AM +0100, Russell King wrote:
> Sam & Kai, lkml and others who join us on this happy day.
> 
> So, basically, I'm screwed at the moment, unless someone has anything
> else to suggest.
How about a simple workaround for now:

$(obj)/vmlinux: $(obj)/$(HEAD) $(obj)/piggy.o $(obj)/vmlinux.lds \
                $(addprefix $(obj)/, $(OBJS))
	cp $(obj)/piggy.o .
        $(call if_changed,ld)
	rm piggy.o

I onther words just make a temporary copy of piggy.o in current directory.
No changes needed in .lds file.

Untested!

I do not know the linker command language, but I assume there is some
way to do this even with piggy.o located somewhere else than current
directory.

My suggestion is a simple workaround to make the arm kernel compile, not
something I would like to see as a permanent solution.

	Sam
